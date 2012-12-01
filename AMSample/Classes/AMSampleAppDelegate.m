//
//  AMSampleAppDelegate.m
//  AMSample
//
//  Created by Susumu.KOBAYASHI on 10/02/09.
//  Copyright 2010 Scalar Co.,LTD All rights reserved.
//

#import "AMSampleAppDelegate.h"
#import "AMSampleViewController.h"
#import "MainMenuViewCon.h"
#import "ControlPoint.h"
#import "MyViewCon.h"




@implementation AMSampleAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    [self loadUserSettings];
    
    /*My trademark "Control Point". Everything runs out
     of here.*/  
    self->thePoint = [[ControlPoint alloc] init];
    
    
    /*We do this since it gives us a base view controller
     that we can set our interface orientations with. That's
     really the only reason the damned thing is there.*/
    self->theRootViewCon = [[MyViewCon alloc] init];
    window.rootViewController = theRootViewCon;
    
    
    [window.rootViewController.view addSubview:viewController.view];
    [viewController setDelegate:self];
    
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
}



- (void)loadUserSettings
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    soundOn = [userDefaults boolForKey:@"sound"];
    shouldSaveToCameraRoll = [userDefaults boolForKey:@"saveToRoll"];
    
}

- (void)completedSplash
{
    if ( viewController )
    {
        [viewController.view removeFromSuperview];
        [viewController release];
        self->viewController = nil;
    }
    
    [thePoint loadSideBySide];
//    self->mainMenuCon = [[MainMenuViewCon alloc] initWithNibName:@"MainMenu" bundle:nil];
//    [window addSubview:mainMenuCon.view];

}


- (ControlPoint *)controlPoint
{
    return thePoint;
}

- (BOOL)isSoundOn {return soundOn;}
- (BOOL)shouldSaveToCameraRoll { return shouldSaveToCameraRoll; }
- (void)setSoundOn: (BOOL)onOff { soundOn = onOff; }
- (void)setShouldSaveToCameraRoll: (BOOL)onOff { shouldSaveToCameraRoll = onOff; }



- (void)dealloc {
 
    if ( viewController )
    {
        [viewController.view removeFromSuperview];
        [viewController release];
        self->viewController = nil;
    }
    
    [window release];
    [super dealloc];
}


@end
