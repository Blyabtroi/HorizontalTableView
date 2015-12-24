//
//  Horizontal_TableViewUITests.m
//  Horizontal TableViewUITests
//
//  Created by Vasiliy Kozlov on 23.12.15.
//  Copyright © 2015 . All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Horizontal_TableViewUITests : XCTestCase

@property (strong, nonatomic) XCUIApplication *app;

- (void)testExample;

@end

@implementation Horizontal_TableViewUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    self.app = [[XCUIApplication alloc] init];
    [self.app launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssert([self.app.tables.cells count] > 0, @"passed");

}

@end
