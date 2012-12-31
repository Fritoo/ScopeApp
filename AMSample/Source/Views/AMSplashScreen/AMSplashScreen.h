//
//  AMSplashScreen.h
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//


#import "AMLogging.h"
#import "AMConstants.h"

@interface AMSplashScreen : UIView {
    
    NSTimer *timer;
    float rotation;
    float depth;
}

@property (strong) UIImage *image;

+ (void)runSplashWithExpiration:(float)lifetime andFrame:(CGRect)frm withImage:(NSString *)imgName;
+ (AMSplashScreen *)viewWithExpiration:(float)lifetime andFrame:(CGRect)frm withImage:(NSString *)imgName;
+ (AMSplashScreen *)currentSplash;

- (void)animateConcurrently;
- (void)startAnimation;

@end
