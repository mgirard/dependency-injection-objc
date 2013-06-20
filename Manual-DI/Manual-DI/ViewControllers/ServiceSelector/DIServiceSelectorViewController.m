//
//  DIServiceSelectorViewController.m
//  Manual-DI
//
//  Created by Michael Girard on 6/18/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import "DIServiceSelectorViewController.h"

@interface DIServiceSelectorViewController ()
{
	
}

@end

@implementation DIServiceSelectorViewController
@synthesize firstButton, secondButton;
@synthesize serviceClientAlpha, serviceClientBeta;
@synthesize currentTimeLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTimeServiceA:(id<DITimeServiceClient>)serviceClientA andTimeServiceClientB:(id<DITimeServiceClient>)serviceClientB
{
	self = [super init];
	if (self) {
		serviceClientAlpha = serviceClientA;
		serviceClientBeta = serviceClientB;
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	[firstButton setTitle:[serviceClientAlpha serviceName] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serviceClientAClick:(id)sender
{
	if (serviceClientAlpha != nil) {
		[serviceClientAlpha currentTimeZone:^(NSString *timeZoneName, NSError *error) {
			if (error) {
				NSLog(@"Service client A error... %@", error);
			}
			[currentTimeLbl setText:timeZoneName];
		}];
	} else NSLog(@">>> NIL SERVICE CLIENT A <<<");
}

- (IBAction)serviceClientBClick:(id)sender
{
	if (serviceClientBeta != nil) {
		[serviceClientBeta currentTimeZone:^(NSString *timeZoneName, NSError *error) {
			if (error) {
				NSLog(@"Service client B error... %@", error);
			}
			[currentTimeLbl setText:timeZoneName];
		}];
	} else NSLog(@">>> NIL SERVICE CLIENT B <<<");
}

@end
