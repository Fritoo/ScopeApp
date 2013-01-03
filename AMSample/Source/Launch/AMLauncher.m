//
//  AMLauncher.m
//  AMSample
//
//  Created by Miles Alden on 12/3/12.
//
//

#import "AMLauncher.h"
#import "NSObject+ClassName.h"
#import "AMSplashScreen.h"
#import "AMUpdater.h"
#import "AMAppRater.h"
#import "AMSettingsManager.h"

@implementation AMLauncher



static AMLauncher *launcher;

+ (AMLauncher *)launcher
{
    if ( launcher == nil ) {
        launcher = [[AMLauncher alloc] init];
        return launcher;
    }
    
    return launcher;
}

- (id)init {
    
    if ( self = [super init] ) {
        // Do stuff
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (launcher == nil) {
            launcher = [super allocWithZone:zone];
            return launcher;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
    
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}


+ (void)launch {
    
    [[NSNotificationCenter defaultCenter] addObserver:[AMLauncher launcher] selector:@selector(appIsActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}

- (void)appIsActive:(id)sender {
    
    [self runOpeningSequence:sender];
    
}

- (void)runOpeningSequence:(id)sender {
    
    // Load splash screen
    [AMSplashScreen runSplashWithExpiration:3.2 andFrame:[[UIScreen mainScreen] bounds] withImage:@"MainMenu"];

    // Check for update
    //    Prompt to update
    AMUpdater *updater = [[AMUpdater alloc] init];
    [updater checkForUpdate];
    
    
    // Check for rating
    //    Prompt for rating
    AMAppRater *rater = [[AMAppRater alloc] init];
    [rater prepare];
    
    
    // Load settings
    //    Load defaults if no settings found
    [AMSettingsManager settingsManager];
    
    // Load last open album
    //    Load blanks if no album used before
    
    
    // Load Scope
    // Load Scope view
    //    Notify if no scope view
    //    Put into gallery mode
    //    Monitor reachability
    //    If reachability changes, retest for scope
    //        Load scope if live

}

@end
