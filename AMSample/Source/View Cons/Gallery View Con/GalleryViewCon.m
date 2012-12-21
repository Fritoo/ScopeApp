//
//  GalleryViewCon.m
//  AMSample
//
//  Created by Miles Alden on 7/19/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import "GalleryViewCon.h"
#import "CompareViewAppDelegate.h"
#import "ControlPoint.h"
#import "SideBySideCon.h"

@interface Folder : UIImageView {
@private
}
@end


@implementation Folder
@end














//ImageRep
@interface ImageRep : UIImageView {
@private
    NSString *path;
    GalleryViewCon *gallery;
}

- (GalleryViewCon *)gallery;
- (void)setGallery: (GalleryViewCon *)theGallery;
- (void)setPath: (NSString *)thePath;

@end


@implementation ImageRep

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    printf("\ntouched\n");
    
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    //[[del controlPoint] killThis:gallery hasView:YES];
    
    if ( del.window.rootViewController.modalViewController ) [del.window.rootViewController dismissModalViewControllerAnimated:YES];
    
    NSLog(@"\n\n***\npath: %@\n***\n\n", path);
    
    [[del controlPoint] performSelector:@selector(loadImageViewer:) withObject:path afterDelay:1.0f];
    
}

- (GalleryViewCon *)gallery {return gallery;}
- (void)setGallery: (GalleryViewCon *)theGallery {gallery = theGallery;}
- (void)setPath: (NSString *)thePath { self->path = [thePath retain]; }


@end


















//IconMaker
@interface IconMaker : NSObject {
@private
    
}
+ (ImageRep *)imageRepForFilename: (NSString *)name;

@end
@implementation IconMaker

+ (ImageRep *)imageRepForFilename: (NSString *)name
{
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"negative" ofType:@"png"];
    
    ImageRep *image = [[ImageRep alloc] initWithImage:[UIImage imageWithContentsOfFile:name]];
    [image setFrame:CGRectMake(0, 0, 75, 75)];
    [image setUserInteractionEnabled:YES];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 150, 24)];
    
    NSMutableString *theName = [[NSMutableString alloc] initWithString:[name lastPathComponent]];
    [theName replaceOccurrencesOfString:@".png" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [theName length])];
    
    [label setText:theName];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica" size:13]];
    [image addSubview:label];
    [label release];
    [theName release];
    
    return image;
}

@end
















//Gallery
@implementation GalleryViewCon
@synthesize albumTitle;

  
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

    
- (void)viewDidLoad
{
    printf("ViewDidLoad_gallery");
    if ( albumManagerCon ) {
        albumManagerCon.mainViewCon = self;
    }
    
    [self loadAlbumData];
    [self loadImageRepresentation];
    
    
    
    NSError *anError = nil;
    NSLog(@"%@", (bar.items)[0]);
    UINavigationItem *temp = (bar.items)[0];
    UIBarButtonItem *aTemp = (temp.rightBarButtonItems)[0];
    
    
    //[UIImagePNGRepresentation(item.image) writeToFile:@"~/Desktop/AnImage.png" options:NSDataWritingAtomic error:&anError];


}



- (void)updateDisplay {
    
    [self loadAlbumData];
    [self loadImageRepresentation];
    
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.controlPoint.sideBySideCon setCurrentAlbumTitle:albumTitle];
    
}




- (void)loadAlbumData
{
    
    //Get default file path for gallery
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:MAIN_GALLERY_FOLDER_NAME];
    
    
    if ( !albumTitle ) albumTitle = DEFAULT_ALBUM;
    
    fullPath = [fullPath stringByAppendingPathComponent:albumTitle];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *fileError = nil;
    [fileManager createDirectoryAtPath:fullPath withIntermediateDirectories:NO attributes:nil error:&fileError];
        
    NSError *theError = nil;
    
    
    self->dirContents = [[fileManager contentsOfDirectoryAtPath:fullPath error:&theError] retain];
    
}

- (void)loadImageRepresentation
{
    
    if ( dirContents )
    {
        NSLog(@"\n***\n\n%@\n\n***\n", dirContents);

        /*Reset images display*/
        for ( id ir in self.view.subviews ) {
                
            if ( [ir isKindOfClass:[ImageRep class]] ) [ir removeFromSuperview];
        }
        
        
        
        /*White viewing rect*/
        CGRect viewRect = CGRectMake(albumManagerCon.view.frame.size.width, bar.frame.size.height, 1024 - albumManagerCon.view.frame.size.width, 768 - bar.frame.size.height);
       
        
        float margin = 35.0f;
        int originX = viewRect.origin.x + margin;
        int originY = viewRect.origin.y + margin;
        
        
        //Get default file path for gallery
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        NSString *fullPath;

        int i = 0;
        
        for (NSString *fileName in dirContents)
        {
            if ( [[fileName pathExtension] isEqualToString:@"png"] )
            {
                fullPath = [documentsDirectory stringByAppendingPathComponent:MAIN_GALLERY_FOLDER_NAME];
                fullPath = [fullPath stringByAppendingPathComponent:albumTitle];
                fullPath = [fullPath stringByAppendingPathComponent:fileName];
                ImageRep *theImage = [IconMaker imageRepForFilename:fullPath]; 
                
                [theImage setFrame: CGRectMake(originX , originY, 150, 150)];
                [theImage setGallery:self];
                [theImage setPath:fullPath];
                [self.view addSubview: theImage];
            
//                [imageRep release];
                
                
                
                if ( i < 3 ) {
                    originX += theImage.frame.size.width + margin;
                    i++;
                }
                
                else if ( i == 3 ) {
                    originX = viewRect.origin.x + margin;
                    originY += theImage.frame.size.width + margin;
                    i = 0;
                }
                
                
                
                /*One line*/
                //if  ( originX < viewRect.size.width ) { originX += 170; }
                
                /*Make new line*/
                //if ( originX >= viewRect.size.width - margin ) { originX += -(originX - 20); originY += 170; }
            }   
            
        }
    }
    
    
}


- (IBAction)backButton
{
    //Kill info page
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[del controlPoint] killThis:self hasView:YES];
    
    //Load main menu
    [[del controlPoint] loadMainMenu];
}

- (IBAction)pressedDoneButton:(id)sender {
    
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.window.rootViewController dismissModalViewControllerAnimated:YES];
    [del.controlPoint.sideBySideCon updateLayout];
    
}

     

@end


