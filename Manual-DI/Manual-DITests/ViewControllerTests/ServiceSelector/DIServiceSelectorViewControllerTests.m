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
	
	[serviceController view];
	
	serviceController = [[DIServiceSelectorViewController alloc] initWithTimeServiceA:demoTimeService andTimeServiceClientB:testTimeService];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testFirstButtonTitle
{
	NSLog(@"FIRST SERVICE BUTTON TEXT IS.... %@", serviceController.firstButton);
	STAssertTrue([serviceController.firstButton.titleLabel.text isEqualToString:demoTimeService.serviceName], @"First service button label is incorrect");
}

- (void)testSetFirstTimezoneService
{
	[serviceController serviceClientAClick:nil];
	__block NSString *demoServiceTimezone;
	__block BOOL done = NO;
	[demoTimeService currentTimeZone:^(NSString *timeZoneName, NSError *error) {
		demoServiceTimezone = [NSString stringWithFormat:@"%@", timeZoneName];
		NSLog(@"timezone is ... %@", timeZoneName);
		done = YES;
	}];
	
	NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10.0];
	while (done == NO && [loopUntil timeIntervalSinceNow] > 0) {
		[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
	}
	
	if (!done) {
		STFail(@"Well, the test timed out");
	} else {
		NSLog(@"CURRENT TIME LABEL IS... %@", serviceController.currentTimeLbl.text);
		STAssertTrue([serviceController.currentTimeLbl.text isEqualToString:demoServiceTimezone], @"First timezone service client is not setting the onscreen label correctly");
	}
}

- (void)testSetSecondTimezoneService
{
	[serviceController serviceClientBClick:nil];
	__block NSString *demoServiceTimezone;
	__block BOOL done = NO;
	[testTimeService currentTimeZone:^(NSString *timeZoneName, NSError *error) {
		demoServiceTimezone = timeZoneName;
		NSLog(@"timezone is ... %@", timeZoneName);
		done = YES;
	}];
	
	while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !done) {
		NSLog(@"current time label is... %@", serviceController.currentTimeLbl.text);
		STAssertTrue([serviceController.currentTimeLbl.text isEqualToString:demoServiceTimezone], @"Second timezone service client is not setting the onscreen label correctly.");
	}
}

@end
