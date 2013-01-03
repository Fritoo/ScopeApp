//
//  GalleryViewCon.h
//  AMSample
//
//  Created by Miles Alden on 7/19/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlbumManagerCon.h"

@interface GalleryViewCon : UIViewController {
    
    
    NSArray *dirContents;
    IBOutlet AlbumManagerCon *albumManagerCon;
    IBOutlet UINavigationBar *bar;
    
}

@property (strong) NSString *albumTitle;

- (void)loadAlbumData;
- (void)loadImageRepresentation;

- (IBAction)backButton;
- (IBAction)pressedDoneButton:(id)sender;
- (void)updateDisplay;

@end
