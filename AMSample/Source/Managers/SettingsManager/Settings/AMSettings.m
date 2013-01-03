//
//  AMSettings.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSettings.h"
#import "NSObject+ClassName.h"
#import "AMFileManager.h"

#define COLOR CANTALOUPE

NSString const *SAVE_TO_ROLL = @"saveToRoll";
NSString const *LAST_OPEN_ALBUM = @"lastOpenAlbum";

@implementation AMSettings


- (id)init {
    if ( self = [super init] ) {
        [self loadSavedSettings];
    }
    
    return self;
}


- (void)loadDefaults {
    
    Log(@"Loading settings defaults");
    self.lastOpenAlbum = kAM_NotFound;
    self.saveToPhotoRoll = YES;
    
}

- (void)loadSavedSettings {
    
    Log(@"Loading saved settings...");
    NSDictionary *info = [AMFileManager appInfo];
    
    // First time
    if ( nil == info ) {
        Log(@"App info cache was nil.");
        [self loadDefaults];
    } else if ( ![info containsKey:SAVE_TO_ROLL] ) {
        [self loadDefaults];
    } else {
        self.saveToPhotoRoll = [[info objectForKey:SAVE_TO_ROLL] boolValue];
        self.lastOpenAlbum = [info objectForKey:LAST_OPEN_ALBUM];
    }
    
    Log(@"Updating with current settings state.");
    [AMFileManager updateAppInfo:[self currentState]];
    
    
}

- (NSDictionary *)currentState {
    
    return @{
        SAVE_TO_ROLL    : [NSString stringWithFormat:@"%d", self.saveToPhotoRoll],
        LAST_OPEN_ALBUM : self.lastOpenAlbum
    };
}




@end
