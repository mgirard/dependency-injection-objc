//
//  DIWebServiceFacade.h
//  Manual-DI
//
//  Created by Michael Girard on 6/19/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DIWebServiceFacade : NSObject

+ (DIWebServiceFacade*) sharedFacade;

- (void) sendAsyncRequestToUrl:(NSString *)url withHeaderParams:(NSDictionary *)params andMessageBody:(NSData *)body forHttpMethod:(NSString *)methodType completionQueue:(NSOperationQueue *)queue completion:(void (^)(NSURLResponse *response, NSData *data, NSError *error))handler;
- (NSDictionary*) sendSyncRequestToUrl:(NSString *)url withHeaderParams:(NSDictionary *)params withMessageBody:(NSData *)body forHttpMethod:(NSString *)methodType;

@end
