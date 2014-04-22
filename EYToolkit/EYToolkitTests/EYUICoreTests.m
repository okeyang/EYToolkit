//
//  EYUICoreTests.m
//  EYToolkit
//
//  Created by Edward Yang on 14-4-22.
//  Copyright (c) 2014年 EdwardYang. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "EYUICore.h"

@interface TestImageView : UIView

@end

@implementation TestImageView

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"picture.jpg"];
    [image drawInRect:CGRectMake(0, 0, 100, 100) radius:10.0];
}

@end

@interface EYUICoreTests : GHViewTestCase

@end

@implementation EYUICoreTests

- (void)testDevice {
    GHAssertTrue(CGAffineTransformEqualToTransform(rotateTransformForOrientation(UIInterfaceOrientationLandscapeLeft), CGAffineTransformMakeRotation(M_PI * 1.5)) , nil);
    GHAssertTrue(CGAffineTransformEqualToTransform(rotateTransformForOrientation(UIInterfaceOrientationLandscapeRight), CGAffineTransformMakeRotation(M_PI_2)) , nil);
    GHAssertTrue(CGAffineTransformEqualToTransform(rotateTransformForOrientation(UIInterfaceOrientationPortraitUpsideDown), CGAffineTransformMakeRotation(-M_PI)) , nil);
    GHAssertTrue(CGAffineTransformEqualToTransform(rotateTransformForOrientation(UIInterfaceOrientationPortrait), CGAffineTransformIdentity) , nil);
    GHTestLog(@"isLandscape(%d)", [UIDevice currentDevice].isLandscape);
    GHTestLog(@"isPortrait(%d)", [UIDevice currentDevice].isPortrait);
    GHTestLog(@"deviceOrientation(%d)", [UIDevice currentDevice].deviceOrientation);
    GHTestLog(@"orientationString(%@)", [UIDevice currentDevice].orientationString);
    GHTestLog(@"isPad(%d)", [UIDevice currentDevice].isPad);
    GHTestLog(@"isPhoneSupported(%d)", [UIDevice currentDevice].isPhoneSupported);
    GHTestLog(@"isJailBroken(%d)", [UIDevice isJailBroken]);
    GHTestLog(@"platform(%@)", [UIDevice currentDevice].platform);
    GHTestLog(@"hwmodel(%@)", [UIDevice currentDevice].hwmodel);
    GHTestLog(@"platformType(%d)", [UIDevice currentDevice].platformType);
    GHTestLog(@"platformString(%@)", [UIDevice currentDevice].platformString);
    GHTestLog(@"cpuFrequency(%d)", [UIDevice currentDevice].cpuFrequency);
    GHTestLog(@"busFrequency(%d)", [UIDevice currentDevice].busFrequency);
    GHTestLog(@"cpuCount(%d)", [UIDevice currentDevice].cpuCount);
    GHTestLog(@"totalMemory(%dMB)", [UIDevice currentDevice].totalMemory / 1024 / 1024);
    GHTestLog(@"userMemory(%dMB)", [UIDevice currentDevice].userMemory / 1024 / 1024);
    GHTestLog(@"totalDiskSpace(%fMB)", [UIDevice currentDevice].totalDiskSpace.floatValue / 1024 / 1024);
    GHTestLog(@"freeDiskSpace(%fMB)", [UIDevice currentDevice].freeDiskSpace.floatValue / 1024 / 1024);
    GHTestLog(@"macaddress(%@)", [UIDevice currentDevice].macaddress);
    GHTestLog(@"hasRetinaDisplay(%d)", [UIDevice currentDevice].hasRetinaDisplay);
    GHTestLog(@"deviceFamily(%d)", [UIDevice currentDevice].deviceFamily);
}

- (void)testApplication {
    GHTestLog(@"interfaceOrientation(%d)", [UIApplication sharedApplication].interfaceOrientation);
    GHTestLog(@"isLandscape(%d)", [UIApplication sharedApplication].isLandscape);
    GHTestLog(@"isPortrait(%d)", [UIApplication sharedApplication].isPortrait);
    GHTestLog(@"orientationString(%@)", [UIApplication sharedApplication].orientationString);
}

- (void)testColor {
    UIColor *color = [UIColor colorWithRed:1. green:1. blue:1. alpha:1.];
    GHAssertTrue(color.red == 1., nil);
    GHAssertTrue(color.green == 1., nil);
    GHAssertTrue(color.blue == 1., nil);
    GHAssertTrue(color.alpha == 1., nil);
    GHAssertTrue(color.RGBHex == 0xFFFFFF, nil);
    GHAssertTrue(color.ARGBHex == 0xFFFFFFFF, nil);
    GHAssertEqualStrings([color stringFromColor], @"{1.000, 1.000, 1.000, 1.000}", nil);
    GHAssertEqualStrings([color hexStringFromColor], @"FFFFFFFF", nil);
}

- (void)testColorRandom {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIColor *color = [UIColor randomColor];
    GHTestLog(@"color(%@)", color.stringFromColor);
    GHTestLog(@"color(%@)", color.hexStringFromColor);
    view.backgroundColor = color;
    GHVerifyView(view);
}

- (void)testColorRGB {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRGBHex:0xFF0000];
    GHVerifyView(view);
}

- (void)testColorARGB {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithARGBHex:0x66000000];
    GHVerifyView(view);
}

- (void)testColorHexString {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithHexString:@"0x00FF00"];
    GHVerifyView(view);
}

- (void)testColorHighlightedColor {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [[UIColor colorWithHexString:@"0x00FF00"] highlightedColor];
    GHVerifyView(view);
}

- (void)testColorShadowColor {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [[UIColor colorWithHexString:@"0x00FF00"] shadowColor];
    GHVerifyView(view);
}

- (void)testImageCropped {
    UIImage *image = [UIImage imageNamed:@"picture.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[image imageCroppedToRect:CGRectMake(100, 100, 200, 200)]];
    GHVerifyView(imageView);
}

- (void)testImageTransform {
    UIImage *image = [UIImage imageNamed:@"picture.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[image imageWithTransformWidth:100 height:200 rotate:NO]];
    GHVerifyView(imageView);
}

- (void)testImageDrawInRect {
    TestImageView *imageView = [[TestImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    GHVerifyView(imageView);
}

- (void)testControllerContainView {
    UIViewController *viewController = [[UIViewController alloc] init];
    UIView *view1 = [[UIView alloc] init];
    viewController.view = view1;
    UIView *view2 = [[UIView alloc] init];
    [viewController.view addSubview:view2];
    GHAssertEqualObjects(view2.viewController, viewController, nil);
}

- (void)testViewSnapshot {
    UIImage *image = [UIImage imageNamed:@"picture.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIImageView *snapshotView = [[UIImageView alloc] initWithImage:[imageView snapshotWithTransparent:YES]];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    scrollView.contentSize = snapshotView.size;
    [scrollView addSubview:snapshotView];
    GHVerifyView(scrollView);
}

- (void)testView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 300, 400)];
    GHAssertTrue(100 == view.left, nil);
    GHAssertTrue(200 == view.top, nil);
    GHAssertTrue(400 == view.right, nil);
    GHAssertTrue(600 == view.bottom, nil);
    GHAssertTrue(300 == view.width, nil);
    GHAssertTrue(400 == view.height, nil);
    GHAssertTrue(250 == view.centerX, nil);
    GHAssertTrue(400 == view.centerY, nil);
    GHAssertEquals(view.origin, CGPointMake(100, 200), nil);
    GHAssertEquals(view.size, CGSizeMake(300, 400), nil);
    GHAssertTrue(([UIApplication sharedApplication].isPortrait ? 300 : 400) == view.orientationWidth, nil);
    GHAssertTrue(([UIApplication sharedApplication].isPortrait ? 400 : 300) == view.orientationHeight, nil);
    UIScrollView *superView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 60, 300, 400)];
    superView.hidden = YES;
    [superView addSubview:view];
    [(UIWindow *)[UIApplication sharedApplication].windows[0] addSubview:superView];
    GHAssertTrue(120 == view.screenX, nil);
    GHAssertTrue(260 == view.screenY, nil);
    GHAssertEquals(view.screenFrame, CGRectMake(120, 260, 300, 400), nil);
    GHAssertEqualObjects([superView descendantOrSelfWithClass:[UIView class]], superView, nil);
    GHAssertEqualObjects([view ancestorOrSelfWithClass:[UIScrollView class]], superView, nil);
    
    UIView *superView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
    [superView2 addSubview:superView];
    GHAssertEquals([view originInView:superView], CGPointMake(100, 200), nil);
    GHAssertEquals([view originInView:superView2], CGPointMake(120, 260), nil);
    
    [superView removeFromSuperview];
}

@end
