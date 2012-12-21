//
//  AlbumManagerCon.h
//  AMSample
//
//  Created by Miles Alden on 2/29/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumManagerCon : UITableViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UITextFieldDelegate>
{
    NSMutableArray *contentItems;
    
}

@property (retain) id mainViewCon;

- (void)makeAlbumNamed: (NSString *)albumName;
- (void)updateTableContent;

@end
