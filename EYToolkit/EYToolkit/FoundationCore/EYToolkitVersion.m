//
//  EYFrameworkVersion.m
//  EYFrameworkCore
//
//  Created by Edward Yang on 3/12/13.
//  Copyright (c) 2013 EdwardYang. All rights reserved.
//

#import "EYToolkitVersion.h"

static NSString* const EYFrameworkVersionString = @"1.0.0";

@implementation EYToolkitVersion

+ (NSString *)version {
    return EYFrameworkVersionString;
}

+ (NSInteger)majorVersion {
    return [[[EYFrameworkVersionString componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
}

+ (NSInteger)minorVersion {
    return [[[EYFrameworkVersionString componentsSeparatedByString:@"."] objectAtIndex:1] intValue];
}

+ (NSInteger)bugfixVersion {
    return [[[EYFrameworkVersionString componentsSeparatedByString:@"."] objectAtIndex:2] intValue];
}

@end