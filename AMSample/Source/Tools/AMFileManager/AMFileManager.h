//
//  AMFileManager.h
//  AMSample
//
//  Created by Miles Alden on 12/20/12.
//
//



@interface AMFileManager : NSObject


+ (AMFileManager *)fileManager;
+ (int)checkAndBuildPath:(NSString *)path;
+ (NSArray *)contentsAtPath:(NSString *)path;

+ (NSString *)pathForNewAlbum:(NSString *)newAlbumName;
+ (NSString *)pathForMainGallery;
+ (NSString *)pathForDefaultGallery;
+ (NSString *)documentsDir;
+ (NSString *)cachesDir;

@end
