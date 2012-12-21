//
//  AMSettingsManager.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSettingsManager.h"

@implementation AMSettingsManager


static AMSettingsManager *settingsManager;

+ (AMSettingsManager *)settingsManager
{
    if ( settingsManager == nil ) {
        settingsManager = [[AMSettingsManager alloc] init];
        return settingsManager;
    }
    
    return settingsManager;
}

- (id)init {
    
    if ( self = [super init] ) {
        // Do stuff
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (settingsManager == nil) {
            settingsManager = [super allocWithZone:zone];
            return settingsManager;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
    
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}


- (void)applicationIsActive {
    
    
    
}




@end
