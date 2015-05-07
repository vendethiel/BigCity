#import <UIKit/UIKit.h>
#import "DataSourceButtonView.h"

@interface DataListController : UIViewController

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) DataSourceButtonView *buttonView;

@end
