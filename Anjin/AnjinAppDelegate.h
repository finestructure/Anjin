//
//  AnjinAppDelegate.h
//  Anjin
//
//  Created by Sven A. Schmidt on 09.07.11.
//  Copyright 2011 abstracture GmbH & Co. KG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnjinViewController;

@interface AnjinAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AnjinViewController *viewController;

@end
