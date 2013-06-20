//
//  DITimeServiceClient.h
//  Manual-DI
//
//  Created by Michael Girard on 6/18/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DITimeServiceClient <NSObject>

//@optional - (NSString *) currentTimeZone;
- (void) currentTimeZone:(void (^)(NSURLResponse *response, NSData *data, NSError *error))handler;
- (NSString *) currentTime;
- (NSString *) serviceName;
@end
