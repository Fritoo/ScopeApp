//
//  SaveImageCon.h
//  AMSample
//
//  Created by Miles Alden on 2/13/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlbumManagerCon.h"

@interface SaveImageCon : UIViewController <UITextFieldDelegate>{
    
    IBOutlet UINavigationBar *topNavBar;
    
    
    
}

    
@property (retain) IBOutlet UIImageView *tempImageView;
@property (retain) IBOutlet UITextField *textF;
@property (retain) NSString *albumTitle;
@property (retain) IBOutlet AlbumManagerCon *albumManagerCon;


- (IBAction)pressedCancel:(id)sender;
- (IBAction)pressedSave:(id)sender;
- (IBAction)textFieldDidChangeContent: (id)sender;

@end
