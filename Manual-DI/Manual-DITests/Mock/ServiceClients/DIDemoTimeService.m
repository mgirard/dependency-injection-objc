//
//  DIDemoTimeService.m
//  Manual-DI
//
//  Created by Michael Girard on 6/20/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DIDemoTimeService.h"

@implementation DIDemoTimeService

- (void) currentTimeZone:(void (^)(NSString *, NSError *))handler
{
	handler(@"(demo) Eastern Daylight Time", nil);
}

- (NSString *) currentTime
{
	return @"10:34 AM";
}

- (NSString *) serviceName
{
	return @"Demo Time Service";
}

@end
