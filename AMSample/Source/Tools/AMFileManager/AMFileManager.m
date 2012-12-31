//
//  AMFileManager.m
//  AMSample
//
//  Created by Miles Alden on 12/20/12.
//
//

#import "AMFileManager.h"
#import "NSObject+ClassName.h"

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

+ (int)checkAndBuildPath:(NSString *)path {
    
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:path] ) {
        NSError *err;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                                 withIntermediateDirectories:YES
                                                                  attributes:nil
                                                                       error:&err];
        return success;
        
    }
    
    return 0;
}

+ (void)updateDictionaryAtPath:(NSString *)path dictionary:(NSDictionary *)newDict {
    if ( nil != path && nil != newDict ) {
        [newDict writeToFile:path atomically:YES];
    }
}

+ (NSArray *)contentsAtPath:(NSString *)path {
    NSError *err;
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&err];
}

+ (NSString *)pathForAppRaterInfo {
    return [[AMFileManager documentsDir] stringByAppendingPathComponent:ROOT_DIR APP_RATER_FILE];
}

+ (NSString *)pathForNewAlbum:(NSString *)newAlbumName {
    return [[AMFileManager pathForMainGallery] stringByAppendingPathComponent:newAlbumName];
}

+ (NSString *)pathForDefaultGallery {
    return [[AMFileManager pathForMainGallery] stringByAppendingPathComponent:DEFAULT_ALBUM];
}


+ (NSString *)pathForMainGallery {
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
