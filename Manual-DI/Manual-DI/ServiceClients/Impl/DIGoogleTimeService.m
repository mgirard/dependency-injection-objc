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

static DIGoogleTimeService *shared = nil;
static CLLocation *currentLocation;

@implementation DIGoogleTimeService

+ (void) initialize
{
	if (self == [DIGoogleTimeService class]) {
		shared = [[self alloc] init];
	}
}

- (id) initWithCurrentLocation:(CLLocation *)location
{
	self = [super init];
	currentLocation = location;
	return self;
}

+ (DIGoogleTimeService *)sharedService
{
	return shared;
}

+ (void) setCurrentLocation:(CLLocation *)location
{
	currentLocation = location;
}


- (void) currentTimeZone:(void (^)(NSURLResponse *response, NSData *data, NSError *error))handler
{
	[[DIWebServiceFacade sharedFacade] sendAsyncRequestToUrl:[self getGoogleURLString] withHeaderParams:nil andMessageBody:nil forHttpMethod:@"GET" completionQueue:[NSOperationQueue mainQueue] completion:handler];
}

- (NSString *) serviceName
{
	return @"Google Maps";
}

- (NSString *) currentTime
{
	//TODO: implement this
	return @"12:00AM";
}

- (NSString *) getGoogleURLString
{
	return [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/timezone/json?location=%@&timestamp=%@&sensor=true", [self getCurrentLocationString], [self getCurrentTimestamp]];
}

- (NSString *) getCurrentLocationString
{
	if (currentLocation != nil) {
		NSString *locationString = [NSString stringWithFormat:@"%f,%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
		return locationString;
	} else {
		return @"39.6034810,-119.6822510";
	}
}

- (NSString *) getCurrentTimestamp
{
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
