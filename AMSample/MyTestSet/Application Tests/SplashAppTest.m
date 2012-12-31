//
//  SplashAppTest.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "SplashAppTest.h"
#import "AMAppTests.h"
#import "NSObject+ClassName.h"

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
    [AMSplashScreen runSplashWithExpiration:3.2 andFrame:[[UIScreen mainScreen] bounds] withImage:@"MainMenu"];

    splash = [AMSplashScreen currentSplash];
    NSAssert( splash, @"Splash object returned nil.");

    NSTimer *timer = [NSTimer timerWithTimeInterval:lifetime+1 target:self selector:@selector(assertSplash) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
}

- (void)assertSplash {
    
    Log(@"Splash self destruct.");
    NSAssert(splash.superview == nil, @"Did not remove from superview.");
    
}

@end
