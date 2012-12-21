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

@implementation AMAppRater


+ (void)logAppLaunch {
    
    [AMFileManager checkAndBuildPath:APP_RATER_FILE];
    NSDictionary *items = [NSDictionary dictionaryWithContentsOfFile:APP_RATER_FILE];
    if ( nil == items ) {
        Log(@"No app rater info.");
        items = @{
    } 

    
    
}


- (id)init {
    
    if ( self = [super init] ) {
        // Do shtuff
        [AMFileManager checkAndBuildPath:APP_RATER_FILE];
        NSDictionary *items = [NSDictionary dictionaryWithContentsOfFile:APP_RATER_FILE];
        if ( nil == items ) {
            Log(@"No app rater info.");
        }
    }
    
    return self;
}



- (void)checkForRating {
    
    
}

- (BOOL)hasRatedApp {
    
    [self getNumAppLaunches];
    
}

- (int)getNumAppLaunches {
    
    
    return 
    
}


@end
