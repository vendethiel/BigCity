#import <Foundation/Foundation.h>

@interface RequestHelper : NSObject

-(NSData*)doQuery:(NSString*)URL;
-(NSDictionary*)doJSONQuery:(NSString*)URL;

@end
