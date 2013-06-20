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

- (void) currentTimeZone:(void (^)(NSString *, NSError *))handler
{
	if (currentLocation != nil) {
		[[DIWebServiceFacade sharedFacade] sendAsyncRequestToUrl:[self getGoogleURLString] withHeaderParams:nil andMessageBody:nil forHttpMethod:@"GET" completionQueue:[NSOperationQueue mainQueue] completion:^(NSURLResponse *response, NSData *data, NSError *error) {
			if (!error) {
				NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
				if ([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
					handler([response objectForKey:@"timeZoneName"], error);
				} else {
					handler(@"Service error.", error);
				}
			} else {
				handler(@"Service error.", error);
			}
		}];
	} else {
		NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Current location not set.", kHttpResponseError, nil];
		NSError *error = [NSError errorWithDomain:@"Local" code:50 userInfo:infoDict];
		handler(@"Service error.", error);
	}
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
	return [NSString stringWithFormat:@"%f,%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
}

- (NSString *) getCurrentTimestamp
{
	return [[NSString stringWithFormat:@"%f", [[currentLocation timestamp] timeIntervalSince1970]] substringToIndex:10];
}

@end
