//
//  AMSettings.h
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//



@interface AMSettings : NSObject

@property BOOL saveToPhotoRoll;
@property (strong) NSString *lastOpenAlbum;

- (void)loadDefaults;

@end
