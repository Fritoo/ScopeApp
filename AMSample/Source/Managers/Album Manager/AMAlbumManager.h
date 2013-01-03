//
//  AMAlbumManager.h
//  AMSample
//
//  Created by Miles Alden on 1/2/13.
//
//

#import <Foundation/Foundation.h>
#import "AMAlbum.h"

@interface AMAlbumManager : NSObject


@property (strong) AMAlbum *currentAlbum;

+ (AMAlbumManager *)albumManager;
- (void)lastAlbumCheck;

@end
