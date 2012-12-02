//
//  NSURL+NSURLAdditions.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMURLAdditions.h"
#import "AMStringContains.h"
#import "AMLogging.h"
#import "AMArrayAdditions.h"

@implementation NSURL (NSURLAdditions)


- (NSString *)valueForQuery:(NSString *)query {
    
    NSString *q = [self query];
    if ( ![q containsString:query] ) {
        // LogDebug(@"No query by that name.");
        return nil;
    }
    
    // q1=thisValue&q2=anotherVal
    // becomes
    // [
    // q1=thisValue,
    // q2=anotherVal
    // ]
    
    // q1=thisValue with query of @"q1"
    // returns @"thisValue"
    
    
    for ( NSString* item in [q componentsSeparatedByString:@"&"] ) {
        NSString *key = [[item componentsSeparatedByString:@"="] firstObject];
        if ( [key isEqualToString:query] ) {
            return [[item componentsSeparatedByString:@"="] lastObject];
        }
    }
    
    return nil;
    
}
@end
