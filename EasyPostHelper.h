//
//  EasyPostHelper.h
//  Surprise
//
//  Created by Frantzdy romain on 8/18/15.
//  Copyright (c) 2015 Frantz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"




 

typedef void (^CompletionHandlerBlock)(NSError *error, NSDictionary *result);
@interface EasyPostHelper : NSObject

+(void)getShipmentrates:(NSMutableDictionary *)toAddress from:(NSMutableDictionary *)fromAddress forParcel:(NSMutableDictionary *)parcelDictionary completionHandler:(void (^)(id responseObject, NSError *error))completionHandler;

@end
