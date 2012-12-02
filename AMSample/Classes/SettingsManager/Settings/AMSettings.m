//
//  AMSettings.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSettings.h"

#define COLOR CANTALOUPE

static BOOL *locked = NO;

@implementation AMSettings


- (void)loadDefaults {
    
    self.lastOpenedAlbum = kAM_NotFound;
    self.saveToPhotoRoll = YES;
    
}


@end
