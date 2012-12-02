//
//  AMSplashScreen.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSplashScreen.h"
#import <QuartzCore/QuartzCore.h>

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
        rotation = 0.0f;
        depth = 0.0f;
    }
    
    
    return self;
}

- (void)startAnimation {

    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(shear)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

}

- (void)setRotation:(float)newRot {
    
    rotation = degreesToRadians(newRot);
}

- (void)rotate {
    
    rotation += degreesToRadians(rotation);
    double deg = rotation;
    double a,b,c,d;
    a = cos(deg);
    b = sin(deg);
    c = -b;
    d = a;
    // Rotate deg degrees
    // a=cos(deg)
    // b=sin(deg)
    // c=-b
    // d=a
    
    
    self.transform = CGAffineTransformMake(a,
                                           b,
                                           c,
                                           d,
                                           self.transform.tx,
                                           self.transform.ty);

}

- (void)shear {
    
    float inc = 0.1;
    depth += inc;

//    self.layer.transform = CATransform3DMakeScale(-depth, depth*2, depth);
    CATransform3D t = self.layer.transform;
    t.m11 = self.layer.transform.m11;
    t.m12 = depth;
    t.m22 = depth;
    t.m21 = 2-inc;
    t.m43 = 1.0/depth;
    t.m44 = 1;
    self.layer.transform = t;
    
   
    Log(@"%@", [self.layer transformString]);

}


- (void)animateConcurrently {
    
    if ( self.superview ) {
//            self.frame = CGRectMake(self.frame.origin.x+1,
//                                    self.frame.origin.y+1,
//                                    self.frame.size.width,
//                                    self.frame.size.height);
    }
    
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
