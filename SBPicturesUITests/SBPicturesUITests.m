//
//  SBPicturesUITests.m
//  SBPicturesUITests
//
//  Created by 17495310 on 01/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SBPicturesUITests : XCTestCase

@end

@implementation SBPicturesUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
