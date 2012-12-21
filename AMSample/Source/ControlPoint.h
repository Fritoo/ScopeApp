//
//  ControlPoint.h
//  AMSample
//
//  Created by Miles Alden on 7/15/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScopeViewCon, MainMenuViewCon, InfoPageViewCon, GalleryViewCon, ImageViewer, SideBySideCon, SaveImageCon;

typedef enum AnimationType {

    AnimationTypeNone = -1,
    AnimationTypeHorizontalNavigation = 0,
    AnimationTypePageCurl = 1,
    AnimationTypeFlipHorizontally = 2,
    AnimationTypeFlipVertically = 3,
    AnimationTypeFadeToTransparent = 4,
    AnimationTypeFadeInFromTransparent = 5
    

} AnimationType;

typedef enum NavigationDirection {
    
    NavigationDirectionForward = 0,
    NavigationDirectionBackward = 1
    
} NavigationDirection;

@interface ControlPoint : NSObject {
    
    ScopeViewCon *sdkVConWrap;
    MainMenuViewCon *mainMenuCon;
    InfoPageViewCon *infoPageCon;
    GalleryViewCon *galleryCon;
    SaveImageCon *saveImageCon;
    
    ImageViewer *imageViewer;
    id disposalObject;
}

@property (retain) SideBySideCon *sideBySideCon;


- (void)killThis: (id)object hasView: (BOOL)hasView;
- (void)loadScope;
- (void)loadMainMenu;
- (void)loadInfoPage;
- (void)loadGallery;
- (void)loadImageViewer: (NSString *)imagePath;
- (void)loadSideBySide;
- (void)loadSaveImage;

- (SaveImageCon *)getSaveImageCon;

- (void)animateOntoScreen: (id)vCon callSetup: (BOOL)shouldCallSetup animationType: (AnimationType)type direction: (NavigationDirection)direction;
- (void)completedAnimation;


@end
