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

class OTDeviceAPITest: OTAPITest {
    
    func testSetDeviceKey() {
        let resetExpectation = expectation(description: "Setup test");
        
        var keptResponse: OTAPIResponse! = nil;
        OTTestHelper.resetAPIData(["make_users"], done: {(response: OTAPIResponse)->Void in
            
            // Verify test data was setup correctly.
            XCTAssertTrue(response.success, response.message);
            keptResponse = response;
            resetExpectation.fulfill();
        }, clearCache: false);
        
        waitForExpectations(timeout: 5.0, handler:nil);
        
        if(keptResponse != nil && keptResponse.success) {
            
            let theExpectation = expectation(description: "Set one time availability");
            
            let key: String = "9e548e83f56bd858cf5f3c7472cb98a1b553c7ebf8c3a747c68b817c2c201e17";
            
            OTDeviceAPI.set(key, done: {(response: OTAPIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }

}
