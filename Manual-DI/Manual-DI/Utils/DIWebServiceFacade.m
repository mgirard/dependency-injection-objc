//
//  DIWebServiceFacade.m
//  Manual-DI
//
//  Created by Michael Girard on 6/19/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DIWebServiceFacade.h"

@interface DIWebServiceFacade()
{
	//
}

@end

@implementation DIWebServiceFacade

static DIWebServiceFacade *shared = nil;

+ (void) initialize
{
	if (self == [DIWebServiceFacade class]) {
		shared = [[self alloc] init];
	}
}

+ (DIWebServiceFacade*) sharedFacade
{
	return shared;
}

- (void) sendAsyncRequestToUrl:(NSString *)url withHeaderParams:(NSDictionary *)params andMessageBody:(NSData *)body forHttpMethod:(NSString *)methodType completionQueue:(NSOperationQueue *)queue completion:(void (^)(NSURLResponse *response, NSData *data, NSError *error))handler
{
	NSURLRequest *request = [self buildURLRequest:url params:params body:body methodType:methodType];
	[NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:handler];
}

- (NSDictionary*) sendSyncRequestToUrl:(NSString *)url withHeaderParams:(NSDictionary *)params withMessageBody:(NSData *)body forHttpMethod:(NSString *)methodType
{
	NSURLRequest *request = [self buildURLRequest:url params:params body:body methodType:methodType];
	NSURLResponse *response;
	NSError *error;
	
	NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if (error != nil) {
		return [NSDictionary dictionaryWithObjectsAndKeys:kHttpResponseStatusSuccess, kHttpResponseStatusMessage,
				[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error], kHttpResponseData, nil];
	} else {
		return [NSDictionary dictionaryWithObjectsAndKeys:kHttpResponseStatusFailure, kHttpResponseStatusMessage, error, kHttpResponseError, nil];
	}
}

- (NSURLRequest *)buildURLRequest:(NSString *)url params:(NSDictionary *)params body:(NSData *)body methodType:(NSString *)methodType
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	if (params != nil) {
		[request setAllHTTPHeaderFields:params];
	}
	if (body != nil) {
		[request setHTTPBody:body];
	}
	[request setHTTPMethod:methodType];
    return request;
}

@end
