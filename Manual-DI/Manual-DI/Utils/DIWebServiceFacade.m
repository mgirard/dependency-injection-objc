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
static NSOperationQueue *queue;

+ (void) initialize
{
	if (self == [DIWebServiceFacade class]) {
		shared = [[self alloc] init];
		queue = [NSOperationQueue new];
	}
}

+ (DIWebServiceFacade*) sharedFacade
{
	return shared;
}

- (void) sendAsyncRequestToURL:(NSString *)url withHeaderParams:(NSDictionary *)params withMessageBody:(NSData *)body forHttpMethod:(NSString *)methodType completion:(void (^)(NSURLResponse *response, NSData *data, NSError *error))handler
{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	if (params != nil) {
		[request setAllHTTPHeaderFields:params];
	}
	if (body != nil) {
		[request setHTTPBody:body];
	}
	[request setHTTPMethod:methodType];
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:handler];
}

@end
