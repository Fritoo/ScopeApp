//
//  AMFileManager.m
//  AMSample
//
//  Created by Miles Alden on 12/20/12.
//
//

#import "AMFileManager.h"

@implementation AMFileManager



static AMFileManager *fileManager;

+ (AMFileManager *)fileManager
{
    if ( fileManager == nil ) {
        fileManager = [[AMFileManager alloc] init];
        return fileManager;
    }
    
    return fileManager;
}

- (id)init {
    
    if ( self = [super init] ) {
        // Do stuff
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (fileManager == nil) {
            fileManager = [super allocWithZone:zone];
            return fileManager;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
    
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}


+ (NSString *)pathForMainGallery {
    if (  )
    return [[AMFileManager documentsDir] stringByAppendingPathComponent:MAIN_GALLERY_FOLDER_NAME];
}
+ (NSString *)documentsDir {
    // eg: ...$thisiPhone/thisAppsHash/Documents
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)cachesDir {
    // eg: ...$thisiPhone/thisAppsHash/Library/Chaches
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}


@end
