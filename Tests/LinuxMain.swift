import XCTest

import MultipartFormTests

var tests = [XCTestCaseEntry]()
tests += MultipartFormTests.allTests()
XCTMain(tests)