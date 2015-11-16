//
//  ConnectionAPITest.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/10/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK


class ConnectionAPITest: XCTestCase {

    override func setUp() {
        super.setUp()
        OpenTimeSDK.initSession(OpenTimeSDKTestConstants.API_KEY, inTestMode: true);
        OpenTimeSDK.session.setPlainTextCredentials(1, password: "I love testing");
    }
    
    /*

    func testAddActiveConnection()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"]);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate that a user is signed in.
            let person = Person(id: 1);
            CurrentUser.sharedInstance().setUser(person);
            CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
            
            // Start test.
            let expectation = expectationWithDescription("Set Active Connection");

            let person2 = Person(id: 2);
            let connection = Connection(forUser: TestUser.userID, connection: person2, lastUpdated: Int(NSDate().timeIntervalSince1970), status: Connection.Status.Active);
            ConnectionAPI.set(connection, done: {(response: OTAPIResponse)-> () in
               
                XCTAssertEqual(response.success, true);
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil)
            
        }
    }
    
    func testSetActiveConnectionAsInactive()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"]);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate that a user is signed in.
            let person = Person(id: 1);
            CurrentUser.sharedInstance().setUser(person);
            CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
            
            // Emulate user to be added as connection.
            let person2 = Person(id: 2);
            let connection = Connection(forUser: TestUser.userID, connection:  person2, lastUpdated: Int(NSDate().timeIntervalSince1970), status: Connection.Status.Active);
            
            // Create active connection.
            var expectation = expectationWithDescription("Set Active Connection");
            ConnectionAPI.set(connection, done: {(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                expectation.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            // Set active connection as inactive.
            expectation = expectationWithDescription("Set Active Connection as Inactive");
            connection.status(Connection.Status.Inactive);
            ConnectionAPI.set(connection, done: {(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                expectation.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil)
            
        }
    }
    
    func testRemoveConnection()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate that a user is signed in.
            let person = Person(id: 1);
            CurrentUser.sharedInstance().setUser(person);
            CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
            
            // Emulate user to be added as connection.
            let person2 = Person(id: 2);
            let connection = Connection(forUser: TestUser.userID, connection:  person2, lastUpdated: Int(NSDate().timeIntervalSince1970), status: Connection.Status.Active);
            
            // Create active connection.
            var expectation = expectationWithDescription("Set Active Connection");
            ConnectionAPI.set(connection, done: {(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                expectation.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            // Set active connection as inactive.
            expectation = expectationWithDescription("Remove Active Connection");
            ConnectionAPI.remove(Connection.Status.Removed, lastUpdated: Int(NSDate().timeIntervalSince1970), done: {(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                expectation.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil)
            
        }
    }
    
    func testGetAll()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"]);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate user to be added as connection.
            let person2 = Person(id: 2);
            CurrentUser.sharedInstance().getUser().getConnections().setPersonInRamAndStorage(person2, withStatus: Connection.Status.Active);
            let connection = Connection(forUser: TestUser.userID, connection:  person2, lastUpdated: Int(NSDate().timeIntervalSince1970), status: Connection.Status.Active);
            
            // Create active connection.
            var expectation = expectationWithDescription("Set Active Connection");
            ConnectionAPI.set(connection, done: {(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                expectation.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            // Create active connection.
            expectation = expectationWithDescription("Set Active Connection");
            ConnectionAPI.getAll({(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                if(response.success == true)
                {
                    let connections = response.data as! Array<Connection>;
                    
                    XCTAssert((connections.count > 0) == true);
                }

                expectation.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
        }
    }*/
    
    func testGetWithList()
    {
        let resetExpectation = expectationWithDescription("Setup test");
        
        var keptResponse: OTAPIResponse! = nil;
        OTTestHelper.resetAPIData(["make_users"], done: {(response: OTAPIResponse)->Void in
            
            // Verify test data was setup correctly.
            XCTAssertTrue(response.success, response.message);
            keptResponse = response;
            resetExpectation.fulfill();
        }, clearCache: false);
        
        waitForExpectationsWithTimeout(5.0, handler:nil);
        
        if(keptResponse.success) {
            
            // Set a connection
            let expectToSetConnection = expectationWithDescription("Will set connection")
            let setConnectionData = OTSetConnectionData(userID: 2, status: OTConnectionStatusOption.Active, lastUpdated: Int(NSDate().timeIntervalSince1970) + 1);
            OTConnectionAPI.set(setConnectionData, done: { (response) -> Void in
                XCTAssertTrue(response.success);
                expectToSetConnection.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            // Get the connections to see if is there.
            let expectToGetConnections = expectationWithDescription("Will get list of connections");
            OTConnectionAPI.getList([2], done: { (response: OTConnectionsResponse) -> Void in
                XCTAssertTrue(response.success);
                if(response.success){
                    XCTAssert(response.getConnections().count > 0);
                }
                expectToGetConnections.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }
    

    func testGetWithContactInfoList()
    {
        let resetExpectation = expectationWithDescription("Setup test");
        
        var keptResponse: OTAPIResponse! = nil;
        OTTestHelper.resetAPIData(["make_users"], done: {(response: OTAPIResponse)->Void in
            
            // Verify test data was setup correctly.
            XCTAssertTrue(response.success, response.message);
            keptResponse = response;
            resetExpectation.fulfill();
            }, clearCache: true);
        
        waitForExpectationsWithTimeout(5.0, handler:nil);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(keptResponse.success, keptResponse.message);
        
        if(keptResponse != nil && keptResponse.success) {
            
            let contactinfodata1 = OTContactInfoData(emails: ["tester1@app.opentimeapp.com"], cellPhones: []);
            let contactinfodata2 = OTContactInfoData(emails: ["tester2@app.opentimeapp.com"], cellPhones: []);
            
            let data = OTGetConnectionsWithContactInfoData(
                connections: [contactinfodata1],
                contactsAlreadyInOpenTime: [contactinfodata2]
            );
            
            let expectation = expectationWithDescription("Get connection list");
            OTConnectionAPI.getWithContactInfo(data, done: { (response: OTConnectionsResponse) -> Void in
                XCTAssertEqual(response.success, true);
                
                if(response.success == true) {
                    
                    var connections = response.getConnections();
                    
                    XCTAssert((connections.count > 0) == true);
                    
                    if(connections.count > 0) {
                        
                        XCTAssertEqual("Mr", connections[0].getPerson().getFirstName());
                        XCTAssertEqual("Tester", connections[0].getPerson().getLastName());
                        
                        var emails = connections[0].getPerson().getEmails();
                        XCTAssertEqual(1, emails.count);
                        if(emails.count == 1) {
                            XCTAssertEqual("tester2@app.opentimeapp.com", emails[0]);
                        }
                    }
                }
                
                expectation.fulfill();
            });
        
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }

}
