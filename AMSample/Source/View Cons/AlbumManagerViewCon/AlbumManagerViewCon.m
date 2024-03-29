//
//  AlbumManagerCon.m
//  AMSample
//
//  Created by Miles Alden on 2/29/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import "AlbumManagerViewCon.h"
#import "CompareViewAppDelegate.h"
#import "GalleryViewCon.h"
#import "NSObject+ClassName.h"

#define COLOR MOSS

@implementation AlbumManagerCon

@synthesize mainViewCon;

- (void)viewDidLoad {
    
    contentItems = [[NSMutableArray alloc] initWithObjects:@"Add New Album...", nil];

    NSString *fullPath = [AMFileManager pathForMainGallery];
    [AMFileManager checkAndBuildPath:fullPath];
    [AMFileManager checkAndBuildPath:[AMFileManager pathForDefaultGallery]];
    [contentItems addObjectsFromArray:[AMFileManager contentsAtPath:fullPath]];
    
    Log(@"%@", contentItems);
}   



- (void)makeAlbumNamed: (NSString *)albumName {
    
    if ( !albumName ) {
        Log(@"**ERROR** No album name specified.");
        return;
    }
    
    //Get default file path for gallery
    [AMFileManager checkAndBuildPath:[AMFileManager pathForNewAlbum:albumName]];
    [self updateTableContent];
    
}

- (void)updateTableContent {
    
    // Purge and reload
    [contentItems removeAllObjects];
    [contentItems addObject:@"Add New Album..."];
    [contentItems addObjectsFromArray: [AMFileManager contentsAtPath:[AMFileManager pathForMainGallery]]];
    [self.tableView reloadData];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


#pragma mark - TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return contentItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    if ( indexPath.row == 0 ) cell.accessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    cell.textLabel.text = contentItems[indexPath.row];

    return cell;

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Albums";
}




#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    
    if ( indexPath.row == 0 ) {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Album" message:@"Please name this album\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
        alert.tag = 8008;
        CGRect scrRect = [[UIScreen mainScreen] bounds];
        
        alert.center = CGPointMake (scrRect.size.width / 2,  scrRect.size.height / 3);
        //    CGRect newFrame = CGRectMake(alert.frame.origin.x, alert.frame.origin.y, alert.frame.size.width, alert.frame.size.height + 150);
        //    alert.frame = newFrame;
        
        
        // Build text field1
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 30.0f)];
        tf.delegate = self;
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.tag = 1111;
        tf.placeholder = @"Album";
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.keyboardType = UIKeyboardTypeAlphabet;
        tf.keyboardAppearance = UIKeyboardAppearanceAlert;
        tf.autocapitalizationType = UITextAutocapitalizationTypeWords;
        tf.autocorrectionType = UITextAutocorrectionTypeNo;
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        
        // Show alert and wait for it to finish displaying
        [alert show];
        while (CGRectEqualToRect(alert.bounds, CGRectZero));
        
        
        // Find the center for the text field and add it
        CGRect bounds = alert.bounds;
        tf.center = CGPointMake(bounds.size.width / 2.0f, bounds.size.height / 2.0f - 10.0f);
        [alert addSubview:tf];

    }
    
    else {
        
        for ( int i = 0; i < contentItems.count; i++ ) {
            
            [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] setAccessoryType:UITableViewCellAccessoryNone];
            
        }
        
        
        if ( mainViewCon ) {
            [mainViewCon setAlbumTitle:contentItems[indexPath.row]];
            if ( [mainViewCon isKindOfClass:[GalleryViewCon class]] ) { [mainViewCon updateDisplay]; } 
            
        }
          
        
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
}

#pragma mark - TextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ( textField.tag = 1111 ) {
        [textField resignFirstResponder];
        [self makeAlbumNamed:textField.text];
        
        UIAlertView *temp = (UIAlertView *)textField.superview;
        [temp dismissWithClickedButtonIndex:0 animated:YES];
        
        
    }
}

#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if ( alertView.tag == 8008 ) {
        if (buttonIndex > 0) {
            
            /*Find the text field*/
            UITextField *temp;
            for (id sub in alertView.subviews) {
                if ( [sub tag] == 1111 ) temp = sub;
            }
            
            if ( temp.text.length > 0 )
                [self makeAlbumNamed:temp.text];
            
        }
    }
}


@end
