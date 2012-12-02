//
//  main.m
//  AMSample
//
//  Created by Susumu.KOBAYASHI on 10/02/09.
//  Copyright 2010 Scalar Co.,LTD All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMAppTests.h"

int main(int argc, char *argv[]) {
    
#if (defined(DEBUG) && APP_TESTS)
    
    [[NSNotificationCenter defaultCenter] addObserver:[AMAppTests class]
                                             selector:@selector(executeApplicationTests)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];

//    [AMAppTests executeApplicationTests];
#endif
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
