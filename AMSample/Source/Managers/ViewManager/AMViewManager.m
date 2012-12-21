//
//  AMViewManager.m
//  AMSample
//
//  Created by Miles Alden on 12/17/12.
//
//

#import "AMViewManager.h"
#import "NSObject+ClassName.h"

#define COLOR OCEAN_BLUE

@implementation AMViewManager


static AMViewManager *viewManager;

+ (AMViewManager *)viewManager
{
    if ( viewManager == nil ) {
        viewManager = [[AMViewManager alloc] init];
        return viewManager;
    }
    
    return viewManager;
}

- (id)init {
    
    if ( self = [super init] ) {
        // Do stuff
        
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (viewManager == nil) {
            viewManager = [super allocWithZone:zone];
            return viewManager;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
    
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}


- (UIViewController *)currentVC {
    return self.currentViewCon;
}

- (UIView *)currentView {
    return self.currentViewCon.view;
}

- (int)transitionFromView:(UIView *)a toView:(UIView *)b transitionType:(AMTransitionType)type duration:(float)duration {
    
    int success = 0;
    
    if ( nil == a ) {
        Log(@"**ERROR** View A is nil. Abandoning transition.");
        return 0;
    }
    
    if ( nil == b ) {
        Log(@"**ERROR** View B is nil. Abandoning transition.");
        return 0;
    }
    
    if ( (int)type < 0 || type > 7 ) {
        type = 1;
    }
    
    // Just testing crossfade here...
    //
    // TODO: Implement remaining transition types
    if ( type == AMTransitionType_CrossFade ) {
        
        [self.currentViewCon.view insertSubview:b belowSubview:a];
        transA = a;
        transB = b;
        alphaA = 1.0;
        alphaB = 0.0;
        transDuration = duration;
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:duration/60 target:self selector:@selector(incrementTransition:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
    }
    
    return success;
}


- (void)incrementTransition:(NSTimer *)timer {
    
    transA.alpha = alphaA;
    transB.alpha = alphaB;
    
    float div = transDuration / 60;
    alphaA -= div;
    alphaB += div;
    
    if ( alphaA < 0.01 ) {
        [timer invalidate];
        timer = nil;
        [transA removeFromSuperview];
    }
    
}


@end
