#import "DataSourceButtonView.h"
#import "DataProvider.h"

@interface DataSourceButtonView ()

@property DataProvider* provider;

@property (nonatomic, strong) buttonCb callback;

@end

@implementation DataSourceButtonView

- (id)init {
    self = [super init];
    if (self) {
        self.provider = [[DataProvider alloc] init];
    }
    return self;
}

- (id)initWithCallback:(buttonCb)cb {
    self = [self init];
    [self setFrame:CGRectMake(0, 0, 500, 50)];
    [self loadButtonsWithCallback:cb];
    return self;
}

- (void)loadButtonsWithCallback:(buttonCb)cb {
    self.callback = cb;

    int i = 0;
    for (NSString* key in self.provider.dataSources) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(100 * i, 15, 100, 50);
        button.tag = i;
        [button setTitle:key forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(update:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        ++i;
    }
}

- (void)update:(id)sender {
    NSInteger i = ((UIButton*)sender).tag;
    NSDictionary* dataSources = self.provider.dataSources;
    self.callback([[dataSources allKeys] objectAtIndex:i],
                  [[dataSources allValues] objectAtIndex:i]);
}

@end
