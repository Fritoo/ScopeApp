//
//  SideBySideCon.h
//  AMSample
//
//  Created by Miles Alden on 1/14/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerticalSegmentedControl.h"
#import "TogglingScrollview.h"
#import "ScopeViewCon.h"
#import "PressAndHoldView.h"

@class StartingImage, Layout;

typedef enum ImageLayout 
{
    ImageLayout_SingleImage = 0,
    ImageLayout_DoubleImage = 1,
    ImageLayout_TripleImage = 2,
    ImageLayout_QuadImage = 3
} ImageLayout;





@interface SideBySideCon : UIViewController
{
    IBOutlet UISegmentedControl *layoutSegmentedControl;
    IBOutlet UIImageView *clientIcon;
    IBOutlet UIToolbar *titleBar;
    IBOutlet Layout *layout[4];
    IBOutlet UIButton *liveFeedToggle;
    IBOutlet UIButton *shareOrEdit;
    IBOutlet UILabel *barLabel;
    
    IBOutlet VerticalSegmentedControl *vertControl;
    
    UIImage *zoomedImage;
    CGPoint location;
    UIImageView *wantedImage;
    NSString *currentAlbumPath;
    NSArray *dirContents;
    
    BOOL didPopulateClientScroller;
    int buttonTagCurrentlyAnimatingOntoScreen;
    
}

@property (unsafe_unretained, readonly) IBOutlet TogglingScrollview *clientImagesScroller;
@property (readonly, strong) IBOutlet UIView *sidePanelView;
@property (strong) IBOutlet PressAndHoldView *liveViewContainer;
@property (strong) NSString *currentAlbumTitle;


- (void)setCurrentAlbumTitle: (NSString *)t;
- (void)addLayout: (int)layoutNumber;
- (void)updateLayout;
- (UIView *)getLayout:(int)layoutNumber;
//- (void)reset;
- (void)killClientScroller_images;
- (void)populateClientScroller_images;
- (void)loadLiveImageView;
- (void)loadClientImageScroller;

- (IBAction)pressedFullScreen: (id)sender;
- (IBAction)toggleThumbnails: (id)sender;
- (IBAction)pressedInfoButton: (id)sender;
- (IBAction)pressedGalleryButton: (id)sender;
- (IBAction)pressedNewFolderButton: (id)sender;
- (IBAction)pressedShareButton: (id)sender;
- (IBAction)pressedTakePicture: (id)sender;
- (void)touchedThisImage: (StartingImage *)theImage plusTouch: (UITouch *)theTouch;
- (CGSize)calculateTransformPercentage: (CGRect)destinationRect startingRect: (CGRect)startingRect;

@end
