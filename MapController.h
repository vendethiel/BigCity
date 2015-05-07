@import UIKit;
@import MapKit;

#import "DataSourceButtonView.h"

@interface MapController : UIViewController

@property (nonatomic, retain) IBOutlet MKMapView* mapView;
@property (nonatomic, strong) DataSourceButtonView *buttonView;

@end
