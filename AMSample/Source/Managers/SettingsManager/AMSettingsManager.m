//
//  AMSettingsManager.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSettingsManager.h"
#import "NSObject+ClassName.h"

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
        if ( nil == self.settings ) {
            self.settings = [[AMSettings alloc] init];
        }
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



#pragma mark - Set & Get
- (int)shouldSaveToPhotoRoll {
    return self.settings.saveToPhotoRoll;
}
- (void)setShouldSaveToPhotoRoll:(BOOL)shouldSave {
    self.settings.saveToPhotoRoll = shouldSave;
}

- (id)lastOpenAlbum {
    return self.settings.lastOpenAlbum;
}

- (void)setLastOpenAlbum:(id)album {
    if ( nil == album ) {
        Log(@"Album is nil. Not setting lastOpenAlbum.");
        return;
    }
    
    self.settings.lastOpenAlbum = album;
}

- (void)applicationIsActive {
    
    
    
}




@end
