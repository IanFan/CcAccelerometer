//
//  AppDelegate.h
//  CcAccelerometer
//
//  Created by Ian Fan on 27/12/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "NavigationController.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
//	UINavigationController *navController_;
  NavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
//@property (readonly) UINavigationController *navController;
@property (readonly) NavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@end
