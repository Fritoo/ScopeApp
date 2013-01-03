//
//  main.m
//  AMSample
//
//  Created by Susumu.KOBAYASHI on 10/02/09.
//  Copyright 2010 Scalar Co.,LTD All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMAppTests.h"
#import "AMLauncher.h"
#import "CompareViewAppDelegate.h"


int main(int argc, char *argv[]) {
    
#if (defined(DEBUG) && APP_TESTS)
    
    [[NSNotificationCenter defaultCenter] addObserver:[AMAppTests class]
                                             selector:@selector(executeApplicationTests)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];

//    [AMAppTests executeApplicationTests];
#endif
    @autoreleasepool {
        
        [AMLauncher launch];
        int retVal = UIApplicationMain(argc, argv, nil, nil);
        return retVal;
    }
    
}
