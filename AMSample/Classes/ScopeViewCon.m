//
//  ScopeViewCon.m
//  AMSample
//
//  Created by Miles Alden on 7/14/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import "ScopeViewCon.h"
#import "AMSampleAppDelegate.h"
#import "ControlPoint.h"
#import "SaveImageCon.h"
#import "SideBySideCon.h"

@implementation ScopeViewCon

@synthesize scopeView;





- (void)viewDidLoad
{
    [super viewDidLoad];
    printf("\n\n***\nScopeViewCon viewDidLoad\n***\n\n");
    
    if ( !scopeView )
    {
        CGRect rect = CGRectMake(0, 0, 180, 128);
        scopeView = [[AMImageView alloc] init:self.view rect:rect];
        
        [scopeView setUserInteractionEnabled:YES];
        [scopeView setDelegate:self];
		[scopeView setBtnControl:TRUE];
        [scopeView setFreeze:FALSE];
//		[scopeView setFrzLabel:frzField];
//		[scopeView setCapLabel:capField];
//		[scopeView setIndicator:indField];
        
//		[scopeView setWaitImage:IMG1 next:IMG2];
		[scopeView setSavePictureFolderFlag:TRUE];
//		[scopeView setCapViewTime:1.5];
//		[self.view addSubview:frzField];
//		[self.view addSubview:capField];
//		[self.view addSubview:indField];	

        self.view = scopeView;
    }
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
}

- (void)setup {
    
    printf("ScopeViewCon setup");
    
    /*Same as in viewDidLoad, but for manual setup purposes.*/
    if ( !scopeView )
    {
        CGRect rect = CGRectMake(0, 0, 180, 128);
        self->scopeView = [[AMImageView alloc] init:self.view rect:rect];
        
        [scopeView setUserInteractionEnabled:YES];
        [scopeView setDelegate:self];
		[scopeView setBtnControl:TRUE];
        
        //		[scopeView setFrzLabel:frzField];
        //		[scopeView setCapLabel:capField];
        //		[scopeView setIndicator:indField];
        
        //		[scopeView setWaitImage:IMG1 next:IMG2];
		[scopeView setSavePictureFolderFlag:TRUE];
        //		[scopeView setCapViewTime:1.5];
        //		[self.view addSubview:frzField];
        //		[self.view addSubview:capField];
        //		[self.view addSubview:indField];	
        
        self.view = scopeView;
        
    }
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];

    
}




- (IBAction)toggleLiveFeed
{
    if ( liveFeed && stillFeed )
    {
        NSString *livePath;
        NSString *stillPath;
        
        //Push live feed
        if ( liveFeed.tag == 0 )
        {
            
            livePath = [[NSBundle mainBundle] pathForResource:@"liveButton_down" ofType:@"png"];
            stillPath = [[NSBundle mainBundle] pathForResource:@"stillButton_up" ofType:@"png"];
            liveFeed.tag = 1;
            stillFeed.tag = 0;
            
            //Unfreeze the feed
            if ( scopeView ) [scopeView setFreeze:false];

        }
        
        //Push still feed
        else
        {
            livePath = [[NSBundle mainBundle] pathForResource:@"liveButton_up" ofType:@"png"];
            stillPath = [[NSBundle mainBundle] pathForResource:@"stillButton_down" ofType:@"png"];
            liveFeed.tag = 0;
            stillFeed.tag = 1;
            
            
            //Freeze the feed
            if ( scopeView ) [scopeView setFreeze:true];

        }
 
        
        //Swap button images
        [liveFeed setImage:[UIImage imageWithContentsOfFile:livePath] forState:UIControlStateNormal];
        [stillFeed setImage:[UIImage imageWithContentsOfFile:stillPath] forState:UIControlStateNormal];
        if ( snapButton ) [self.view bringSubviewToFront:snapButton];

    }

}


//Back to main menu
- (IBAction)backButton
{
    if ( scopeView ) 
    {
        [scopeView stopCapture];
        [scopeView removeFromSuperview];
        [scopeView release];
        self->scopeView = nil;
    }
    
    
    AMSampleAppDelegate *del = [[UIApplication sharedApplication] delegate];
    [[del controlPoint] killThis:self hasView:YES];
    
    [[del controlPoint] loadMainMenu];
    
}


//Save picture
- (IBAction)snapButton
{
    
    
    if ( scopeView )
    {
        
        tempImage = scopeView.image;
        
        AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
        [del.controlPoint loadSaveImage];
        SaveImageCon *saveImageCon = [del.controlPoint getSaveImageCon];
        
        
        saveImageCon.tempImageView = [[UIImageView alloc] initWithImage:tempImage];
        
        
        //saveImageCon.tempImageView.image = tempImage;
        //[[saveImageCon tempImageView] setFrame:CGRectMake(0, 0, tempImage.size.width, tempImage.size.height)];
        //[saveImageCon.tempImageView sizeToFit];
        
        saveImageCon.tempImageView.backgroundColor = [UIColor blueColor];
        [saveImageCon.view addSubview:saveImageCon.tempImageView];
        
        CGPoint textFieldCenter = CGPointMake(saveImageCon.textF.center.x, saveImageCon.view.center.y);
        saveImageCon.tempImageView.center = textFieldCenter;
        
        
    }
}


- (void)filePictureWithName:(NSString *)name album:(NSString *)album
{
    
    tempImage = scopeView.image;
    AMSampleAppDelegate *del = (AMSampleAppDelegate *)[[UIApplication sharedApplication] delegate];

    
    if ( !album ) {
        if ( del.controlPoint.sideBySideCon.currentAlbumTitle ) album = del.controlPoint.sideBySideCon.currentAlbumTitle;
        else { album = DEFAULT_ALBUM; }
    }

    
    /*Gallery Name YYYY/MM/DD, 00:00am/pm.jpg”*/
    NSMutableString *newFileName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    newFileName = [NSMutableString stringWithString:[formatter stringFromDate:[NSDate date]]];
    [newFileName insertString:album atIndex:0];
    [newFileName replaceOccurrencesOfString:@"/" withString:@"-" options:NSLiteralSearch range:NSMakeRange(0, newFileName.length)];
        
    
    if ( !name )
    {
        name = newFileName;
    }

    
    //Get default file path for gallery
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:MAIN_GALLERY_FOLDER_NAME];
    fullPath = [fullPath stringByAppendingPathComponent:album];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *fileError = nil;
    [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:NO attributes:nil error:&fileError];
    

    
    fullPath = [fullPath stringByAppendingPathComponent:name];
    fullPath = [fullPath stringByAppendingPathExtension:@"png"];
    
    NSData *data = UIImagePNGRepresentation(tempImage);
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];
    

    //File to photo roll
    if ( [del shouldSaveToCameraRoll] ) {
        UIImageWriteToSavedPhotosAlbum(tempImage, self, @selector(didWriteImageToAlbum), nil ); 
    }
    
    
    /*Post notification*/
    NSNotification *doneSaving = [NSNotification notificationWithName:@"ScopeFinishedTakingPicture" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:doneSaving];

    
    /*Inform the user*/
    UIImageView *popUp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SavedImage.png"]];
    [del.controlPoint.sideBySideCon.view addSubview:popUp];
    popUp.center = del.controlPoint.sideBySideCon.view.center;
    

    [UIView beginAnimations:@"PopUpSaveImageConfirmation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];

    popUp.alpha = 0.0f;
    
    [UIView commitAnimations];
    
    [popUp release];

    

}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( alertView.tag == 1111 )
    {
        if ( buttonIndex > 0 ) [self filePictureWithName:alertField.text];

    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.15];
    
    alertView.center = CGPointMake(alertView.center.x, alertView.center.y - 75);
    
    [UIView commitAnimations];
}








- (void)finishExport:(UIImage *)image
didFinishSavingWithError:(NSError *)error
		 contextInfo:(void *)contextInfo
{
	NSLog(@" my_savePicture: diden!!");
}


















#pragma mark -
#pragma mark AMMicro Delegate
- (void)captureDone:(UIImage *)image
{
	NSLog(@" captureDone!");
	UIImageWriteToSavedPhotosAlbum( image, 
                                    self,
                                    @selector(finishExport:didFinishSavingWithError:contextInfo:), 
                                    nil );
}

- (void)freezeDone:(bool)isFreeze
{
    
    /*Button click registers here*/
	if( isFreeze )	{
        NSLog(@" freezeDone! -- FREEZE");
        [self performSelectorOnMainThread:@selector(filePictureWithName:album:) withObject:nil waitUntilDone:NO];
    }
	else 	NSLog(@" freezeDone! -- Live");
}











- (void)dealloc
{

    
    
    if ( alertField ){
        [alertField removeFromSuperview];
        self->alertField = nil;
    }
    
    if ( tempImage ) {
        
        self->tempImage = nil;
    }

    
    if ( liveFeed )
    {
        [liveFeed release];
        self->liveFeed = nil;
    }
    
    if ( stillFeed )
    {
        [stillFeed release];
        self->stillFeed = nil;
    }
    
    if ( scopeView ) 
    {
        [scopeView stopCapture];
        [scopeView removeFromSuperview];
        [scopeView release];
        self->scopeView = nil;
    }

    [super dealloc];
        
}






@end
