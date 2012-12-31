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


+ (void)updateDictionaryAtPath:(NSString *)path dictionary:(NSDictionary *)newDict;

+ (NSString *)pathForNewAlbum:(NSString *)newAlbumName;
+ (NSString *)pathForAppRaterInfo;
+ (NSString *)pathForMainGallery;
+ (NSString *)pathForDefaultGallery;
+ (NSString *)documentsDir;
+ (NSString *)cachesDir;

@end
