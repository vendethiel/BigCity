#import "RequestHelper.h"

@implementation RequestHelper

-(NSData*)doQuery:(NSString*)URL {
    NSURLRequest* req = [NSURLRequest
                         requestWithURL:[NSURL URLWithString:URL]];
    NSData *data = [NSURLConnection
                    sendSynchronousRequest: req
                    returningResponse: nil
                    error: nil];
    return data;
}

-(NSDictionary*)doJSONQuery:(NSString*)URL {
    NSData* data = [self doQuery:URL];
    NSError *error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    
    return json;
}

@end
