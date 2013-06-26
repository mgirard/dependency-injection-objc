//
//  DIServiceSelectorViewControllerTests.m
//  Manual-DI
//
//  Created by Michael Girard on 6/20/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DIServiceSelectorViewControllerTests.h"

@interface DIServiceSelectorViewControllerTests()
{
	DIDemoTimeService *demoTimeService;
	DITestTimeService *testTimeService;
	DIServiceSelectorViewController *serviceController;
}

@end

@implementation DIServiceSelectorViewControllerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
	
	demoTimeService = [[DIDemoTimeService alloc] init];
	testTimeService = [[DITestTimeService alloc] init];
	
	serviceController = [[DIServiceSelectorViewController alloc] initWithTimeServiceA:demoTimeService andTimeServiceClientB:testTimeService];
	
	[serviceController loadView];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testFirstButtonShouldBeConnected
{
	STAssertNotNil([serviceController firstButton], @"first button is not connected (it is nil)");
}

- (void)testNotNilServiceClients
{
	STAssertNotNil([serviceController serviceClientAlpha], @"service client alpha was not set");
	STAssertNotNil([serviceController serviceClientBeta], @"service client beta was not set");
}

//- (void)testFirstButton
//{
//	[serviceController serviceClientAClick:nil];
//	
//	STAssertTrue([[[serviceController currentTimeLbl] text] isEqualToString:@""], @"failed test");
//}

@end
