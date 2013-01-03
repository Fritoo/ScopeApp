//
//  AMFileManager.h
//  AMSample
//
//  Created by Miles Alden on 12/20/12.
//
//



@interface AMFileManager : NSObject
    


@property (strong) NSMutableDictionary *cachedFiles;





+ (AMFileManager *)fileManager;
+ (int)checkAndBuildPath:(NSString *)path;
+ (NSArray *)contentsAtPath:(NSString *)path;
+ (NSDictionary *)appInfo;
+ (void)updateDictionaryAtPath:(NSString *)path dictionary:(NSDictionary *)newDict;
+ (void)updateAppInfo:(NSDictionary *)newContent;
+ (void)saveAppInfoToDisk;

+ (NSString *)pathForNewAlbum:(NSString *)newAlbumName;
+ (NSString *)pathForAppInfo;
+ (NSString *)pathForMainGallery;
+ (NSString *)pathForDefaultGallery;
+ (NSString *)documentsDir;
+ (NSString *)cachesDir;

+ (NSMutableDictionary *)getAppInfoCache;


@end
