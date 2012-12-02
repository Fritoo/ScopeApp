//
//  SplashAppTest.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "SplashAppTest.h"

@implementation SplashAppTest

+ (void)executeApplicationTests {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(testSplashLifeCycle)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
}


- (void)testSplashLifeCycle {
    
    float lifetime = 2.5f;
    splash = [AMSplashScreen viewWithExpiration:lifetime];
    [[UIWindow mainWindow] addSubview:splash];
    [NSTimer scheduledTimerWithTimeInterval:lifetime+1 target:self selector:@selector(assertSplash) userInfo:nil repeats:NO];
    
    NSAssert(splash, @"Splash object returned nil.");
}

- (void)assertSplash {
    
    Log(@"Splash self destruct.");
    NSAssert(splash.superview == nil, @"Did not remove from superview.");
    
}

@end
