//
//  Accelerometer.m
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Accelerometer.h"

@implementation Accelerometer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];	
	Accelerometer *layer = [Accelerometer node];
	[scene addChild: layer];
  
	return scene;
}

#pragma mark -
#pragma mark Update

-(void)update:(ccTime)dt {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  float minX = 0.5*playerSprite.texture.contentSize.width;
  float maxX = winSize.width - 0.5*playerSprite.texture.contentSize.width;
  float newX = playerSprite.position.x + playerVelocity.x;
  newX = MAX(MIN(newX, maxX),minX);
  
  float minY = 0.5*playerSprite.texture.contentSize.height;
  float maxY = winSize.height - 0.5*playerSprite.texture.contentSize.height;
  float newY = playerSprite.position.y + playerVelocity.y;
  newY = MAX(MIN(newY, maxY),minY);
  
  playerSprite.position = ccp(newX, newY);
}

#pragma mark -
#pragma mark Accelerometer

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
  float deceleration = 0.1f;
  float sensitivity = 30.0f;
  float maxVelocity = 600.0f;
  
  float adjustForUserExp = 0;//recommand 6.0
  
  AppController *app = (AppController*)[[UIApplication sharedApplication] delegate];
  UIInterfaceOrientation interfaceOrientation =  app.navController.interfaceOrientation;
  
  switch (interfaceOrientation) {
    case UIInterfaceOrientationPortrait:
      playerVelocity.x = playerVelocity.x*deceleration + acceleration.x*sensitivity;
      playerVelocity.y = playerVelocity.y*deceleration + acceleration.y*sensitivity + adjustForUserExp;
      break;
    case UIInterfaceOrientationPortraitUpsideDown:
      playerVelocity.x = playerVelocity.x*deceleration - acceleration.x*sensitivity;
      playerVelocity.y = playerVelocity.y*deceleration - acceleration.y*sensitivity + adjustForUserExp;
      break;
    case UIInterfaceOrientationLandscapeLeft:
      playerVelocity.x = playerVelocity.x*deceleration + acceleration.y*sensitivity;
      playerVelocity.y = playerVelocity.y*deceleration - acceleration.x*sensitivity + adjustForUserExp;
      break;
    case UIInterfaceOrientationLandscapeRight:
      playerVelocity.x = playerVelocity.x*deceleration - acceleration.y*sensitivity;
      playerVelocity.y = playerVelocity.y*deceleration + acceleration.x*sensitivity + adjustForUserExp;
      break;
      
    default:
      break;
  }
  
  if (playerVelocity.x > maxVelocity) playerVelocity.x = maxVelocity;
  else if (playerVelocity.x < -maxVelocity) playerVelocity.x = -maxVelocity;
  
  if (playerVelocity.y > maxVelocity) playerVelocity.y = maxVelocity;
  else if (playerVelocity.y < -maxVelocity) playerVelocity.y = -maxVelocity;
}

#pragma mark -
#pragma mark Ball

-(void)setBall {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  playerSprite = [CCSprite spriteWithFile:@"ball.png"];
  [playerSprite setPosition:ccp(winSize.width/2, winSize.height/2)];
  [self addChild:playerSprite];
}

/*
 Target:
 Tilt the iOS device and the ball would move around properly.
 
 1. Edit AppDelegate.h, AppDelegate.m, add NavigationController for reading UIInterfaceOrientation (Support Landscape Only)
 2. Set Ball.
 3. Set Accelerometer and Update for controlling the speed of the ball.
 */

#pragma mark -
#pragma mark Init

-(id) init {
	if( (self=[super init])) {
    [self setBall];
		
    self.isAccelerometerEnabled = YES;
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0f/60.0f];
    
    [self schedule:@selector(update:) interval:1.0f/60.0f];
	}
  
	return self;
}

- (void) dealloc {
	[super dealloc];
}

@end
