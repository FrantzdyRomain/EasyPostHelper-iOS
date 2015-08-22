//
//  EasyPostHelper.m
//  Surprise
//
//  Created by Frantzdy romain on 8/18/15.
//  Copyright (c) 2015 Frantz. All rights reserved.
//

#import "EasyPostHelper.h"

NSString * const EASYPOST_APIKEY                                     = @"YOUR_KEY"; //
NSString * const BASE_URL                                     = @"https://api.easypost.com/v2/shipments";

@implementation EasyPostHelper

+ (NSString *)base64Encode:(NSData *)dataToEncode;
{
    NSString *strToEncode;
    strToEncode = [dataToEncode base64EncodedStringWithOptions:kNilOptions];
    return  strToEncode;

}

+ (void)getShipmentrates:(NSMutableDictionary *)toAddress from:(NSMutableDictionary *)fromAddress forParcel:(NSMutableDictionary *)parcelDictionary completionHandler:(void (^)(id responseObject, NSError *error))completionHandler{
    
    __block NSArray *results;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSString *predefinedPackage = [parcelDictionary valueForKey:@"parcel[predefined_package]"];
    NSString *weight = [parcelDictionary valueForKey:@"parcel[weight]"];
    NSString *length = [parcelDictionary valueForKey:@"parcel[length]"];
    NSString *width = [parcelDictionary valueForKey:@"parcel[width]"];
    NSString *height = [parcelDictionary valueForKey:@"parcel[height]"];
    
    AFHTTPRequestOperationManager *operationManager = [AFHTTPRequestOperationManager manager];
    NSString *authStr = [NSString stringWithFormat:@"%@:", EASYPOST_APIKEY];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@=", [EasyPostHelper base64Encode:authData]];
    [operationManager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    

    
    //populate
    for (int i = 0; i < 2; i++) {
        //use ternary if-then-else
        //translates to: theCondition ? valueIfTrue : valueIfFalse
        //addressDict = 0. if the value == 0 set addressDict to fromAddress params. Else set addressDict to toAddress.
        NSMutableDictionary *addressDict = i == 0 ? fromAddress : toAddress;
        NSString *addressKeyString = i == 0 ? @"from_address" : @"to_address";
        
        NSString *name = [addressDict valueForKey:@"address[name]"];
        if (name) {
            [dict setValue:name forKey:[NSString stringWithFormat:@"shipment[%@][name]",addressKeyString]];
        }
        
        NSString *company = [addressDict valueForKey:@"address[company]"];
        if (company) {
            [dict setValue:company forKey:[NSString stringWithFormat:@"shipment[%@][company]",addressKeyString]];
        }
        
        NSString *street1 = [addressDict valueForKey:@"address[street1]"];
        if (street1) {
            [dict setValue:street1 forKey:[NSString stringWithFormat:@"shipment[%@][street1]",addressKeyString]];
        }
        NSString *street2 = [addressDict valueForKey:@"address[street2]"];
        if (street2) {
            [dict setValue:street2 forKey:[NSString stringWithFormat:@"shipment[%@][street2]",addressKeyString]];
        }
        
        NSString *city = [addressDict valueForKey:@"address[city]"];
        if (city) {
            [dict setValue:city forKey:[NSString stringWithFormat:@"shipment[%@][city]",addressKeyString]];
        }
        
        NSString *state = [addressDict valueForKey:@"address[state]"];
        if (state) {
            [dict setValue:state forKey:[NSString stringWithFormat:@"shipment[%@][state]",addressKeyString]];
        }
        
        NSString *zip = [addressDict valueForKey:@"address[zip]"];
        if (zip) {
            [dict setValue:zip forKey:[NSString stringWithFormat:@"shipment[%@][zip]",addressKeyString]];
        }
        
        NSString *country = [addressDict valueForKey:@"address[country]"];
        if (country) {
            [dict setValue:country forKey:[NSString stringWithFormat:@"shipment[%@][country]",addressKeyString]];
        } else {
            [dict setValue:@"US" forKey:[NSString stringWithFormat:@"shipment[%@][country]",addressKeyString]];
        }
        
        NSString *phone = [addressDict valueForKey:@"address[phone]"];
        if (phone) {
            [dict setValue:phone forKey:[NSString stringWithFormat:@"shipment[%@][phone]",addressKeyString]];
        }
        
        NSString *email = [addressDict valueForKey:@"address[email]"];
        if (email) {
            [dict setValue:email forKey:[NSString stringWithFormat:@"shipment[%@][email]",addressKeyString]];
        }
    }
    

    
    if (predefinedPackage) {
        [dict setValue:predefinedPackage forKey:@"shipment[parcel][predefined_package]"];
    }
    if (weight) {
        [dict setValue:weight forKey:@"shipment[parcel][weight]"];
    }
    if (length) {
        [dict setValue:length forKey:@"shipment[parcel][length]"];
    }
    if (width) {
        [dict setValue:width forKey:@"shipment[parcel][width]"];
    }
    if (height) {
        [dict setValue:height forKey:@"shipment[parcel][height]"];
    }
    
    [operationManager POST:BASE_URL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (completionHandler) {
            results=[responseObject valueForKey:@"rates"];
           // completionHandler(responseObject, nil);
            completionHandler(results, nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];


    
}

@end
