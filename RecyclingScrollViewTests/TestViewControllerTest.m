//
//  RecyclingScrollView - Test.m
//  Copyright 2014 none. All rights reserved.
//
//  Created by: seven
//

    // Class under test
#import "RecyclingScrollView.h"
#import "TestViewController.h"
#import <XCTest/XCTest.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

// Uncomment the next two lines to use OCMockito for mock objects:
#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>


@interface TestViewControllerTest : XCTest
@end

@implementation TestViewControllerTest
{
    // test fixture ivars go here
}

- (void)testAfs
{
  
}
- (void)testFoo_ShouldBar
{
  assertThatBool(YES, equalToBool(NO));
}

@end
