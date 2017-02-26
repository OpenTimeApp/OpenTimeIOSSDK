//
//  AvailabilityAPITest.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/23/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import XCTest
import OpenTimeSDK

class OTAvailabilityAPITest: OTAPITest {
    
    func testSetOneTimeAvailability(){
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users","clear_availability","make_meetings"], resetCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success) {
            
            var theExpectation = expectation(description: "Set one time availability");
            
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
                
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler:nil);
            
            theExpectation = expectation(description: "Get my availability");
            
            OTAvailabilityAPI.getAllMyAvailability({ (response: OTGetAllMyAvailabilityResponse) -> Void in
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    let availability = response.getAvailability()!.getOneTimeAvailability();
                    let exceptions   = response.getAvailability()!.getExceptions();
                    
                    XCTAssertEqual(1, availability.count);
                    
                    if(availability.count > 0) {
                        
                        let availability:OTDeserializedOneTimeAvailability = availability[0];
                        
                        XCTAssertEqual(start, availability.getStart());
                        XCTAssertEqual(end, availability.getEnd());
                        XCTAssertEqual(created, availability.getCreatedTimestamp());
                        XCTAssertEqual(lastUpdated, availability.getLastUpdated());
                        XCTAssertEqual(AvailabilityStatusOption.Active, availability.getStatus());
                    
                    }
                    
                    XCTAssertEqual(2, exceptions.count);
                
                }
                
                theExpectation.fulfill();
                
            });
            
            waitForExpectations(timeout: 5.0, handler:nil);
            
        }
    }
    
    func testRemoveAvailability() {
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users","clear_availability"], resetCache: true);
        
        XCTAssertTrue(response.success);
        
        let theExpectation = expectation(description: "Remove availability");
        
        let created = 1427162923;
        let lastUpdated = 1427162939;
        
        let removedTimestamp = lastUpdated + 2;
        let removeAvailabilityData = OTRemoveOneTimeAvailabilityData(
            lastUpdated: removedTimestamp, createdTimestamp: created
        );
        
        OTAvailabilityAPI.removeOneTimeAvailability(removeAvailabilityData, done: { (response) -> Void in
            XCTAssertTrue(response.success == true);
            
            theExpectation.fulfill();
        });
        
        waitForExpectations(timeout: 5.0, handler:nil);
    }
    
    func testGetConnectionsAvailability() {
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["setup_connection_availability"], resetCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success) {
            
            let theExpectation = expectation(description: "Set one time availability");
            
            OTAvailabilityAPI.getConnectionsAvailability({ (response: OTGetConnectionsAvailabilityResponse) -> Void in
                XCTAssertTrue(response.success, response.message);
                
                if(response.success) {
                    let connections: Array<OTDeserializedConnectionAvailability> = response.getList();
                    
                    XCTAssertEqual(1, connections.count);
                    
                    if(connections.count > 0) {
                        let connection: OTDeserializedConnectionAvailability = connections[0];
                        var oneTimeAvailabilityList = connection.getAvailability().getOneTimeAvailability();
                        let exceptions              = connection.getAvailability().getExceptions();
                        
                        if(oneTimeAvailabilityList.count > 0){
                            let oneTimeAvailability:OTDeserializedOneTimeAvailability = oneTimeAvailabilityList[0] as OTDeserializedOneTimeAvailability;
                            
                            XCTAssertEqual(2058674400, oneTimeAvailability.getStart());
                            XCTAssertEqual(2058678000, oneTimeAvailability.getEnd());
                            XCTAssertEqual(1427238491, oneTimeAvailability.getCreatedTimestamp());
                            XCTAssertEqual(1427238491, oneTimeAvailability.getLastUpdated());
                            XCTAssertEqual(AvailabilityStatusOption.Active, oneTimeAvailability.getStatus());
                            
                            XCTAssertEqual(0, exceptions.count);

                        }
                    }
                }
                
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }

}
