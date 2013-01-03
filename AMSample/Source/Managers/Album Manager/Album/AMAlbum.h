//
//  AMAlbum.h
//  AMSample
//
//  Created by Miles Alden on 12/20/12.
//
//

#import <Foundation/Foundation.h>

@interface AMAlbum : NSObject

@property (strong) NSString *path;
@property (strong) NSMutableDictionary *images;


- (id)initWithPath:(NSString *)savedAlbumPath;
- (void)loadSavedImages;
- (int)numImages;

@end
