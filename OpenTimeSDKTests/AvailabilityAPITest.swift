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
/*
class AvailabilityAPITest: XCTestCase {

    override func setUp() {
        super.setUp()

        APIRequestOperationManager.disableCache();
        AvailabilityStorage.clearAllAvailabilityFromStorage();
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
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
            
            AvailabilityAPI.setOneTimeAvailability(availability, done: {(response: APIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            expectation = expectationWithDescription("Get my availability");
            
            AvailabilityAPI.getAllMyAvailability({(response: APIResponse) -> () in
                
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
            
            AvailabilityAPI.removeOneTimeAvailability(availability, done: {(response: APIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            expectation = expectationWithDescription("Get my updated availability");
            
            AvailabilityAPI.getAllMyAvailability({(response: APIResponse) -> () in
                
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
    
    func testGetConnectionsAvailability()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["setup_connection_availability"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate that a user is signed in.
            let person = Person(id: 1);
            CurrentUser.sharedInstance().setUser(person);
            CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
            
            let expectation = expectationWithDescription("Set one time availability");
            
            AvailabilityAPI.getConnectionsAvailability({(response: APIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    var connections = response.data as! Array<[String: AnyObject]>;
                    
                    XCTAssertEqual(1, connections.count);
                    if(connections.count > 0)
                    {
                        var oneTimeAvailabilityList = connections[0]["one_time"] as! Array<OneTimeAvailability>;
                        
                        let oneTimeAvailability:OneTimeAvailability = oneTimeAvailabilityList[0] as OneTimeAvailability;
                        
                        XCTAssertEqual(2058674400, oneTimeAvailability.start());
                        XCTAssertEqual(2058678000, oneTimeAvailability.end());
                        XCTAssertEqual(1427238491, oneTimeAvailability.created());
                        XCTAssertEqual(1427238491, oneTimeAvailability.lastUpdated());
                        XCTAssertEqual(SyncItem.Status.Active, oneTimeAvailability.status());
                    }
                }
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }

}
*/
