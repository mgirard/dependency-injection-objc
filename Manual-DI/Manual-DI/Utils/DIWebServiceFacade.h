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

- (void) sendAsyncRequestToURL:(NSString *)url withHeaderParams:(NSDictionary *)params withMessageBody:(NSData *)body forHttpMethod:(NSString *)methodType completion:(void (^)(NSURLResponse *response, NSData *data, NSError *error))handler;

@end
