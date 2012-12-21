//
//  AMConstants.h
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#ifndef AMSample_AMConstants_h
#define AMSample_AMConstants_h


#define kAM_NotFound @"none"
#define kAM_ViewMovedToSuperview @"kAM_ViewMovedToSuperview"

#define STR_LINK_URL [NSURL URLWithString:@"http://www.schooltr.com/index.html"]
#define ROOT_DIR @"AMCompareView/"
#define MAIN_GALLERY_FOLDER_NAME @"Gallery"
#define DEFAULT_ALBUM @"Scope Album"
#define APP_RATER_FILE ROOT_DIR @"am.plist"
#define NUM_LAUNCHES 

#define degreesToRadians(x) (M_PI * x / 180.0)

#define DB_URL @"http://localhost/AMCompareView/currentVersion/"
#define REL_URL @"https://google.com/"
#define UPDATE_URL ( DEBUG ) ? DB_URL : REL_URL

#endif
