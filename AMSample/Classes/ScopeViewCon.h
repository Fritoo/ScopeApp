//
//  ScopeViewCon.h
//  AMSample
//
//  Created by Miles Alden on 7/14/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libAirMicro.h"



@interface ScopeViewCon : UIViewController <AMImageViewDelegate, UIAlertViewDelegate>{
    
    IBOutlet UIButton *liveFeed, *stillFeed, *snapButton;
    
    UITextField *alertField;
    UIImage *tempImage;

}

@property (retain) AMImageView *scopeView;


- (IBAction)toggleLiveFeed;
- (IBAction)backButton;
- (IBAction)snapButton;

- (void)captureDone:(UIImage *)image;
- (void)freezeDone:(bool)isFreeze;

- (void)filePictureWithName:(NSString *)name album:(NSString *)album;
- (void)setup;
- (void)amControl:(id)sender;

@end
