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
    
}



@end
