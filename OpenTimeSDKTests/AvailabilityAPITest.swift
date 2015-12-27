//
//  AvailabilityAPITest.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/23/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK

class AvailabilityAPITest: XCTestCase {

    override func setUp() {
        super.setUp()
        OTAPIRequestOperationManager.disableCache();
        OpenTimeSDK.initSession(OpenTimeSDKTestConstants.API_KEY, inTestMode: true);
        OpenTimeSDK.session.setPlainTextCredentials(1, password: "I love testing");
    }
    
    func testSetOneTimeAvailability()
    {
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(self, scriptNames: ["make_users","clear_availability"], resetCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success) {
            
            var expectation = expectationWithDescription("Set one time availability");
            
            let start = Int(2058314400);
            let end   = Int(2058314400 + (3600 * 2));
            let created = 1427162923;
            let lastUpdated = 1427162939;
            
            let setOneTimeAvailabilityData = OTSetOneTimeAvailabilityData(
                lastUpdated: lastUpdated,
                createdTimestamp: created,
                start: start,
                end: end);
            
            OTAvailabilityAPI.setOneTimeAvailability(setOneTimeAvailabilityData, done: { (response) -> Void in
                XCTAssertTrue(response.success == true);
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            expectation = expectationWithDescription("Get my availability");
            
            OTAvailabilityAPI.getAllMyAvailability({ (response: OTGetAllMyAvailabilityResponse) -> Void in
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    var availability = response.getList();
                    
                    XCTAssertEqual(1, availability.count);
                    
                    if(availability.count > 0) {
                        
                        let availability:OTDeserializedOneTimeAvailability = availability[0];
                        
                        XCTAssertEqual(start, availability.getStart());
                        XCTAssertEqual(end, availability.getEnd());
                        XCTAssertEqual(created, availability.getCreatedTimestamp());
                        XCTAssertEqual(lastUpdated, availability.getLastUpdated());
                        XCTAssertEqual(AvailabilityStatusOption.Active, availability.getStatus());
                    }
                }
                
                expectation.fulfill();
                
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
        }
    }
    
    func testRemoveAvailability() {
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(self, scriptNames: ["make_users","clear_availability"], resetCache: true);
        
        XCTAssertTrue(response.success);
        
        let expectation = expectationWithDescription("Remove availability");
        
        let created = 1427162923;
        let lastUpdated = 1427162939;
        
        let removedTimestamp = lastUpdated + 2;
        let removeAvailabilityData = OTRemoveOneTimeAvailabilityData(
            lastUpdated: removedTimestamp, createdTimestamp: created
        );
        
        OTAvailabilityAPI.removeOneTimeAvailability(removeAvailabilityData, done: { (response) -> Void in
            XCTAssertTrue(response.success == true);
            
            expectation.fulfill();
        });
        
        waitForExpectationsWithTimeout(5.0, handler:nil);
    }
    
    func testGetConnectionsAvailability() {
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(self, scriptNames: ["setup_connection_availability"], resetCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success) {
            
            let expectation = expectationWithDescription("Set one time availability");
            
            OTAvailabilityAPI.getConnectionsAvailability({ (response: OTGetConnectionsAvailabilityResponse) -> Void in
                XCTAssertTrue(response.success);
                
                if(response.success) {
                    let connections: Array<OTDeserializedConnectionAvailability> = response.getList();
                    
                    XCTAssertEqual(1, connections.count);
                    
                    if(connections.count > 0) {
                        let connection: OTDeserializedConnectionAvailability = connections[0];
                        var oneTimeAvailabilityList = connection.getOneTimeAvailabilityList();
                        
                        let oneTimeAvailability:OTDeserializedOneTimeAvailability = oneTimeAvailabilityList[0] as OTDeserializedOneTimeAvailability;
                        
                        XCTAssertEqual(2058674400, oneTimeAvailability.getStart());
                        XCTAssertEqual(2058678000, oneTimeAvailability.getEnd());
                        XCTAssertEqual(1427238491, oneTimeAvailability.getCreatedTimestamp());
                        XCTAssertEqual(1427238491, oneTimeAvailability.getLastUpdated());
                        XCTAssertEqual(AvailabilityStatusOption.Active, oneTimeAvailability.getStatus());
                    }
                }
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }

}
