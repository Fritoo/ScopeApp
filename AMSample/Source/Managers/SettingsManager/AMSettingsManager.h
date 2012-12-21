//
//  AMSettingsManager.h
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//


#import "AMSettings.h"

#define COLOR CANTALOUPE

@interface AMSettingsManager : NSObject

@property (strong) AMSettings *settings;

- (int)shouldSaveToPhotoRoll;
- (void)setShouldSaveToPhotoRoll:(BOOL)shouldSave;

- (id)lastOpenAlbum;
- (void)setLastOpenAlbum:(id)album;

@end
