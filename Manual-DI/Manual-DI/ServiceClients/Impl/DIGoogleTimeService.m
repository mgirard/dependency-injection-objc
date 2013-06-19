//
//  DIGoogleTimeService.m
//  Manual-DI
//
//  Created by Michael Girard on 6/18/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DIGoogleTimeService.h"

@interface DIGoogleTimeService()

- (NSString *) getGoogleURLString;
- (NSString *) getCurrentLocationString;
- (NSString *) getCurrentTimestamp;

@end

@implementation DIGoogleTimeService

- (NSString *) currentTime
{
	[[DIWebServiceFacade sharedFacade] sendAsyncRequestToURL:[self getGoogleURLString] withHeaderParams:nil withMessageBody:nil forHttpMethod:@"GET" completion:^(NSURLResponse *response, NSData *data, NSError *error) {
		if (data != nil) {
			NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
			
		} else {
			//TODO: handle error
		}
	}];
	return @"4:33PM";
}

- (NSString *) getGoogleURLString
{
	return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/timezone/json?location=%@&timestamp=%@&sensor=yes", [self getCurrentLocationString], [self getCurrentTimestamp]];
}

- (NSString *) getCurrentLocationString
{
	CLLocation *currentLocation = [(DIAppDelegate*)[[UIApplication sharedApplication] delegate] currentLocation];
	if (currentLocation != nil) {
		NSString *locationString = [NSString stringWithFormat:@"%f,%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
		return locationString;
	} else {
		return @"39.6034810,-119.6822510";
	}
}

- (NSString *) getCurrentTimestamp
{
	CLLocation *currentLocation = [(DIAppDelegate*)[[UIApplication sharedApplication] delegate] currentLocation];
	if (currentLocation != nil) {
		NSDate *gpsDate = [currentLocation timestamp];
		NSString *dateString = [[NSString stringWithFormat:@"%f", [gpsDate timeIntervalSince1970]] substringToIndex:10];
		NSLog(@"gps time is...%@", dateString);
		return dateString;
	} else {
		return @"1331161200";
	}
}

@end
