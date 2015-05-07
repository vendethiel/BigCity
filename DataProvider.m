#import <MapKit/MapKit.h>
#import "DataProvider.h"
#import "RequestHelper.h"

@import CoreLocation;

@implementation DataProvider

- (NSDictionary*)dataSources {
    return @{
      @"Terrasses": @"http://opendata.paris.fr/api/records/1.0/search?dataset=etalages_et_terrasses_autorisees_a_paris&lang=fr&rows=100&facet=arrondissement&facet=libelle_type_objet",
      @"Jardins": @"http://opendata.paris.fr/api/records/1.0/search?dataset=liste_des_jardins_partages_a_paris&lang=fr&rows=100&facet=charte",
    };
}

- (NSDictionary*)getByName:(NSString*)name {
    RequestHelper* requestHelper = [[RequestHelper alloc] init];
    NSString* url = [self.dataSources objectForKey:name];
    return [requestHelper doJSONQuery:url];
}

- (NSString*)getTitle:(NSDictionary*)fields {
    if ([fields objectForKey:@"dosred"] != nil) {
        return [fields objectForKey:@"dosred"];
    }
    if ([fields objectForKey:@"nom_gerant"] != nil) {
        return [fields objectForKey:@"nom_gerant"];
    }
    if ([fields objectForKey:@"type_jard"] != nil) {
        if ([fields objectForKey:@"adresse"] != nil) {
            // if we can append type with address
            return [NSString stringWithFormat:@"%@ %@",
                    [fields objectForKey:@"type_jard"],
                    [fields objectForKey:@"adresse"]];
        } else {
            return [fields objectForKey:@"type_jard"];
        }
    }
    return @"(?)";
}

- (NSArray*)getCoords:(NSDictionary*)fields {
    NSArray* coords = fields[@"geo_point_2d"];
    if (coords == nil) {
        coords = fields[@"coordonnees"];
    }
    return coords;
}

- (NSString*)getAddr:(NSDictionary*)fields {
    if ([fields objectForKey:@"adresse"] != nil) {
        return [fields objectForKey:@"adresse"];
    }
    return @"(?)";
}

@end
