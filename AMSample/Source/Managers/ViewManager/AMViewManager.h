//
//  AMViewManager.h
//  AMSample
//
//  Created by Miles Alden on 12/17/12.
//
//

#import <Foundation/Foundation.h>
#import "EnumHeader.h"

@interface AMViewManager : NSObject {
    
    // Temp debug
    int count;
    
    float alphaA;
    float alphaB;
    float transDuration;
    float travelX;
    float travelY;
    float travelZ;
    
    double scale;
    UIView *transA, *transB;
}

@property int isTransitioning;
@property (strong) UIViewController *currentViewCon;
@property (strong) NSString *lastViewCon;
@property (strong) NSString *nextViewCon;
@property AMTransitionType currentTransition;


+ (AMViewManager *)viewManager;
- (int)transitionFromView:(UIView *)a toView:(UIView *)b transitionType:(AMTransitionType)type duration:(float)duration;


@end
