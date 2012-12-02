//
//  AMAppTests.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMAppTests.h"

#define COLOR TEAL

static BOOL isWaiting = NO;

@implementation AMAppTests


+ (void)executeApplicationTests {
   
    NSArray *functions = @[
    @"testSplashLifeCycle"
    ];
    
    NSArray *instances = @[
    [[SplashAppTest alloc] init]
    ];
    
    
    @try {
        int i = 0;
        for ( NSString *func in functions ) {
            Log(@"Testing %@ on %@", func, NSStringFromClass([instances[i] class]));
                [instances[i] performSelector:NSSelectorFromString(func)];
                Log(@"PASSED");
            
        }
    }
    @catch (NSException *exception) {
        Log(@"FAIL: %@", exception);
        exit(1);
    }
    
//    while ( isWaiting ) { /* Do nothing */ }
    Log(@"Application tests completed.");
    
//    exit(0);
}

+ (void)setWaiting:(BOOL)wait {
    
        isWaiting = wait;
}

@end
