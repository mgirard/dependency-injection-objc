//
//  DITestTimeService.m
//  Manual-DI
//
//  Created by Michael Girard on 6/20/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DITestTimeService.h"

@implementation DITestTimeService

- (void) currentTimeZone:(void (^)(NSString *, NSError *))handler
{
	handler(@"(test) Pacific Daylight Time", nil);
}

- (NSString *) currentTime
{
	return @"7:34 AM";
}

- (NSString *) serviceName
{
	return @"Test Time Service";
}

@end
