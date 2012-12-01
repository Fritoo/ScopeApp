//
//  AMSampleAppDelegate.h
//  AMSample
//
//  Created by Susumu.KOBAYASHI on 10/02/09.
//  Copyright 2010 Scalar Co.,LTD All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashViewCon.h"

@class MainMenuViewCon, ControlPoint, MyViewCon;

@interface AMSampleAppDelegate : NSObject <UIApplicationDelegate, SplashDelegate> {
    
    UIWindow *window;
    ControlPoint *thePoint;
    MyViewCon *theRootViewCon;
    SplashViewCon *viewController;
    MainMenuViewCon *mainMenuCon;
    
    BOOL shouldSaveToCameraRoll, soundOn;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SplashViewCon *viewController;

- (ControlPoint *)controlPoint;
- (void)completedSplash;
- (BOOL)isSoundOn;
- (BOOL)shouldSaveToCameraRoll;
- (void)loadUserSettings;

- (void)setSoundOn: (BOOL)onOff;
- (void)setShouldSaveToCameraRoll: (BOOL)onOff;

@end

