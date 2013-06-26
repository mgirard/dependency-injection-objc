//
//  DIServiceSelectorViewControllerTests.m
//  Manual-DI
//
//  Created by Michael Girard on 6/20/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DIServiceSelectorViewControllerTests.h"

#define POLL_INTERVAL 0.05 //50ms
#define N_SEC_TO_POLL 1.0 //poll for 1s
#define MAX_POLL_COUNT N_SEC_TO_POLL / POLL_INTERVAL

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

- (void)testFirstButton
{
	__block BOOL done = NO;
	double delayInSeconds = N_SEC_TO_POLL;
	
	__block NSString *valueOfString;
	[demoTimeService currentTimeZone:^(NSString *timeZoneName, NSError *error) {
		valueOfString = timeZoneName;			//This will make the test pass
//		valueOfString = @"this is a test";		//This will make the test fail
	}];
	[serviceController serviceClientAClick:nil];
	
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
		
		STAssertTrue([[[serviceController currentTimeLbl] text] isEqualToString:valueOfString], @"The current time zone label was not set.");
		done = YES;
	});
	
	NSLog(@"started poll");
    NSUInteger pollCount = 0;
    
    while (done == NO && pollCount < MAX_POLL_COUNT) {
        NSLog(@"polling... %i", pollCount);
        NSDate* untilDate = [NSDate dateWithTimeIntervalSinceNow:POLL_INTERVAL];
        [[NSRunLoop currentRunLoop] runUntilDate:untilDate];
        pollCount++;
    }
    if (pollCount == MAX_POLL_COUNT) {
        STFail(@"polling timed out");
    }
    
    NSLog(@"done polling");
}

@end
