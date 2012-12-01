//
//  NSArray+AMArrayAdditions.m
//  
//
//  Created by Miles Alden on 8/7/12.
//
//

#import "AMArrayAdditions.h"
#import "AMDictionaryAdditions.h"

@implementation NSArray (AMArrayAdditions)


- (int)isIndexValid:(int)index {
    return ((index < self.count) && (index > -1));
}
- (id)firstObject {
    if ( ![self isIndexValid:0] ) {
        return nil;
    }
    return [self objectAtIndex:0];
}

@end
