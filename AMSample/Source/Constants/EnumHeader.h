//
//  EnumHeader.h
//  AMSample
//
//  Created by Miles Alden on 2/1/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#ifndef AMSample_EnumHeader_h
#define AMSample_EnumHeader_h

typedef enum DragState
{
    DragStateDisabled = 0,
    DragStateEnabled = 1,
    DragStateUnknown = 2
} DragState;

typedef enum ContainerState
{
    ContainerStateInScrollView = 0,
    ContainerStateInMainView = 1,
    ContainerStateInLayoutContainer = 2,
    ContainerStateInStartingView = 3
} ContainerState;

typedef enum AMTransitionType {
    
    AMTransitionType_None =             0,
    AMTransitionType_CrossFade =        1,
    AMTransitionType_BottomOfStack =    2,
    AMTransitionType_PopTopOfStack =    3,
    
    AMTransitionType_SwipeLeft =        4,
    AMTransitionType_SwipeRight =       5,
    AMTransitionType_SwipeUp =          6,
    AMTransitionType_SwipeDown =        7
    
    
} AMTransitionType;


#endif
