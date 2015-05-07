#import "DataListController.h"
#import "RequestHelper.h"
#import "DataProvider.h"

@interface DataListController ()

@property (nonatomic, strong) RequestHelper* requestHelper;
@property (nonatomic, strong) DataProvider* provider;
@property (nonatomic, strong) NSArray* fetchedData;

@end

@implementation DataListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.requestHelper = [[RequestHelper alloc] init];
    self.provider = [[DataProvider alloc] init];
    [self loadButtons];
}

- (void)loadButtons {
    void(^cb)(NSString*, NSString*) = ^(NSString *key, NSString *url) {
        NSLog(@"Getting key %@ from data list", key);

        // first off, remove everything
        [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        [self displayDataForKey:key andURL:url];
    };
    [self setButtonView:
     [[DataSourceButtonView alloc] initWithCallback:cb]];
    [self.view addSubview:self.buttonView];
}

- (void)displayDataForKey:(NSString*)key andURL:(NSString*)url {
    NSDictionary* data = [self.requestHelper doJSONQuery:url];
    self.fetchedData = data[@"records"];
    int i = 0;
    
    for (NSDictionary* record in self.fetchedData) {
        NSDictionary* fields = record[@"fields"];
        NSString* title = [self.provider getTitle: fields];

        UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(40, (30 * i), 500, 50);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.tag = i;
        [button addTarget:self
                   action:@selector(alertAddress:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        ++i;
    }
    
    [self.scrollView setContentSize:CGSizeMake(500, 200 + (30 * i))];
}

- (void)alertAddress:(id)sender {
    if (self.fetchedData == nil) {
        return;
    }
    
    UIButton* button = (UIButton*)sender;
    NSInteger i = button.tag;
    
    NSDictionary* fields = [[self.fetchedData objectAtIndex:i]
                            objectForKey:@"fields"];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Adresse"
                          message:[self.provider getAddr:fields]
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}

@end
