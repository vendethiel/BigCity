#import <Foundation/Foundation.h>


@interface DataProvider : NSObject

- (NSDictionary*)dataSources;

- (NSDictionary*)getByName:(NSString*)name;

- (NSString*)getTitle:(NSDictionary*)fields;

- (NSArray*)getCoords:(NSDictionary*)fields;

- (NSString*)getAddr:(NSDictionary*)fields;

@end
