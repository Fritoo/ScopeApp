//
//  AMSettings.m
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMSettings.h"
#import "NSObject+ClassName.h"

#define COLOR CANTALOUPE

static BOOL *locked = NO;

@implementation AMSettings


- (id)init {
    if ( self = [super init] ) {
        [self loadDefaults];
    }
    
    return self;
}


- (void)loadDefaults {
    
    self.lastOpenAlbum = kAM_NotFound;
    self.saveToPhotoRoll = YES;
    
}




@end
