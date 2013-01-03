//
//  AMAlbumManager.m
//  AMSample
//
//  Created by Miles Alden on 1/2/13.
//
//

#import "AMAlbumManager.h"
#import "NSObject+ClassName.h"
#import "AMFileManager.h"
#import "AMConstants.h"

#define COLOR CAYANNE

static AMAlbumManager *albumManager;

@implementation AMAlbumManager


+ (AMAlbumManager *)albumManager
{
    if ( albumManager == nil ) {
        albumManager = [[AMAlbumManager alloc] init];
        return albumManager;
    }
    
    return albumManager;
}

- (id)init {
    
    if ( self = [super init] ) {
        // Do stuff
        self.currentAlbum = [[AMAlbum alloc] init];
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (albumManager == nil) {
            albumManager = [super allocWithZone:zone];
            return albumManager;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
    
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}



- (void)lastAlbumCheck {
    
    
    Log(@"Checking for last open album");
    NSDictionary *info = [AMFileManager appInfo];
    
    // First time
    // Shouldn't be here by now...
    if ( nil == info ) {
        Log(@"App info cache was nil.");
    } else if ( ![info containsKey:LAST_OPEN_ALBUM] ) {
        Log(@"Missing key in app info cache for %@", LAST_OPEN_ALBUM);
    } else {
        Log(@"Attempting to load in last album items...");
        self.currentAlbum = [[AMAlbum alloc] initWithPath:[info objectForKey:LAST_OPEN_ALBUM]];
    }
    
    
}



@end
