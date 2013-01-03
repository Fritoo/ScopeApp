//
//  SaveImageCon.h
//  AMSample
//
//  Created by Miles Alden on 2/13/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlbumManagerViewCon.h"

@interface SaveImageCon : UIViewController <UITextFieldDelegate>{
    
    IBOutlet UINavigationBar *topNavBar;
    
    
    
}

    
@property (strong) IBOutlet UIImageView *tempImageView;
@property (strong) IBOutlet UITextField *textF;
@property (strong) NSString *albumTitle;
@property (strong) IBOutlet AlbumManagerCon *albumManagerCon;


- (IBAction)pressedCancel:(id)sender;
- (IBAction)pressedSave:(id)sender;
- (IBAction)textFieldDidChangeContent: (id)sender;

@end
