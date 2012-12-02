//
//  SplashAppTest.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "SplashAppTest.h"
#import "AMAppTests.h"

#define COLOR IRON

@implementation SplashAppTest

- (void)executeApplicationTests {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(testSplashLifeCycle)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
}


- (void)testSplashLifeCycle {
    
    Log(@"Testing splash life cycle");
    float lifetime = 5.5f;
    splash = [AMSplashScreen viewWithExpiration:lifetime andFrame:CGRectMake(100, 100, 100, 100)];
    splash.backgroundColor = [UIColor greenColor];
    [[UIWindow mainWindow] addSubview:splash];
    [splash startAnimation];
    NSTimer *timer = [NSTimer timerWithTimeInterval:lifetime+1 target:self selector:@selector(assertSplash) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    NSAssert(splash, @"Splash object returned nil.");
}

- (void)assertSplash {
    
    Log(@"Splash self destruct.");
    NSAssert(splash.superview == nil, @"Did not remove from superview.");
    
}

@end
