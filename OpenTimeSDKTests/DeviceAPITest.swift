//
//  DeviceAPITest.swift
//  OpenTime
//
//  Created by Josh Woodcock on 4/21/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK

class DeviceAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp();
        OpenTimeSDK.initSession(OpenTimeSDKTestConstants.API_KEY, inTestMode: true);
    }
    
    func testSetDeviceKey() {
        let resetExpectation = expectationWithDescription("Setup test");
        
        var keptResponse: OTAPIResponse! = nil;
        OTTestHelper.resetAPIData(["make_users"], done: {(response: OTAPIResponse)->Void in
            
            // Verify test data was setup correctly.
            XCTAssertTrue(response.success, response.message);
            keptResponse = response;
            resetExpectation.fulfill();
        }, clearCache: false);
        
        waitForExpectationsWithTimeout(5.0, handler:nil);
        
        if(keptResponse != nil && keptResponse.success)
        {
            // Emulate that a user is signed in.
            OpenTimeSDK.session.setPlainTextCredentials(1, password: "I love testing");
            
            let expectation = expectationWithDescription("Set one time availability");
            
            let key: String = "9e548e83f56bd858cf5f3c7472cb98a1b553c7ebf8c3a747c68b817c2c201e17";
            
            OTDeviceAPI.set(key, done: {(response: OTAPIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }

}
