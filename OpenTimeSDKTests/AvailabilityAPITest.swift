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
    
    /*
    
    func testSetOneTimeAvailability()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users","clear_availability"]);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate that a user is signed in.
            let person = Person(id: 1);
            CurrentUser.sharedInstance().setUser(person);
            CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
            
            var expectation = expectationWithDescription("Set one time availability");
            
            let start = Int(2058314400);
            let end   = Int(2058314400 + (3600 * 2));
            let created = 1427162923;
            let lastUpdated = 1427162939;
            
            let availability = OneTimeAvailability(
                userID: person.getID(),
                start: start,
                end: end,
                created: created,
                lastUpdated: lastUpdated
            );
            
            AvailabilityAPI.setOneTimeAvailability(availability, done: {(response: OTAPIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            expectation = expectationWithDescription("Get my availability");
            
            AvailabilityAPI.getAllMyAvailability({(response: OTAPIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    var availability = response.data as! Array<IAvailabilityItem>;
                    
                    XCTAssertEqual(1, availability.count);
                    if(availability.count > 0)
                    {
                        let availability:OneTimeAvailability = availability[0] as! OneTimeAvailability;
                        
                        XCTAssertEqual(start, availability.start());
                        XCTAssertEqual(end, availability.end());
                        XCTAssertEqual(created, availability.created());
                        XCTAssertEqual(lastUpdated, availability.lastUpdated());
                        XCTAssertEqual(SyncItem.Status.Active, availability.status());
                    }
                }
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            expectation = expectationWithDescription("Remove an availability");
            
            availability.lastUpdated(availability.lastUpdated() + 1);
            
            AvailabilityAPI.removeOneTimeAvailability(availability, done: {(response: OTAPIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            expectation = expectationWithDescription("Get my updated availability");
            
            AvailabilityAPI.getAllMyAvailability({(response: OTAPIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    var availability = response.data as! Array<IAvailabilityItem>;
                    
                    XCTAssertEqual(1, availability.count);
                    
                    if(availability.count > 0)
                    {
                        let availability:OneTimeAvailability = availability[0] as! OneTimeAvailability;
                        
                        XCTAssertEqual(start, availability.start());
                        XCTAssertEqual(end, availability.end());
                        XCTAssertEqual(created, availability.created());
                        XCTAssertEqual(lastUpdated + 1, availability.lastUpdated());
                        XCTAssertEqual(SyncItem.Status.Removed, availability.status());
                    }
                }
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }
    */
    
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
