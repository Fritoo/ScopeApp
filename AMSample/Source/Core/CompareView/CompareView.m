//
//  CompareView.m
//  AMSample
//
//  Created by Miles Alden on 12/17/12.
//
//

#import "CompareView.h"

@implementation CompareView


static CompareView *sharedInstance;

+ (CompareView *)sharedInstance
{
    if ( sharedInstance == nil ) {
        sharedInstance = [[CompareView alloc] init];
        return sharedInstance;
    }
    
    return sharedInstance;
}

- (id)init {
    
    if ( self = [super init] ) {
        // Do stuff
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
    
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}


@end
