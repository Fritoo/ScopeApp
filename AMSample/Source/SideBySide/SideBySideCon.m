//
//  SideBySideCon.m
//  AMSample
//
//  Created by Miles Alden on 1/14/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import "SideBySideCon.h"
#import "PressAndHoldImages.h"
#import "PressAndHoldView.h""
#import "CompareViewAppDelegate.h"
#import "ControlPoint.h"
#import "Layout.h"
#import "ScopeViewCon.h"




@implementation SideBySideCon
@synthesize clientImagesScroller, sidePanelView, liveViewContainer;
@synthesize currentAlbumTitle;

- (void)setup
{
    /*For catching when a picture is done being taken
     and refreshing the display.*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLayout) name:@"ScopeFinishedTakingPicture" object:nil];
    
    CGRect panelRect = sidePanelView.frame;
    CGSize panelSize = panelRect.size;
    CGRect vertFrame = CGRectMake(0,0, panelSize.width * 0.75f, 4 * 30);
    didPopulateClientScroller = NO;
    
    if ( vertControl ) {
    
/*    self->vertControl = [[VerticalSegmentedControl alloc] initWithFrame:vertFrame 
                                                                           numberOfSegments:4
                                                                            verticalSpacing:30 
                                                                             verticalHeight:30 
                                                                                   delegate:self];
*/
        [vertControl setNumberOfSegments:4];
        [vertControl setVerticalHeight:30];
        [vertControl setVerticalSpacing:0];
        [vertControl setDelegate:self];
        [vertControl updateSegments];
        
        
        for (int i = 0; i < vertControl.numberOfSegments; i++) {
            [vertControl segment:i addTarget:self selector:@selector(updateLayout)];
        }
                
        vertControl.backgroundColor = [UIColor clearColor];
        
//        [self.view addSubview:vertControl];
        
    }
    
    
    [self updateLayout];
    
    /*Sets currentAlbumTitle to default_album*/
    [self setCurrentAlbumTitle:nil];
    
    [self loadClientImageScroller];
    
    [self loadLiveImageView];
        
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (void)loadLiveImageView {
    
    
    if ( liveViewContainer ) {
        liveViewContainer.startingSuperview = sidePanelView;
        [liveViewContainer setup];
        [liveViewContainer setOwner_:self];
        [liveViewContainer setTarget:self selector:@selector(pressedLiveImage:)];
        [liveViewContainer setTag:11110];
        
    }

}

- (IBAction)pressedFullScreen: (id)sender {
    
    
    
    
}



- (IBAction)toggleThumbnails: (id)sender {
    
    if (clientImagesScroller) {
        
        if ( [clientImagesScroller isOn] ) [clientImagesScroller setOn:NO];
        else [clientImagesScroller setOn:YES];
    }
    
}

- (IBAction)pressedInfoButton: (id)sender {
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.controlPoint loadInfoPage];
}

- (IBAction)pressedGalleryButton: (id)sender {
    
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.controlPoint loadGallery];
    
}

- (IBAction)pressedNewFolderButton: (id)sender {
    
}

- (IBAction)pressedShareButton: (id)sender {
    
    
}

- (IBAction)pressedTakePicture: (id)sender {
    
    printf("pressedTakePicture");
    if ( liveViewContainer ) [liveViewContainer.liveImageView snapButton];
    
}



- (void)setCurrentAlbumTitle: (NSString *)t {
    
    if ( !t ) currentAlbumTitle = DEFAULT_ALBUM;
        else currentAlbumTitle = t;
    
    if (barLabel) barLabel.text = currentAlbumTitle; 
    
    if ( clientImagesScroller ) [self killClientScroller_images];
    
    
    //Get default file path for gallery
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:MAIN_GALLERY_FOLDER_NAME];
    
    fullPath = [fullPath stringByAppendingPathComponent:currentAlbumTitle];
    currentAlbumPath = [fullPath retain];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *theError = nil;
    
    self->dirContents = [[fileManager contentsOfDirectoryAtPath:fullPath error:&theError] retain];
    
    
}











#pragma mark -
#pragma mark ClientImagesScroller 
- (void)loadClientImageScroller {
    
    
    if (clientImagesScroller)
    {
        int numClientImages = dirContents.count;
        
        /*This is our toggle for bringing onscreen and off.*/
        [clientImagesScroller initializeOnState];
        
        [clientImagesScroller setScrollEnabled:YES];
        [clientImagesScroller setUserInteractionEnabled:YES];
        [clientImagesScroller setShowsHorizontalScrollIndicator:YES];
        [clientImagesScroller setContentSize:CGSizeMake(numClientImages * ( [[UIScreen mainScreen] bounds].size.width / 4)/*Show four images in scroll view, each 1/4 of screen in width*/, clientImagesScroller.frame.size.height)];
        
        [self populateClientScroller_images];
    }

}

- (void)killClientScroller_images {
    
    
    if (clientImagesScroller) {
        for (id object in clientImagesScroller.subviews) {
            [object removeFromSuperview];
        }
    }
    
    didPopulateClientScroller = NO;
    
    for (id _object_ in [self.view subviews]) {
        if ( [_object_ tag] > -1 && [_object_ isKindOfClass:[UIButton class]] ) [_object_ removeFromSuperview];
    }
    
    
}


- (void)populateClientScroller_images {
    
    if ( didPopulateClientScroller ) return;
    didPopulateClientScroller = YES;
    
    int numClientImages = dirContents.count;

    float imageWidth = [[UIScreen mainScreen] bounds].size.width / 4;
        
    if ( dirContents ) {
        
        for (int i = 0; i < numClientImages; i++) {
            
            CGRect imageRect = CGRectMake(i * imageWidth, 0, imageWidth, clientImagesScroller.frame.size.height);
            
            //UIImageView *clientImage = [[UIImageView alloc] initWithFrame:imageRect];
                
            //PressAndHoldImages *clientImage = [[PressAndHoldImages alloc] initWithFrame:imageRect];
            UIButton *clientImage = [UIButton buttonWithType:UIButtonTypeCustom];
            [clientImage setFrame:imageRect];
            [clientImage setTag:88801+i];
            //[clientImage setImage:[UIImage imageNamed:@"slideShow_2"]];
            [clientImage setUserInteractionEnabled:YES];
            [clientImage setImage: [UIImage imageWithContentsOfFile:[currentAlbumPath stringByAppendingPathComponent: dirContents[i]]]/*[UIImage imageNamed:@"slideShow_2"]*/ forState:UIControlStateNormal];
            [clientImage addTarget:self action:@selector(pressedComparableImage:) forControlEvents:UIControlEventTouchUpInside];
            
            //[clientImage setOwner_: self];
            [clientImagesScroller addSubview:clientImage];
            [clientImagesScroller setContentSize:CGSizeMake(numClientImages * ( [[UIScreen mainScreen] bounds].size.width / 4)/*Show four images in scroll view, each 1/4 of screen in width*/, clientImagesScroller.frame.size.height)];
        }
    
    }

    
}








/*
 Max Squares = 4
 Check squares for image
    if has an image return 1
 */







#pragma mark -
#pragma mark ScrollView Button Responders


- (int)getNextAvailableLayoutSquare {
    
    int nextAvailableLayoutSquare = 0;
    BOOL foundSquare = NO;
    
    for (int i = 0; i < 4; i++) {
        
        if ( !foundSquare ) {
            if ( layout[i] ) {
                if ( !layout[i].hasComparableImage ) {
                    nextAvailableLayoutSquare = i;
                    foundSquare = YES; }
            }
        }
    }

    return  nextAvailableLayoutSquare;
}



- (void)pressedComparableImage: (id)sender {
    
    /*"sender" should be of type UIButton
     */
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setImage:[sender imageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(userDoneComparingThisImage:) forControlEvents:UIControlEventTouchUpInside];
    
    newButton.frame = [sender frame];
    newButton.transform = CGAffineTransformMakeScale(0.01, 0.01);
    newButton.alpha = 0.0;
    newButton.tag = [sender tag] + 11100;
    
    /*Keep reference for imageIsDoneGrowingBigger method*/
    buttonTagCurrentlyAnimatingOntoScreen = newButton.tag;
    
    [self.view addSubview:newButton];
    
    
    
    /*Find next available square*/
    int nextAvailableLayoutSquare = [self getNextAvailableLayoutSquare];
    
    if ( [layout[nextAvailableLayoutSquare] currentComparableImage] ) {
        if ( ![[layout[nextAvailableLayoutSquare] currentComparableImage] isKindOfClass:[PressAndHoldView class]] ) 
            [self userDoneComparingThisImage:[layout[nextAvailableLayoutSquare] currentComparableImage]];
        
        else { [self userDoneComparingLiveImage:[layout[nextAvailableLayoutSquare] currentComparableImage]]; }
    }
    
    [layout[nextAvailableLayoutSquare] setCurrentComparableImage:newButton];
    
    newButton.center = layout[nextAvailableLayoutSquare].center;
    
    [UIView beginAnimations:@"AppearInMainView" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:IMAGE_GROW_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(imageIsDoneGrowingBigger)];
    
    [sender setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
    [sender setAlpha:0.0];
    [newButton setTransform:CGAffineTransformMakeScale(1.15, 1.15)];
    [newButton setAlpha:1.0];
    
    [UIView commitAnimations];
    
}


- (void)imageIsDoneGrowingBigger {
    
    UIButton *button;
    for (UIButton *btn in self.view.subviews) {
            if ( btn.tag == buttonTagCurrentlyAnimatingOntoScreen ) button = btn;
    }
    
    
    
    if (button) {
        
        [UIView beginAnimations:@"AppearInMainView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:IMAGE_GROW_DURATION];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(imageIsDoneReturningToNormalSize)];
        
        [button setTransform:CGAffineTransformIdentity];
        
        [UIView commitAnimations];

    }
    
}

- (void)imageIsDoneReturningToNormalSize {
    
    
    
    UIButton *button;
    for (UIButton *btn in self.view.subviews) {
        if ( btn.tag == buttonTagCurrentlyAnimatingOntoScreen ) button = btn;
    }

    
    int nextAvailableLayoutSquare = [self getNextAvailableLayoutSquare];
    
    
    if (button) {
        
        CGSize aSize = [self calculateTransformPercentage:layout[nextAvailableLayoutSquare].frame startingRect:button.frame];
        
        [UIView beginAnimations:@"AppearInMainView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:IMAGE_GROW_DURATION];
        
        [button setTransform:CGAffineTransformMakeScale(aSize.width, aSize.height)];
        
        [UIView commitAnimations];
                
        layout[nextAvailableLayoutSquare].hasComparableImage = YES;
    }

}


- (CGSize)calculateTransformPercentage: (CGRect)destinationRect startingRect: (CGRect)startingRect {
    
    float newWidth = destinationRect.size.width / startingRect.size.width; /*Calculate what percentage our width is
                                                                  in relation to theRect width.*/
    
    float newHeight = destinationRect.size.height / startingRect.size.height; /*Same for height.*/
    
    return CGSizeMake(newWidth, newHeight);
}












#pragma mark -
#pragma mark Live Image View Handlers

- (void)pressedLiveImage: (id)sender {
    
    /*"sender" should be of type PressAndHoldView*/

    CGRect aFrame = [sender frame];
    int senderTag = [sender tag];
    ScopeViewCon *temp = [sender liveImageView];
    
    
    PressAndHoldView *newLiveView = [[PressAndHoldView alloc] initWithFrame:aFrame];
    newLiveView.liveImageView = temp;
    newLiveView.liveImageView.view.frame = newLiveView.bounds;
    [newLiveView addSubview:newLiveView.liveImageView.view];
    [newLiveView setOwner_:self];
    [newLiveView setTarget:self selector:@selector(userDoneComparingLiveImage:)];
    [newLiveView setBackgroundColor:[UIColor redColor]];
    
    
    /*Start the animation at these settings*/
    newLiveView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    newLiveView.alpha = 0;
    newLiveView.tag = senderTag + 11100;
    
    /*Keep reference for imageIsDoneGrowingBigger method*/
    buttonTagCurrentlyAnimatingOntoScreen = newLiveView.tag;
    
    [self.view addSubview:newLiveView];
    
    
    
    /*Find next available square*/
    int nextAvailableLayoutSquare = [self getNextAvailableLayoutSquare];
    
    if ( [layout[nextAvailableLayoutSquare] currentComparableImage] ) {
        if ( ![[layout[nextAvailableLayoutSquare] currentComparableImage] isKindOfClass:[PressAndHoldView class]] ) 
            [self userDoneComparingThisImage:[layout[nextAvailableLayoutSquare] currentComparableImage]];
        
        else { [self userDoneComparingLiveImage:[layout[nextAvailableLayoutSquare] currentComparableImage]]; }
    }
    
    [layout[nextAvailableLayoutSquare] setCurrentComparableImage:newLiveView];

    
    newLiveView.center = layout[nextAvailableLayoutSquare].center;
    
    
    [UIView beginAnimations:@"Appearances" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:IMAGE_GROW_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(liveImageIsDoneGrowingBigger)];
    
    [sender setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
    [sender setAlpha:0.0];
    [newLiveView setTransform:CGAffineTransformMakeScale(1.15, 1.15)];
    [newLiveView setAlpha:1.0];
    
    [UIView commitAnimations];

    [newLiveView release];
    
}

- (void)liveImageIsDoneGrowingBigger {
    
    PressAndHoldView *liveView;
    for (PressAndHoldView *btn in self.view.subviews) {
        if ( btn.tag == buttonTagCurrentlyAnimatingOntoScreen ) liveView = btn;
    }
    

    
    if (liveView) {

        [[liveView liveImageView] toggleLiveFeed];  
        
        [UIView beginAnimations:@"AppearInMainView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:IMAGE_GROW_DURATION];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(liveImageIsDoneReturningToNormalSize)];
        
        [liveView setTransform:CGAffineTransformIdentity];
        
        [UIView commitAnimations];
        
    }

}


- (void)liveImageIsDoneReturningToNormalSize {
    
    PressAndHoldView *liveView;
    for (PressAndHoldView *btn in self.view.subviews) {
        if ( btn.tag == buttonTagCurrentlyAnimatingOntoScreen ) liveView = btn;
    }
    
    
    int nextAvailableLayoutSquare = [self getNextAvailableLayoutSquare];
    
    
    if (liveView) {
        
        CGSize aSize = [self calculateTransformPercentage:layout[nextAvailableLayoutSquare].frame startingRect:liveView.frame];
                
        [UIView beginAnimations:@"AppearInMainView" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:IMAGE_GROW_DURATION];
        
        [liveView setTransform:CGAffineTransformMakeScale(aSize.width, aSize.height)];
        
        [UIView commitAnimations];
                
        layout[nextAvailableLayoutSquare].hasComparableImage = YES;
    }

}



#pragma mark -
#pragma mark Live View Being Compared
- (void)userDoneComparingLiveImage: (id)sender {
    
    for ( int i = 0; i < 4; i++ ) {
        if (CGPointEqualToPoint( [sender center], layout[i].center)) { [layout[i] setCurrentComparableImage:nil]; layout[i].hasComparableImage = NO; }
    }

    
    ScopeViewCon *temp = [sender liveImageView];
    liveViewContainer.liveImageView = temp;
    [liveViewContainer addSubview:liveViewContainer.liveImageView.view];
    
    
    [UIView beginAnimations:@"ShrinkComparedButton" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:IMAGE_GROW_DURATION];
    
    [sender setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
    [sender setAlpha:0.0];
    [sender removeFromSuperview];
    
    [liveViewContainer setTransform:CGAffineTransformIdentity];
    [liveViewContainer setAlpha:1.0];
    
    
    [UIView commitAnimations];

    
    
}














#pragma mark -
#pragma mark Images Being Compared
- (void)userDoneComparingThisImage: (id)sender {
    
    
    for ( int i = 0; i < 4; i++ ) {
        if (CGPointEqualToPoint( [sender center], layout[i].center)) { [layout[i] setCurrentComparableImage:nil]; layout[i].hasComparableImage = NO; }
    }

    
    /*Find button in the scroll view sender came from.*/
    UIButton *originalButton;
    for (UIButton *btn in clientImagesScroller.subviews) {
        if (btn.tag == [sender tag] - 11100) { originalButton = btn; }
    }
        
    
    [UIView beginAnimations:@"ShrinkComparedButton" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:IMAGE_GROW_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(comparedImageDoneShrinking)];
    
    [sender setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
    [sender setAlpha:0.0];
    [sender removeFromSuperview];
    
    [originalButton setTransform:CGAffineTransformIdentity];
    [originalButton setAlpha:1.0];
    
    
    [UIView commitAnimations];

}







- (UIView *)getLayout:(int)layoutNumber {
    
    return (layout[layoutNumber]) ? layout[layoutNumber] : nil;
    
}
    

- (void)returnLiveViewToSidePanel {
    
    PressAndHoldView *liveView;
    for (PressAndHoldView *pv in self.view.subviews) {
        if ([pv isKindOfClass:[PressAndHoldView class]] && [pv backgroundColor] == [UIColor redColor]) {
            liveView = pv;
            [self userDoneComparingLiveImage:pv];
        }
    }
    
    
    
}


    
- (void)updateLayout
{
    
    /*If we change the layout all images should default back
     to their original view.*/
    [self returnLiveViewToSidePanel];
    [self killClientScroller_images];
    [self populateClientScroller_images];
    
    
    for (int i = 0; i < 4; i++) {
        
        if (layout[i]) {
            [layout[i] removeFromSuperview];
            self->layout[i] = nil;
         }
    }
    

    
    CGRect rootViewRect = self.view.frame;
    
    if (vertControl) {
        
        
        /*"viewingRect" is the full viewable space for our side-by-sides.*/
        CGRect viewingRect = CGRectMake(sidePanelView.frame.size.width, /*All the way left*/
                                        titleBar.frame.size.height /*Topmost visible point*/, 
                                        rootViewRect.size.width - sidePanelView.frame.size.width /*As wide as the screen*/, 
                                        abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) /*Space between bottom of title bar and top of segmented control*/);
        
        
        /*This one keeps proportions but computes a third 
         the size of the viewing rect.*/
        CGRect oneThird = CGRectMake(viewingRect.origin.x, viewingRect.origin.y, viewingRect.size.width / 3, viewingRect.size.height / 3); 
        CGRect oneQuarter = CGRectMake(viewingRect.origin.x, viewingRect.origin.y, viewingRect.size.width / 2, viewingRect.size.height / 2);
        CGRect oneHalf = CGRectMake(viewingRect.origin.x, viewingRect.origin.y, viewingRect.size.width / 2, viewingRect.size.height / 2);
                                      
        
        
                                      //sidePanelView.frame.size.width, titleBar.frame.size.height, (rootViewRect.size.width - sidePanelView.frame.size.width) / 3, viewingRect.size.height / 3);
//        CGRect middleThird = CGRectMake(leftThird.origin.x + leftThird.size.width, viewingRect.origin.y, viewingRect.size.width / 3, viewingRect.si
//                                        //leftThird.origin.x + leftThird.size.width, leftThird.origin.y, leftThird.size.width, leftThird.size.height);
//        CGRect rightThird = CGRectMake(middleThird.origin.x + middleThird.size.width, middleThird.origin.y, middleThird.size.width, middleThird.size.height);
        
        
        CGRect leftHalfScreen = CGRectMake(sidePanelView.frame.size.width,                                    /*All the way left*/
                                       titleBar.frame.size.height                                             /*Topmost visible point*/, 
                                       (rootViewRect.size.width - sidePanelView.frame.size.width) / 2                          /*Half as wide as the screen*/, 
                                           abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) /*Space between bottom of title bar and top of segmented control*/);
        
        CGRect rightHalfScreen = CGRectMake(leftHalfScreen.size.width + leftHalfScreen.origin.x, /*Right side where first layout ends*/
                                            titleBar.frame.size.height /*Topmost visible point*/, 
                                            (rootViewRect.size.width - sidePanelView.frame.size.width )/ 2 /*Half as wide as the screen*/, 
                                            abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) /*Space between bottom of title bar and top of segmented control*/);

        CGRect quarterOne = CGRectMake(sidePanelView.frame.size.width, /*All the way left*/
                                       titleBar.frame.size.height /*Topmost visible point*/, 
                                       (rootViewRect.size.width - sidePanelView.frame.size.width ) / 2 /*Half as wide as the screen*/, 
                                       abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) / 2 /*Half of the Space between bottom of title bar and top of segmented control*/);
        
        CGRect quarterTwo = CGRectMake(leftHalfScreen.size.width + leftHalfScreen.origin.x, /*Right side where first layout ends*/
                                       titleBar.frame.size.height /*Topmost visible point*/, 
                                       (rootViewRect.size.width - sidePanelView.frame.size.width ) / 2 /*Half as wide as the screen*/, 
                                       abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) / 2 /*Half of the Space between bottom of title bar and top of segmented control*/);
        
        CGRect bottomHalf = CGRectMake(sidePanelView.frame.size.width, /*All the way left*/
                                       leftHalfScreen.origin.y + quarterOne.size.height /*Bottom of layout 0*/, 
                                       rootViewRect.size.width - sidePanelView.frame.size.width /*As wide as the screen*/, 
                                       abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) / 2 /*Half of the Space between bottom of title bar and top of segmented control*/);
        
        CGRect quarterThree = CGRectMake(sidePanelView.frame.size.width, /*All the way left*/
                                         leftHalfScreen.origin.y + quarterOne.size.height /*Bottom of layout 0*/, 
                                         (rootViewRect.size.width - sidePanelView.frame.size.width) / 2/*Half As wide as the screen*/, 
                                         abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) / 2 /*Half of the Space between bottom of title bar and top of segmented control*/);
        
        CGRect quarterFour = CGRectMake(leftHalfScreen.size.width + leftHalfScreen.origin.x, /*Right side where first layout ends*/
                                        quarterOne.origin.y + quarterOne.size.height /*Bottom of layout 0*/, 
                                        (rootViewRect.size.width - sidePanelView.frame.size.width ) /2 /*As wide as the screen*/, 
                                        abs(titleBar.frame.size.height - clientImagesScroller.frame.origin.y) / 2 /*Half of the Space between bottom of title bar and top of segmented control*/);
        
        
        
        
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.25f];
        
        
        if (vertControl.selectedSegment == ImageLayout_SingleImage) {
            if ( layout[0] == nil ) [self addLayout:0];
            layout[0].frame = viewingRect;
            layout[0].backgroundColor = [UIColor brownColor];

        }
        
        
        else if (vertControl.selectedSegment == ImageLayout_DoubleImage) {
            if ( layout[0] == nil ) [self addLayout:0];
            layout[0].frame = oneHalf;
            layout[0].backgroundColor = [UIColor whiteColor];
            layout[0].center = CGPointMake( CGRectGetMidX(oneHalf), CGRectGetMidY(viewingRect) );

            
            if ( layout[1] == nil ) [self addLayout:1];
            layout[1].frame = oneHalf; 
            layout[1].backgroundColor = [UIColor grayColor];
            layout[1].center = CGPointMake( CGRectGetMidX(oneHalf) + oneHalf.size.width, CGRectGetMidY(viewingRect) );

        }
        
        
        
        else if (vertControl.selectedSegment == ImageLayout_TripleImage) {
            if ( layout[0] == nil ) [self addLayout:0];
            layout[0].frame = oneThird;
            layout[0].backgroundColor = [UIColor purpleColor];
            layout[0].center = CGPointMake( CGRectGetMidX(oneThird), CGRectGetMidY(viewingRect) );
            
            if ( layout[1] == nil ) [self addLayout:1];
            layout[1].frame = oneThird;
            layout[1].backgroundColor = [UIColor orangeColor];
            layout[1].center = CGPointMake( CGRectGetMidX(oneThird) + oneThird.size.width, CGRectGetMidY(viewingRect) );

            
            if ( layout[2] == nil ) [self addLayout:2];
            layout[2].frame = oneThird;
            layout[2].backgroundColor = [UIColor redColor];
            layout[2].center = CGPointMake( CGRectGetMidX(oneThird) + (oneThird.size.width * 2), CGRectGetMidY(viewingRect) );

            
        }
        
        
        else if (vertControl.selectedSegment == ImageLayout_QuadImage) {
            
            if ( layout[0] == nil ) [self addLayout:0];
            layout[0].frame = oneQuarter;
            //CGRectMake(oneQuarter.origin.x + (oneQuarter.size.width / 2), oneQuarter.origin.y + (oneQuarter.size.height / 2), oneQuarter.size.width, oneQuarter.size.height);
            layout[0].backgroundColor = [UIColor redColor];

            
            if ( layout[1] == nil ) [self addLayout:1];
            layout[1].frame = oneQuarter;
            //CGRectMake( (viewingRect.origin.x + viewingRect.size.width) - (oneQuarter.size.width * 1.5f) , oneQuarter.origin.y + (oneQuarter.size.height / 2), oneQuarter.size.width, oneQuarter.size.height);;
            layout[1].backgroundColor = [UIColor greenColor];
            layout[1].center = CGPointMake( CGRectGetMidX(oneQuarter) + oneQuarter.size.width, CGRectGetMidY(oneQuarter));

            
            if ( layout[2] == nil ) [self addLayout:2];
            layout[2].frame = oneQuarter;
            //CGRectMake(oneQuarter.origin.x + (oneQuarter.size.width / 2), (viewingRect.origin.y + viewingRect.size.height) - (oneQuarter.size.height * 1.5f), oneQuarter.size.width, oneQuarter.size.height);;
            layout[2].backgroundColor = [UIColor whiteColor];
            layout[2].center = CGPointMake( CGRectGetMidX(oneQuarter), CGRectGetMidY(oneQuarter) + oneQuarter.size.height);

            
            if ( layout[3] == nil ) [self addLayout:3];
            layout[3].frame = oneQuarter;
            //CGRectMake( (viewingRect.origin.x + viewingRect.size.width) - (oneQuarter.size.width * 1.5f), (viewingRect.origin.y + viewingRect.size.height) - (oneQuarter.size.height * 1.5f), oneQuarter.size.width, oneQuarter.size.height);;
            layout[3].backgroundColor = [UIColor grayColor];
            layout[3].center = CGPointMake( CGRectGetMidX(oneQuarter) + oneQuarter.size.width, CGRectGetMidY(oneQuarter) + oneQuarter.size.height);

        }
        
        [UIView commitAnimations];

    }
    

    
}
    

- (void)didReceiveDraggedImage {
    
    printf("\ndidReceiveDraggedImage");
    
}


- (void)addLayout: (int)layoutNumber
{
    self->layout[layoutNumber] = [[Layout alloc] init];
    layout[layoutNumber].hasComparableImage = NO;
    
    [self.view addSubview:layout[layoutNumber]];
}

@end
