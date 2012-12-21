//
//  CALayer+AMLayerAdditions.m
//  AMSample
//
//  Created by Miles Alden on 12/2/12.
//
//

#import "AMLayerAdditions.h"

@implementation CALayer (AMLayerAdditions)

- (NSString *)transformString {
    
    NSString *str = [NSString stringWithFormat:
                     @"\n"
                     @"m11:%0.4f m12:%0.4f m13:%0.4f m14:%0.4f\n"
                     @"m21:%0.4f m22:%0.4f m23:%0.4f m24:%0.4f\n"
                     @"m31:%0.4f m32:%0.4f m33:%0.4f m34:%0.4f\n"
                     @"m41:%0.4f m42:%0.4f m43:%0.4f m44:%0.4f\n",
                     self.transform.m11,
                     self.transform.m12,
                     self.transform.m13,
                     self.transform.m14,
                     self.transform.m21,
                     self.transform.m22,
                     self.transform.m23,
                     self.transform.m24,
                     self.transform.m31,
                     self.transform.m32,
                     self.transform.m33,
                     self.transform.m34,
                     self.transform.m41,
                     self.transform.m42,
                     self.transform.m43,
                     self.transform.m44
                     ];
    
    return str;
    
}

@end
