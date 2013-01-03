//
//  AMSettings.h
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//



extern NSString const *SAVE_TO_ROLL;
extern NSString const *LAST_OPEN_ALBUM;


@interface AMSettings : NSObject

@property BOOL saveToPhotoRoll;
@property (strong) NSString *lastOpenAlbum;

- (void)loadDefaults;

@end
