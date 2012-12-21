//
//  NSObject+ClassName.h
//  
//
//  Created by Miles Alden on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMLogging.h"
#import "AMConstants.h"
#import "AMCategories.h"
#import "EnumHeader.h"
#import "AMFileManager.h"

@interface NSObject (ClassName)

- (NSString *)className;
- (int)isContainerClass;
- (int)isArray;
- (int)isDictionary;

- (NSMutableArray *)properties;
- (NSMutableArray *)methods;
- (NSMutableArray *)ivars;

@end
