//
//  EYFoundationTests.m
//  EYToolkit
//
//  Created by Edward Yang on 14-4-21.
//  Copyright (c) 2014年 EdwardYang. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "EYFoundationCore.h"

@interface EYFoundationTests : GHTestCase

@end

@implementation EYFoundationTests

- (void)testVersion {
    GHTestLog(@"current version:%@", [EYToolkitVersion version]);
    GHAssertEquals([EYToolkitVersion majorVersion], 1, @"latest major version");
    GHAssertEquals([EYToolkitVersion minorVersion], 0, @"latest minor version");
    GHAssertEquals([EYToolkitVersion bugfixVersion], 0, @"latest bugfix version");
}

- (void)testValidString {
    GHAssertFalse(IsString(@1), @"is not string");
    GHAssertTrue(IsString(@"1"), @"is string");
    GHAssertFalse(IsStringWithAnyText(@""), @"no text");
    GHAssertTrue(IsStringWithAnyText(@"123"), @"has text");
}

- (void)testValidArray {
    GHAssertFalse(IsArray(@1), @"is not array");
    GHAssertTrue(IsArray(@[]), @"is array");
    GHAssertFalse(IsArrayWithAnyItem(@[]), @"no item");
    GHAssertTrue(IsArrayWithAnyItem(@[@1]), @"has item");
}

- (void)testValidDictionary {
    GHAssertFalse(IsDictionary(@1), @"is not dictionary");
    GHAssertTrue(IsDictionary(@{}), @"is dictionary");
    GHAssertFalse(IsDictionaryWithAnyKeyValue(@{}), @"no key vaule");
    GHAssertTrue(IsDictionaryWithAnyKeyValue(@{@1 : @"1"}), @"has key value");
}

- (void)testValidSet {
    GHAssertFalse(IsSet(@1), @"is not set");
    NSMutableSet *set = [[NSMutableSet alloc] init];
    GHAssertTrue(IsSet(set), @"is set");
    GHAssertFalse(IsSetWithAnyItem(set), @"no item");
    [set addObject:@1];
    GHAssertTrue(IsSetWithAnyItem(set), @"has item");
}

- (void)testGeometry {
    GHAssertEquals(EYRectMakeWithOriginAndSize(CGPointMake(100, 200), CGSizeMake(300, 400)), CGRectMake(100, 200, 300, 400), @"");
    GHAssertEquals(EYRectMakeWithOrigin(CGPointMake(100, 200), 300, 400), CGRectMake(100, 200, 300, 400), @"");
    GHAssertEquals(EYRectMakeWithSize(100, 200, CGSizeMake(300, 400)), CGRectMake(100, 200, 300, 400), @"");
    GHAssertEquals(EYRectContract(CGRectMake(100, 200, 300, 400), 30, 50), CGRectMake(100, 200, 270, 350), @"");
    GHAssertEquals(EYRectExpand(CGRectMake(100, 200, 300, 400), 30, 50), CGRectMake(100, 200, 330, 450), @"");
    GHAssertEquals(EYRectShift(CGRectMake(100, 200, 300, 400), 30, 50), CGRectMake(130, 250, 270, 350), @"");
    GHAssertEquals(EYRectInset(CGRectMake(100, 200, 300, 400), UIEdgeInsetsMake(10, 20, 30, 40)), CGRectMake(120, 210, 240, 360), @"");
}

- (void)testPaths {
    GHAssertTrue([EYPathForApp() hasSuffix:@"/Applications"], @"%@", EYPathForApp());
    GHAssertTrue([EYPathForDocument() hasSuffix:@"/Documents"], @"%@", EYPathForDocument());
    GHAssertTrue([EYPathForLibCache() hasSuffix:@"/Library/Caches"], @"%@", EYPathForLibCache());
    GHAssertTrue([EYPathForLibPreferences() hasSuffix:@"/Library/Preferences"], @"%@", EYPathForLibPreferences());
    GHAssertTrue([EYPathForTmp() hasSuffix:@"/Library/tmp"], @"%@", EYPathForTmp());
}

#pragma mark - NSData
- (void)testDataMD5 {
    NSData *emptyData = [NSData data];
	GHAssertEqualObjects(emptyData.md5, @"d41d8cd98f00b204e9800998ecf8427e", nil);
    
    NSData *smallData = [@"Welcome to use EYFramewrok!" dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(smallData.md5, @"1c17a433fbe678ef4ed5665e6e89cde5", nil);
    
    NSData *bigData = [@"图灵奖是计算机界最负盛名、最崇高的奖项，有“计算机界的诺贝尔奖”之称，由于在密码学和复杂理论领域做出创举性工作，麻省理工学院Shafi Goldwasser和Silvio Micali教授因此获得了2012年的图灵奖。" dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(bigData.md5, @"84f9b107050972bb1a0918cea27b0ab3", nil);
}

- (void)testDataSHA1 {
    NSData *emptyData = [NSData data];
	GHAssertEqualObjects(emptyData.sha1, @"da39a3ee5e6b4b0d3255bfef95601890afd80709", nil);
    
    NSData *smallData = [@"Welcome to use EYFramewrok!" dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(smallData.sha1, @"8d70905ee224fc1cd6a845c7ad5306caa25368d4", nil);
    
    NSData *bigData = [@"图灵奖是计算机界最负盛名、最崇高的奖项，有“计算机界的诺贝尔奖”之称，由于在密码学和复杂理论领域做出创举性工作，麻省理工学院Shafi Goldwasser和Silvio Micali教授因此获得了2012年的图灵奖。" dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(bigData.sha1, @"fa12e9a281bd8a0048d916842eec0ade311756f7", nil);
}

- (void)testDataBase64 {
    NSData *emptyData = [NSData data];
	GHAssertEqualObjects(emptyData.base64, @"", nil);
    GHAssertEqualObjects([NSData dataWithBase64String:@""], emptyData, nil);
    
    NSData *smallData = [@"Welcome to use EYFramewrok!" dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(smallData.base64, @"V2VsY29tZSB0byB1c2UgRVlGcmFtZXdyb2sh", nil);
	GHAssertEqualObjects([NSData dataWithBase64String:@"V2VsY29tZSB0byB1c2UgRVlGcmFtZXdyb2sh"], smallData, nil);
    
    NSData *bigData = [@"图灵奖是计算机界最负盛名、最崇高的奖项，有“计算机界的诺贝尔奖”之称，由于在密码学和复杂理论领域做出创举性工作，麻省理工学院Shafi Goldwasser和Silvio Micali教授因此获得了2012年的图灵奖。" dataUsingEncoding:NSUTF8StringEncoding];
	GHAssertEqualObjects(bigData.base64, @"5Zu+54G15aWW5piv6K6h566X5py655WM5pyA6LSf55ub5ZCN44CB5pyA5bSH6auY55qE5aWW6aG577yM5pyJ4oCc6K6h566X5py655WM55qE6K+66LSd5bCU5aWW4oCd5LmL56ew77yM55Sx5LqO5Zyo5a+G56CB5a2m5ZKM5aSN5p2C55CG6K666aKG5Z+f5YGa5Ye65Yib5Li+5oCn5bel5L2c77yM6bq755yB55CG5bel5a2m6ZmiU2hhZmkgR29sZHdhc3NlcuWSjFNpbHZpbyBNaWNhbGnmlZnmjojlm6DmraTojrflvpfkuoYyMDEy5bm055qE5Zu+54G15aWW44CC", nil);
    GHAssertEqualObjects([NSData dataWithBase64String:@"5Zu+54G15aWW5piv6K6h566X5py655WM5pyA6LSf55ub5ZCN44CB5pyA5bSH6auY55qE5aWW6aG577yM5pyJ4oCc6K6h566X5py655WM55qE6K+66LSd5bCU5aWW4oCd5LmL56ew77yM55Sx5LqO5Zyo5a+G56CB5a2m5ZKM5aSN5p2C55CG6K666aKG5Z+f5YGa5Ye65Yib5Li+5oCn5bel5L2c77yM6bq755yB55CG5bel5a2m6ZmiU2hhZmkgR29sZHdhc3NlcuWSjFNpbHZpbyBNaWNhbGnmlZnmjojlm6DmraTojrflvpfkuoYyMDEy5bm055qE5Zu+54G15aWW44CC"], bigData, nil);
}

#pragma mark - NSString
- (void)testStringMD5 {
    GHAssertEqualObjects(@"".md5, @"d41d8cd98f00b204e9800998ecf8427e", nil);
    GHAssertEqualObjects(@"Welcome to use EYFramewrok!".md5, @"1c17a433fbe678ef4ed5665e6e89cde5", nil);
    GHAssertEqualObjects(@"图灵奖是计算机界最负盛名、最崇高的奖项，有“计算机界的诺贝尔奖”之称，由于在密码学和复杂理论领域做出创举性工作，麻省理工学院Shafi Goldwasser和Silvio Micali教授因此获得了2012年的图灵奖。".md5, @"84f9b107050972bb1a0918cea27b0ab3", nil);
}

- (void)testStringSHA1 {
    GHAssertEqualObjects(@"".sha1, @"da39a3ee5e6b4b0d3255bfef95601890afd80709", nil);
    GHAssertEqualObjects(@"Welcome to use EYFramewrok!".sha1, @"8d70905ee224fc1cd6a845c7ad5306caa25368d4", nil);
    GHAssertEqualObjects(@"图灵奖是计算机界最负盛名、最崇高的奖项，有“计算机界的诺贝尔奖”之称，由于在密码学和复杂理论领域做出创举性工作，麻省理工学院Shafi Goldwasser和Silvio Micali教授因此获得了2012年的图灵奖。".sha1, @"fa12e9a281bd8a0048d916842eec0ade311756f7", nil);
}

- (void)testStringBASE64 {
    GHAssertEqualObjects(@"".base64, @"", nil);
    GHAssertEqualObjects([NSString stringWithBase64String:@""], @"", nil);
    GHAssertEqualObjects(@"Welcome to use EYFramewrok!".base64, @"V2VsY29tZSB0byB1c2UgRVlGcmFtZXdyb2sh", nil);
    GHAssertEqualObjects([NSString stringWithBase64String:@"V2VsY29tZSB0byB1c2UgRVlGcmFtZXdyb2sh"], @"Welcome to use EYFramewrok!", nil);
    GHAssertEqualObjects(@"图灵奖是计算机界最负盛名、最崇高的奖项，有“计算机界的诺贝尔奖”之称，由于在密码学和复杂理论领域做出创举性工作，麻省理工学院Shafi Goldwasser和Silvio Micali教授因此获得了2012年的图灵奖。".base64, @"5Zu+54G15aWW5piv6K6h566X5py655WM5pyA6LSf55ub5ZCN44CB5pyA5bSH6auY55qE5aWW6aG577yM5pyJ4oCc6K6h566X5py655WM55qE6K+66LSd5bCU5aWW4oCd5LmL56ew77yM55Sx5LqO5Zyo5a+G56CB5a2m5ZKM5aSN5p2C55CG6K666aKG5Z+f5YGa5Ye65Yib5Li+5oCn5bel5L2c77yM6bq755yB55CG5bel5a2m6ZmiU2hhZmkgR29sZHdhc3NlcuWSjFNpbHZpbyBNaWNhbGnmlZnmjojlm6DmraTojrflvpfkuoYyMDEy5bm055qE5Zu+54G15aWW44CC", nil);
    GHAssertEqualObjects([NSString stringWithBase64String:@"5Zu+54G15aWW5piv6K6h566X5py655WM5pyA6LSf55ub5ZCN44CB5pyA5bSH6auY55qE5aWW6aG577yM5pyJ4oCc6K6h566X5py655WM55qE6K+66LSd5bCU5aWW4oCd5LmL56ew77yM55Sx5LqO5Zyo5a+G56CB5a2m5ZKM5aSN5p2C55CG6K666aKG5Z+f5YGa5Ye65Yib5Li+5oCn5bel5L2c77yM6bq755yB55CG5bel5a2m6ZmiU2hhZmkgR29sZHdhc3NlcuWSjFNpbHZpbyBNaWNhbGnmlZnmjojlm6DmraTojrflvpfkuoYyMDEy5bm055qE5Zu+54G15aWW44CC"], @"图灵奖是计算机界最负盛名、最崇高的奖项，有“计算机界的诺贝尔奖”之称，由于在密码学和复杂理论领域做出创举性工作，麻省理工学院Shafi Goldwasser和Silvio Micali教授因此获得了2012年的图灵奖。", nil);
}

- (void)testStringUUID {
	GHAssertNotEqualObjects([NSString stringWithUUID], [NSString stringWithUUID], nil);
}

- (void)testStringCompareToVersionString {
    GHAssertEquals([@"10.4" compareToVersionString:@"10.3"], NSOrderedDescending, nil);
    GHAssertEquals([@"10.5" compareToVersionString:@"10.5.0"], NSOrderedSame, nil);
    GHAssertEquals([@"10.4 Build 8L127" compareToVersionString:@"10.4 Build 8P135"], NSOrderedAscending, nil);
}

- (void)testStringURLEncodingAndDeconding {
    GHAssertEqualObjects([@"!#$%&'()*+,/:;=?@[] " stringByURLEncoding],
                         @"%21%23%24%25%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D%20", nil);
    GHAssertEqualObjects([@"%21%23%24%25%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D%20" stringByURLDecoding],
                         @"!#$%&'()*+,/:;=?@[] ", nil);
    
    GHAssertEqualObjects([@"äÄöÖüÜñàÀáÀîÎ\r\n\tabcdefghigklmn" stringByURLEncoding],
                         @"%C3%A4%C3%84%C3%B6%C3%96%C3%BC%C3%9C%C3%B1%C3%A0%C3%80%C3%A1%C3%80%C3%AE%C3%8E%0D%0A%09abcdefghigklmn", nil);
    GHAssertEqualObjects([@"%C3%A4%C3%84%C3%B6%C3%96%C3%BC%C3%9C%C3%B1%C3%A0%C3%80%C3%A1%C3%80%C3%AE%C3%8E%0D%0A%09abcdefghigklmn" stringByURLDecoding],
                         @"äÄöÖüÜñàÀáÀîÎ\r\n\tabcdefghigklmn", nil);
}

- (void)testStringTrim {
    GHAssertEqualObjects([@"\n\t\t  \nasfaa agasg \n \t asfgasga \n\n\t  " stringByTrim], @"asfaa agasg \n \t asfgasga", nil);
}

- (void)testStringEmpty {
    GHAssertEquals([@"" isEmpty], YES, nil);
    GHAssertEquals([@"" isNotEmpty], NO, nil);
    GHAssertEquals([@"agasg" isEmpty], NO, nil);
    GHAssertEquals([@"agasg" isNotEmpty], YES, nil);
}

- (void)testStringContain {
    GHAssertEquals([@"aasjpjewipgjsdngoishgioheqrwop" isContainsString:@"sdfhdsf"], NO, nil);
    GHAssertEquals([@"aasjpjewipgjsdngoishgioheqrwop" isContainsString:@"ngois"], YES, nil);
}

- (void)testStringWhitespaceAndNewline {
    GHAssertEquals([@"\n   \n\t\t\n" isWhitespaceAndNewline], YES, nil);
    GHAssertEquals([@"\n asgasgas  \nagag\t\t\n" isWhitespaceAndNewline], NO, nil);
}

- (void)testStringQueryContentsUsingEncoding {
	NSDictionary* query;
    
	query = [@"" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([query count] == 0, @"Query: %@", query);
    
	query = [@"q" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:[NSArray arrayWithObject:[NSNull null]]],
                 @"Query: %@", query);
    
	query = [@"q=" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:[NSArray arrayWithObject:@""]],
                 @"Query: %@", query);
    
	query = [@"q=three20" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:[NSArray arrayWithObject:@"three20"]],
                 @"Query: %@", query);
    
	query = [@"q=three20%20github" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:[NSArray arrayWithObject:@"three20 github"]],
                 @"Query: %@", query);
    
	query = [@"q=three20&hl=en" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:[NSArray arrayWithObject:@"three20"]],
                 @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"hl"] isEqual:[NSArray arrayWithObject:@"en"]],
                 @"Query: %@", query);
    
	query = [@"q=three20&hl=" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:[NSArray arrayWithObject:@"three20"]],
                 @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"hl"] isEqual:[NSArray arrayWithObject:@""]],
                 @"Query: %@", query);
    
	query = [@"q=&&hl=" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:[NSArray arrayWithObject:@""]],
                 @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"hl"] isEqual:[NSArray arrayWithObject:@""]],
                 @"Query: %@", query);
    
	query = [@"q=three20=repo&hl=en" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertNil([query objectForKey:@"q"], @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"hl"] isEqual:[NSArray arrayWithObject:@"en"]],
                 @"Query: %@", query);
    
	query = [@"&&" queryContentsUsingEncoding:NSUTF8StringEncoding];
	GHAssertTrue([query count] == 0, @"Query: %@", query);
    
	query = [@"q=foo&q=three20" queryContentsUsingEncoding:NSUTF8StringEncoding];
	NSArray* qArr = [NSArray arrayWithObjects:@"foo", @"three20", nil];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:qArr], @"Query: %@", query);
    
	query = [@"q=foo&q=three20&hl=en" queryContentsUsingEncoding:NSUTF8StringEncoding];
	qArr = [NSArray arrayWithObjects:@"foo", @"three20", nil];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:qArr], @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"hl"] isEqual:[NSArray arrayWithObject:@"en"]],
                 @"Query: %@", query);
    
	query = [@"q=foo&q=three20&hl=en&g" queryContentsUsingEncoding:NSUTF8StringEncoding];
	qArr = [NSArray arrayWithObjects:@"foo", @"three20", nil];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:qArr], @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"hl"] isEqual:[NSArray arrayWithObject:@"en"]],
                 @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"g"] isEqual:[NSArray arrayWithObject:[NSNull null]]],
                 @"Query: %@", query);
    
	query = [@"q&q=three20&hl=en&g" queryContentsUsingEncoding:NSUTF8StringEncoding];
	qArr = [NSArray arrayWithObjects:[NSNull null], @"three20", nil];
	GHAssertTrue([[query objectForKey:@"q"] isEqual:qArr], @"Query: %@", query);
	GHAssertTrue([[query objectForKey:@"hl"] isEqual:[NSArray arrayWithObject:@"en"]],
                 @"Query: %@", query);
}

- (void)testStringByAddingQueryDictionary {
    NSString* baseUrl = @"http://google.com/search";
    GHAssertTrue([[baseUrl stringByAddingQueryDictionary:nil] isEqualToString:
                  [baseUrl stringByAppendingString:@"?"]], @"Empty dictionary fail.");
    
    GHAssertTrue([[baseUrl stringByAddingQueryDictionary:[NSDictionary dictionary]] isEqualToString:
                  [baseUrl stringByAppendingString:@"?"]], @"Empty dictionary fail.");
    
    GHAssertTrue([[baseUrl stringByAddingQueryDictionary:[NSDictionary
                                                          dictionaryWithObject:@"three20" forKey:@"q"]] isEqualToString:
                  [baseUrl stringByAppendingString:@"?q=three20"]], @"Single parameter fail.");
    
    NSDictionary* query = [NSDictionary
                           dictionaryWithObjectsAndKeys:
                           @"three20", @"q",
                           @"en",      @"hl",
                           nil];
    NSString* baseUrlWithQuery = [baseUrl stringByAddingQueryDictionary:query];
    GHAssertTrue([baseUrlWithQuery isEqualToString:[baseUrl
                                                    stringByAppendingString:@"?hl=en&q=three20"]]
                 || [baseUrlWithQuery isEqualToString:[baseUrl
                                                       stringByAppendingString:@"?q=three20&hl=en"]],
                 @"Additional query parameters not correct. %@", [baseUrl stringByAddingQueryDictionary:query]);
}

- (void)testStringByAddingURLEncodedQueryDictionary {
    NSString* baseUrl = @"http://google.com/search";
    GHAssertEqualObjects([baseUrl stringByAddingURLEncodedQueryDictionary:nil],
                         [baseUrl stringByAppendingString:@"?"],
                         @"Empty dictionary fail.");
    
    GHAssertEqualObjects([baseUrl stringByAddingURLEncodedQueryDictionary:[NSDictionary dictionary]],
                         [baseUrl stringByAppendingString:@"?"],
                         @"Empty dictionary fail.");
    
    baseUrl = @"http://google.com/search?hl=foo";
    GHAssertEqualObjects([baseUrl stringByAddingURLEncodedQueryDictionary:[NSDictionary
                                                                           dictionaryWithObject:@"Ö " forKey:@"Ü"]],
                         [baseUrl stringByAppendingString:@"&%C3%9C=%C3%96%20"],
                         @"Single parameter fail.");
    
    
    NSDictionary* query = [NSDictionary
                           dictionaryWithObjectsAndKeys:
                           @"%(", @"\u1234",
                           @"§/",      @"hl",
                           nil];
    NSString* baseUrlWithQuery = [baseUrl stringByAddingURLEncodedQueryDictionary:query];
    GHAssertTrue([baseUrlWithQuery isEqualToString:[baseUrl
                                                    stringByAppendingString:@"&%E1%88%B4=%25%28&hl=%C2%A7%2F"]]
                 || [baseUrlWithQuery isEqualToString:[baseUrl
                                                       stringByAppendingString:@"&hl=%C2%A7%2F&%E1%88%B4=%25%28"]],
                 @"Additional query parameters not correct. %@",
                 [baseUrl stringByAddingQueryDictionary:query]);
    
    NSDictionary* malformedQueryDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1]
                                                                   forKey:@""];
    GHAssertNoThrowSpecificNamed([@"" stringByAddingURLEncodedQueryDictionary:malformedQueryDict],
                                 NSException, NSInvalidArgumentException,
                                 @"Doesn't thow expected exception");
}

- (void)testDate {
    NSString *formatString = @"yyyyMMdd HH:mm:ss";
    NSString *dateString = @"20130101 00:00:00";
    GHAssertEqualStrings([[NSDate dateByDateString:dateString withFormatString:formatString] stringByFormatString:formatString],
                         dateString, @"");
}

- (void)testArray {
    NSArray *array = @[@1, @2];
    GHAssertEquals([array firstObject], @1, nil);
    NSMutableArray *noRetainingArray = [NSMutableArray arrayWithNonRetaining];
    NSString *string = [[NSString alloc] initWithFormat:@"%@%@", array[0], array[1]];
    GHAssertTrue(1 == CFGetRetainCount((__bridge CFTypeRef) string), nil);
    [noRetainingArray addObject:string];
    GHAssertTrue(1 == CFGetRetainCount((__bridge CFTypeRef) string), nil);
}

- (void)testDictionary {
    NSMutableDictionary *noRetainingDict = [NSMutableDictionary dictionaryWithNonRetaining];
    NSString *string = [[NSString alloc] initWithFormat:@"test"];
    GHAssertTrue(1 == CFGetRetainCount((__bridge CFTypeRef) string), nil);
    [noRetainingDict setObject:string forKey:@"key"];
    GHAssertTrue(1 == CFGetRetainCount((__bridge CFTypeRef) string), nil);
}

@end
