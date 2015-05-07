#import <MapKit/MapKit.h>
#import "MapController.h"
#import "DataProvider.h"
#import "DataViewController.h"
#import "RequestHelper.h"

@import CoreLocation;

@interface MapController ()

@property (nonatomic, strong) RequestHelper* requestHelper;
@property (nonatomic, strong) DataProvider* provider;

@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationManager* locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];

    self.requestHelper = [[RequestHelper alloc] init];
    self.provider = [[DataProvider alloc] init];
    [self loadButtons];
}

- (void)loadButtons {
    void(^cb)(NSString*, NSString*) = ^(NSString *key, NSString *url) {
        [self resetAnnotations];
        NSLog(@"Getting key %@ from map", key);
        
        [self displayDataForKey:key andURL:url];
    };
    [self setButtonView:
     [[DataSourceButtonView alloc] initWithCallback:cb]];
    [self.view addSubview:self.buttonView];
}

- (void)displayDataForKey:(NSString*)key andURL:(NSString*)url {
    NSDictionary* data = [self.requestHelper doJSONQuery:url];
    for (NSDictionary* record in data[@"records"]) {
        NSDictionary* fields = [record objectForKey:@"fields"];
        
        NSArray* coords = [self.provider getCoords:fields];
        CLLocationCoordinate2D ctrpoint;
        ctrpoint.latitude = [coords[0] floatValue];
        ctrpoint.longitude = [coords[1] floatValue];
        
        MKPointAnnotation* mkAnnot = [[MKPointAnnotation alloc] init];
        [mkAnnot setCoordinate:ctrpoint];
        [mkAnnot setTitle:[self.provider getTitle:fields]];
        [self.mapView addAnnotation:mkAnnot];
    }
}

- (void)resetAnnotations {
    NSMutableArray * annotationsToRemove = [self.mapView.annotations mutableCopy];
    [annotationsToRemove removeObject:self.mapView.userLocation];
    [self.mapView removeAnnotations:annotationsToRemove];
}

@end
