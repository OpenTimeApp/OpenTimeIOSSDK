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

/*
class ConnectionAPITest: XCTestCase {

    override func setUp() {
        super.setUp()
        
        // Emulate that a user is signed in.
        let person = Person(id: 1);
        CurrentUser.sharedInstance().setUser(person);
        CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
    }
    
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
    }
    
    func testGetWithList()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate user to be added as connection.
            let person2 = Person(id: 2);
            let connection = Connection(forUser: TestUser.userID, connection:  person2, lastUpdated: Int(NSDate().timeIntervalSince1970) + 1, status: Connection.Status.Active);
            
            // Create active connection.
            var expectation = expectationWithDescription("Set Active Connection");
            ConnectionAPI.set(connection, done: {(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                expectation.fulfill();
            });
            waitForExpectationsWithTimeout(5.0, handler:nil);
            
            // Create active connection.
            expectation = expectationWithDescription("Get connection list");
            ConnectionAPI.getList([2], done: {(response: OTAPIResponse)-> () in
                
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
    }
    
    func testGetWithContactInfoList()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            let person      = Person(id: 3);
            person.addEmail("tester1@app.opentimeapp.com");
            let connection1 = Connection(forUser: 1, connection: person, lastUpdated: 0, status: 0);
            let contact1    = PhoneContact(recordID: 27);
            contact1.addEmail("tester2@app.opentimeapp.com");
            
            let connections = [connection1];
            let contacts    = [contact1];
            
            // Query list of open time users based on contact information.
            let expectation = expectationWithDescription("Get connection list");
            ConnectionAPI.getWithContactInfo(connections, contacts: contacts, done: {(response: OTAPIResponse)-> () in
                
                XCTAssertEqual(response.success, true);
                
                if(response.success == true)
                {
                    var connections = response.data as! Array<Connection>;
                    
                    XCTAssert((connections.count > 0) == true);
                    
                    if(connections.count > 0) {
                        
                        XCTAssertEqual("Mr", connections[0].person.getFirstName());
                        XCTAssertEqual("Tester", connections[0].person.getLastName());
                        
                        var emails = connections[0].person.getEmails();
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
*/
