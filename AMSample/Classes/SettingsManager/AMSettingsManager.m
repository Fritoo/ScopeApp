//
//  AMSettingsManager.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSettingsManager.h"

@implementation AMSettingsManager

+ (AMSettingsManager *)settingsManager
{
    static dispatch_once_t once;
    static AMSettingsManager *settingsManager;
    dispatch_once(&once, ^ { settingsManager = [[AMSettingsManager alloc] init]; });
    return settingsManager;
}


- (void)applicationIsActive {
    
    
    
}




@end
