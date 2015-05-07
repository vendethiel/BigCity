#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

-(void)setJsonUrl:(NSString *)jsonUrl;

@property (nonatomic, strong) NSString* jsonUrl;

@end
