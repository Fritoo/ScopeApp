//
//  NSDictionary+SettingsDictionaries.h
//  
//
//  Created by Miles Alden on 8/7/12.
//
//

#import <Foundation/Foundation.h>

#define AMNoKey @"-111"

@interface NSDictionary (SettingsDictionaries)

- (BOOL)containsKey: (NSString *)key;
- (NSString *)YAMLstring;

@end
