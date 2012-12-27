//
//  Accelerometer.h
//  BasicCocos2D
//
//  Created by Fan Tsai Ming on 11/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "AppDelegate.h"

@interface Accelerometer : CCLayer
{
  CCSprite *playerSprite;
  CGPoint playerVelocity;
  float adjustDirectionX;
  float adjustDirectionY;
}

+(CCScene *) scene;

-(void)update:(ccTime)dt;

@end
