//
//  AMViewManager.m
//  AMSample
//
//  Created by Miles Alden on 12/17/12.
//
//

#import "AMViewManager.h"
#import "NSObject+ClassName.h"
#import "AMConstants.h"

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
        scale = [[UIWindow mainWindow] rootViewController].view.frame.size.height;
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
    
    // temp Debug
    count = 0;
    
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
    
    [self.currentViewCon.view insertSubview:b belowSubview:a];
    transA = a;
    transB = b;
    alphaA = 1.0;
    alphaB = 0.0;
    transDuration = duration;

    if ( type == AMTransitionType_None ) {
        self.currentTransition = type;
        Log(@"Running transition %@", transitionName(self.currentTransition));
        [a removeFromSuperview];
    }

    if ( type == AMTransitionType_CrossFade ) {
        
        self.currentTransition = type;
        Log(@"Running transition %@", transitionName(self.currentTransition));
 
    }
    
    if ( type == AMTransitionType_SwipeDown ) {
        
        self.currentTransition = type;
        Log(@"Running transition %@", transitionName(self.currentTransition));
        
    }

    // 0.0       .25      .5       .75      1
    //  |--------|--------|--------|--------|
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:kDeviceRefreshRate target:self selector:@selector(incrementTransition:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    
    return success;
}


- (void)incrementTransition:(NSTimer *)timer {
    
    // Temp debug
    count++;
    
    transA.alpha = alphaA;
    transB.alpha = alphaB;
    
    float div = transDuration / kDeviceRefreshRate;
    float decAlpha = 1/div;
    
    float dist = scale / div;
    
    alphaA -= decAlpha;
    alphaB += decAlpha;
    
    if ( self.currentTransition == AMTransitionType_SwipeDown ) {
               
        CGPoint org = transA.bounds.origin;
        CGSize siz = transA.bounds.size;
        org = (CGPoint){ org.x, org.y -= dist};

        CGRect updateRect = { org, siz };
        transA.bounds = updateRect;
        transB.bounds = CGRectOffset(updateRect, 0, -siz.height);
        Log(@"\n%@\n%@", NSStringFromCGRect(transA.bounds), NSStringFromCGRect(transB.bounds));
        
    } else if ( self.currentTransition == AMTransitionType_SwipeUp ) {
        
        CGPoint org = transA.bounds.origin;
        CGSize siz = transA.bounds.size;
        
        // TODO: Fix transition times and calcuation
        // of distances
        org = (CGPoint){ org.x, org.y -= dist};
        
        CGRect updateRect = { org, siz };
        transA.bounds = updateRect;
    }

    
    
    
    if ( count >= div ) {
        [timer invalidate];
        timer = nil;
        [transA removeFromSuperview];
        Log(@"Transition complete. (%@)", transitionName(self.currentTransition));
    }
    
}


NSString * transitionName(AMTransitionType t) {
    
    switch (t) {
        case AMTransitionType_None:
            return @"None";
            break;
        case AMTransitionType_CrossFade:
            return @"CrossFade";
            break;
        case AMTransitionType_BottomOfStack:
            return @"BottomOfStack";
            break;
        case AMTransitionType_PopTopOfStack:
            return @"PopTopOfStack";
            break;
        case AMTransitionType_SwipeLeft:
            return @"SwipeLeft";
            break;
        case AMTransitionType_SwipeRight:
            return @"SwipeRight";
            break;
        case AMTransitionType_SwipeUp:
            return @"SwipeUp";
            break;
        case AMTransitionType_SwipeDown:
            return @"SwipeDown";
            break;

            
        default:
            return @"Unknown transition type";
            break;
    }
    
}

@end
