//
//  DIGoogleTimeService.h
//  Manual-DI
//
//  Created by Michael Girard on 6/18/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DITimeServiceClient.h"
#import "DIWebServiceFacade.h"
#import <CoreLocation/CoreLocation.h>

@interface DIGoogleTimeService : NSObject <DITimeServiceClient>

- (id) initWithCurrentLocation:(CLLocation *)location;
+ (DIGoogleTimeService *)sharedService;
+ (void) setCurrentLocation:(CLLocation *)location;

@end
