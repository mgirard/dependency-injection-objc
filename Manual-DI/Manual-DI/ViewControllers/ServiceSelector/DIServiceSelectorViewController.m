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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)serviceClientAClick:(id)sender
{
	
	[currentTimeLbl setText:[serviceClientAlpha currentTime]];
}

- (IBAction)serviceClientBClick:(id)sender
{
	[currentTimeLbl setText:[serviceClientBeta currentTime]];
}

@end
