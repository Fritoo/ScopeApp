//
//  AMFileManager.h
//  AMSample
//
//  Created by Miles Alden on 12/20/12.
//
//

#import "AMObject.h"

@interface AMFileManager : AMObject


+ (AMFileManager *)fileManager;
+ (NSString *)documentsDir;
+ (NSString *)cachesDir;

@end
