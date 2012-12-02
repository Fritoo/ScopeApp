//
//  AMSettings.h
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMObject.h"

@interface AMSettings : AMObject

@property BOOL saveToPhotoRoll;
@property (strong) NSString *lastOpenedAlbum;

- (void)loadDefaults;

@end
