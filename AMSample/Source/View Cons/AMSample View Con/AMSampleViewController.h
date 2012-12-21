//
//  AMSampleViewController.h
//  AMSample
//
//  Created by Susumu.KOBAYASHI on 2010/07/01.
//  Copyright 2010 Scalar Co.,LTD All rights reserved.
//

#import <UIKit/UIKit.h>
#import "libAirMicro.h"

#define	IMG1	@"wait1a.jpg"
#define	IMG2	@"wait2a.jpg"





@interface AMSampleViewController : UIViewController  <AMImageViewDelegate> {	
	AMImageView *airmicro;
	UILabel *capField;
	UILabel *frzField;
	UIActivityIndicatorView *indField; 
}

- (void)captureDone:(UIImage *)image;
- (void)freezeDone:(bool)isFreeze;

- (void)amControl:(id)sender;
- (void)savePicture;
- (void)LiveOfFreeze:(id)sender;	
@end

