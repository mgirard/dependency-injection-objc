//
//  DIAppDelegate.h
//  Manual-DI
//
//  Created by Michael Girard on 6/18/13.
//  Copyright (c) 2013 Compuware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DIServiceSelectorViewController.h"
#import "DIGoogleTimeService.h"
#import "DIDemoTimeService.h"
#import "DITestTimeService.h"

@interface DIAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
