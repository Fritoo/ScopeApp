//
//  AMViewManager.h
//  AMSample
//
//  Created by Miles Alden on 12/17/12.
//
//

#import <Foundation/Foundation.h>


@interface AMViewManager : NSObject {
    
    float alphaA;
    float alphaB;
    float transDuration;
    UIView *transA, *transB;
}

@property int isTransitioning;
@property (strong) UIViewController *currentViewCon;
@property (strong) NSString *lastViewCon;
@property (strong) NSString *nextViewCon;



@end
