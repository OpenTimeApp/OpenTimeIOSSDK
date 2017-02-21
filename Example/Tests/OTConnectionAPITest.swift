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

class OTConnectionAPITest: OTAPITest {
    
    let TEST_ORG_ID = 88;
    
    func testAddActiveConnection() {
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);
        
        if(response.success)
        {
            // Set a connection
            let expectToSetConnection = expectation(description: "Will set connection")
            let setConnectionData = OTSetConnectionData(orgID: TEST_ORG_ID, userID: 2, status: OTConnectionStatusOption.Active, lastUpdated: Int(NSDate().timeIntervalSince1970));
            setConnectionData.shouldReturnConnection(true);
            OTConnectionAPI.set(connectionData: setConnectionData, done: { (response) -> Void in
                XCTAssertTrue(response.success, response.message);
                
                XCTAssertNotNil(response.getConnection());
                
                if(response.getConnection() != nil){
                    
                    let connection = response.getConnection();
                    let person = connection?.getPerson();
                    
                    XCTAssertEqual(2, person!.getUserID());
                    XCTAssertEqual(self.TEST_ORG_ID, connection?.getOrgID());
                }
                
                expectToSetConnection.fulfill();
            });
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }
    
    func testSetActiveConnectionAsInactive() {
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);
        
        if(response.success) {
            
            // Set a connection
            let expectToSetConnection = expectation(description: "Will set connection")
            let setConnectionData = OTSetConnectionData(orgID: TEST_ORG_ID, userID: 2, status: OTConnectionStatusOption.Active, lastUpdated: Int(NSDate().timeIntervalSince1970));
            OTConnectionAPI.set(connectionData: setConnectionData, done: { (response) -> Void in
                XCTAssertTrue(response.success);
                expectToSetConnection.fulfill();
            });
            waitForExpectations(timeout: 5.0, handler:nil);
            
            // Set active connection as inactive.
            let expectationToSetConnectionAsInactive = expectation(description: "Set Active Connection as Inactive");
            let setInactiveConnectionData = OTSetConnectionData(orgID: TEST_ORG_ID, userID: 2, status: OTConnectionStatusOption.Inactive, lastUpdated: Int(NSDate().timeIntervalSince1970));
            OTConnectionAPI.set(connectionData: setInactiveConnectionData, done: { (response: OTAPIResponse) -> Void in
                XCTAssertTrue(response.success);
                expectationToSetConnectionAsInactive.fulfill();
            });

            waitForExpectations(timeout: 5.0, handler:nil)
        }
    }
    
    func testRemoveConnection() {
        
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);
        
        if(response.success) {
            
            // Set a connection
            let expectToSetConnection = expectation(description: "Will set connection")
            let setConnectionData = OTSetConnectionData(orgID: TEST_ORG_ID, userID: 2, status: OTConnectionStatusOption.Active, lastUpdated: Int(NSDate().timeIntervalSince1970));
            OTConnectionAPI.set(connectionData: setConnectionData, done: { (response) -> Void in
                XCTAssertTrue(response.success);
                expectToSetConnection.fulfill();
            });
            waitForExpectations(timeout: 5.0, handler:nil);
            
            // Set active connection as inactive.
            let expectationToRemoveConnection = expectation(description: "Remove Active Connection");
            OTConnectionAPI.remove(2, lastUpdated: Int(NSDate().timeIntervalSince1970) + 3, done: { (response) -> Void in
                XCTAssertEqual(response.success, true);
                
                expectationToRemoveConnection.fulfill();
            });
            waitForExpectations(timeout: 5.0, handler:nil)
        }
    }
    
    func testGetAll() {
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);
        
        if(response.success) {
    
            // Set a connection
            let expectToSetConnection = expectation(description: "Will set connection")
            let setConnectionData = OTSetConnectionData(orgID: TEST_ORG_ID, userID: 2, status: OTConnectionStatusOption.Active, lastUpdated: Int(NSDate().timeIntervalSince1970));
            OTConnectionAPI.set(connectionData: setConnectionData, done: { (response) -> Void in
                XCTAssertTrue(response.success);
                expectToSetConnection.fulfill();
            });
            waitForExpectations(timeout: 5.0, handler:nil);
            
            
            let theExpectation = expectation(description: "Set active connection");
            OTConnectionAPI.getAll({ (response) -> Void in
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
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler:nil);
            
        }
    }
    
    func testGetWithList() {
        
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);
        
        if(response.success) {
            
            // Set a connection
            let expectToSetConnection = expectation(description: "Will set connection")
            let setConnectionData = OTSetConnectionData(orgID: TEST_ORG_ID, userID: 2, status: OTConnectionStatusOption.Active, lastUpdated: Int(NSDate().timeIntervalSince1970) + 1);
            OTConnectionAPI.set(connectionData: setConnectionData, done: { (response) -> Void in
                XCTAssertTrue(response.success);
                expectToSetConnection.fulfill();
            });
            waitForExpectations(timeout: 5.0, handler:nil);
            
            // Get the connections to see if is there.
            let expectToGetConnections = expectation(description: "Will get list of connections");
            OTConnectionAPI.getList([2], done: { (response: OTConnectionsResponse) -> Void in
                XCTAssertTrue(response.success);
                if(response.success){
                    XCTAssert(response.getConnections().count > 0);
                }
                expectToGetConnections.fulfill();
            });
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }
    
    func testGetWithContactInfoList() {

        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);
        
        if(response.success) {
            
            let contactinfodata1 = OTContactInfoData(emails: ["tester1@app.opentimeapp.com"], cellPhones: []);
            let contactinfodata2 = OTContactInfoData(emails: ["tester2@app.opentimeapp.com"], cellPhones: []);
            
            let data = OTGetConnectionsWithContactInfoData(
                connections: [contactinfodata1],
                contactsAlreadyInOpenTime: [contactinfodata2]
            );
            
            let theExpectation = expectation(description: "Get connection list");
            OTConnectionAPI.getWithContactInfo(data, done: { (response: OTConnectionsResponse) -> Void in
                XCTAssertEqual(response.success, true, response.message);
                
                if(response.success == true) {
                    
                    var connections = response.getConnections();
                    
                    XCTAssert((connections.count > 0) == true);
                    
                    if(connections.count > 0) {
                        
                        XCTAssertEqual("Mr", connections[0].getPerson().getFirstName());
                        XCTAssertEqual("Tester", connections[0].getPerson().getLastName());
                        
                        var emails = connections[0].getPerson().getEmails();
                        XCTAssertEqual(1, emails.count);
                        if(emails.count == 1) {
                            XCTAssertEqual("tester1@app.opentimeapp.com", emails[0]);
                        }
                    }
                }
                
                theExpectation.fulfill();
            });
        
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }

}
