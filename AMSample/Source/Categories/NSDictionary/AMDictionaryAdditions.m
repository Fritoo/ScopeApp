//
//  NSDictionary+SettingsDictionaries.m
//  
//
//  Created by Miles Alden on 8/7/12.
//
//

#import "AMDictionaryAdditions.h"
#import "AMArrayAdditions.h"
#import "AMStringContains.h"
#import "AMLogging.h"
#import "AMYAMLParser.h"

#define COLOR CANTALOUPE



@implementation NSDictionary (SettingsDictionaries)

- (BOOL)containsKey: (NSString *)key {
    
    // Could also do this:
    // return (nil != [self objectForKey:key]);
    
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
    
}


- (NSString *)YAMLstring {
 
    AMYAMLParser *yaml = [[AMYAMLParser alloc] init];
    return [yaml parseDictToYAML:self];    
}


@end
