//
//  TestHelper.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 11/16/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import Foundation
import XCTest
import OpenTimeSDK

class TestHelper {
    
    static func getDataResetResponse(testCase: XCTestCase, scriptNames: Array<String>, resetCache: Bool) -> OTAPIResponse {
        
        let resetExpectation = testCase.expectationWithDescription("Setup test");
        
        var keptResponse: OTAPIResponse = OTAPIResponse(success: false, message: "No response");
        
        OTTestHelper.resetAPIData(scriptNames, done: {(response: OTAPIResponse)->Void in
            
            // Verify test data was setup correctly.
            XCTAssertTrue(response.success, response.message);
            keptResponse = response;
            resetExpectation.fulfill();
        }, clearCache: true);
        
        testCase.waitForExpectationsWithTimeout(5.0, handler:nil);
        
        return keptResponse;
    }
    
}