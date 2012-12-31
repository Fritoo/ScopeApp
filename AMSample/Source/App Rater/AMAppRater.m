//
//  AMAppRater.m
//  AMSample
//
//  Created by Miles Alden on 12/21/12.
//
//

#import "AMAppRater.h"
#import "AMFileManager.h"
#import "NSObject+ClassName.h"
#import "AMAlertView.h"

NSString const *APP_RATE = @"appRate";
NSString const *NUM_LAUNCH = @"numLaunches";


@implementation AMAppRater


- (id)initWithAppNotifiers {
    
    if ( self = [super init] ) {
        
        [self buildObservers];
        
        // Pull saved data
        // TODO: Test me
        [AMFileManager checkAndBuildPath:[AMFileManager pathForAppRaterInfo]];
        NSDictionary *items = [NSDictionary dictionaryWithContentsOfFile:[AMFileManager pathForAppRaterInfo]];
        
        // Load defaults if none on
        // disk
        if ( nil == items ) {
            Log(@"No app rater info.");
            items = [self defaults];
            self.rated = 0;
            self.numAppLaunches = 1;
        }
        
    }
    
    return self;
}


- (void)buildObservers {
    
    // Add observers
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appEnteringBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];

}


- (NSDictionary *)defaults {
    
    // Defaults are obviously:
    // 1. not-rated (0) and
    // 2. first-launch (1)
    //
    
    return @{
        APP_RATE    : @"0",
        NUM_LAUNCH  : @"1"
    };

}

- (NSDictionary *)currentState {
    
    // Return current state as dictionary
    //
    
    return @{
        APP_RATE    : [NSString stringWithFormat:@"%d", self.rated],
        NUM_LAUNCH  : [NSString stringWithFormat:@"%d", self.numAppLaunches]
    };
}

- (void)appActive:(id)sender {
    
    [self prompt];
}

- (void)appEnteringBackground:(id)sender {
    [self handleExit];
}

- (void)handleExit {
    
    // Update state to disk
    [AMFileManager updateDictionaryAtPath:[AMFileManager pathForAppRaterInfo]
                               dictionary:[self currentState]];
    
}


- (bool)isRatingAppropriate {
    
    // Checking for rating every 5 launches
    //
    
    Log(@"Checking if it's time to prompt for rating.");
    return ( self.numAppLaunches % 5 == 0 );
    
}


- (void)prompt {
    
    // Prompt for rating if timing is
    // appropriate
    //
    
    if ( [self isRatingAppropriate] ) {
        
        Log(@"Prompting for rating (launch# %d)", self.numAppLaunches);
        NSString *titles[1] = {@"Yes"};
        AMAlertView *alert = [[AMAlertView alloc] init];
        [alert runAlertViewWithTitle:@"Rate us!"
                             message:@"It looks like you enjoy using this app. Please feel free to rate us in the App Store."
                              cancel:@"Maybe next time"
                   otherButtonTitles:&titles
                           numTitles:1
                         andDelegate:self];
    }

}



- (BOOL)hasRatedApp {
    
    return self.rated;
    
}

- (int)getNumAppLaunches {
    
    return self.numAppLaunches;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ( buttonIndex > 0 ) {
        self.rated = 1;
    }
    
}


@end
