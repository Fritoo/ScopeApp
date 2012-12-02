//
//  AMSplashScreen.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSplashScreen.h"

#define COLOR MOSS
static AMSplashScreen *splashScreen = nil;

@implementation AMSplashScreen

+ (AMSplashScreen *)viewWithExpiration:(float)lifetime andFrame:(CGRect)frm {
    
    splashScreen = [[AMSplashScreen alloc] initWithLifetime:lifetime andFrame:frm];
    return splashScreen;
}


- (id)initWithLifetime:(float)lifetime andFrame:(CGRect)frm {
    
    if ( self = [super init] ) {
        self.frame = frm;
        // Start expiration timer
        if ( lifetime < 0.0 ) {
            lifetime = 2.56; // Product of 8 * multiple of 8 (32)
        }
        timer = [NSTimer timerWithTimeInterval:lifetime target:self selector:@selector(expired:) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    
    return self;
}


- (void)expired:(id)info {
    
    // This view will self destruct...
    // ha!
    Log(@"Removing self (%@)", self);
    if ( timer ) {
        [timer invalidate];
        [self removeFromSuperview];
    }
    
    splashScreen = nil;
    
}

@end
