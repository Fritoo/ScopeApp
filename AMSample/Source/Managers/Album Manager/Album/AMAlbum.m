//
//  AMAlbum.m
//  AMSample
//
//  Created by Miles Alden on 12/20/12.
//
//

#import "AMAlbum.h"
#import "NSObject+ClassName.h"

@implementation AMAlbum

- (id)initWithPath:(NSString *)savedAlbumPath {
    
    if ( self = [super init] ) {
        // Do stuff
        if ( nil != savedAlbumPath ) {
            self.path = savedAlbumPath;
            self.images = [[NSMutableDictionary alloc] init];
        }
    
    }
    
    return self;
}


- (void)loadSavedImages {
    
    // Iterate over contents at path
    // and load images into memory
    //
    
    for ( id imgFile in [AMFileManager contentsAtPath:self.path] ) {
        UIImage *img = [UIImage imageWithContentsOfFile:imgFile];
        if ( nil == img ) {
            LogError(@"Couldn't load image file %@", imgFile);
        } else {
            [self.images setObject:img forKey:imgFile];
        }
    }
    
}

- (int)numImages {
    return self.images.count;
}

- (UIImage *)getImageNamed:(NSString *)imageName {
    return [self.images objectForKey:imageName];
}

- (void)setNewImage:(UIImage *)newImage name:(NSString *)name {
    
    if ( nil == newImage ) {
        LogError(@"Couldn't add image named %@ from data.");
        return;
    }
    
    [self.images setObject:newImage forKey:name];
    
}

- (void)setNewImageFromData:(NSData *)imgData name:(NSString *)name {

    if ( nil == imgData ) {
        LogError(@"Couldn't add image named %@ from data.");
        return;
    }
    
    if ( nil == name ) {
        name = [self nameDefault];
    }
    
    UIImage *newImage = [UIImage imageWithData:imgData];
    [self setNewImage:newImage name:name];

}

- (NSString *)nameDefault {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"]; // 2009-02-01 19:50:41 PST
    return [dateFormat stringFromDate:[NSDate date]];
}


@end
