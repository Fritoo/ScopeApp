//
//  SplashViewCon.h
//  AMSample
//
//  Created by Miles Alden on 7/14/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SplashDelegate
- (void)completedSplash;
@end


@interface SplashViewCon : UIViewController {
    
    IBOutlet UIImageView *logo, *slogan;
    IBOutlet id <SplashDelegate> delegate;
}

- (void)setDelegate:(id)del;
- (void)showSTR_Splash;

@end
