//
//  libAirMicro.h
//
//  Created by Susumu.KOBAYASHI on 2010/07/01
//  Copyright 2010 Scalar Co.,LTD All rights reserved.
//

#import <UIKit/UIKit.h>

#define	VERSION		@"v1.22"

@protocol AMImageViewDelegate
- (void)captureDone:(UIImage *)image;
- (void)freezeDone:(bool)isFreeze;
@end

@interface AMImageView : UIImageView {
	id <AMImageViewDelegate> delegate;

@private
	UILabel	*frzField;
	UILabel	*capField;
	UIActivityIndicatorView	*indField;
	NSString *img1,*img2;
}

- (id)init:(id)baseView rect:(CGRect)frame;
- (void)setBtnControl:(bool)btnUse;
- (void)setFrzLabel:(id)frz;
- (void)setCapLabel:(id)cap;
- (void)setIndicator:(id)ind;
		
- (void)setWaitImage:(NSString *)w1 next:(NSString *)w2;
- (void)setFreeze:(bool)frzStatus;
- (void)savePicture;
- (void)setSavePictureFolderFlag:(bool)flg;
- (void)stopCapture;
- (void)setCapViewTime:(double)vTime;

@property(nonatomic,assign) id <AMImageViewDelegate> delegate;

@end

