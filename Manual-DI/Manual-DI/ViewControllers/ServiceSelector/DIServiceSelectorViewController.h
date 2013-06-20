//
//  DIServiceSelectorViewController.h
//  Manual-DI
//
//  Created by Michael Girard on 6/18/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DITimeServiceClient.h"

@interface DIServiceSelectorViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *firstButton, *secondButton;
@property (nonatomic, strong) IBOutlet UILabel *currentTimeLbl;
@property (nonatomic, strong) id<DITimeServiceClient> serviceClientAlpha;
@property (nonatomic, strong) id<DITimeServiceClient> serviceClientBeta;

- (id)initWithTimeServiceA:(id<DITimeServiceClient>)serviceClientA andTimeServiceClientB:(id<DITimeServiceClient>)serviceClientB;

- (IBAction)serviceClientAClick:(id)sender;
- (IBAction)serviceClientBClick:(id)sender;

@end
