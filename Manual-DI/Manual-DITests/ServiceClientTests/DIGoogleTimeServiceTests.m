//
//  DIGoogleTimeServiceTests.m
//  Manual-DI
//
//  Created by Michael Girard on 6/20/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DIGoogleTimeServiceTests.h"

@implementation DIGoogleTimeServiceTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testConformsToProtocol
{
    STAssertTrue([DIGoogleTimeService conformsToProtocol:@protocol(DITimeServiceClient)], @"Google Time Service does not conform to time service protocol");
}

@end
