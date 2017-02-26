//
//  PersontAPITest.swift
//  OpenTime
//
//  Created by Josh Woodcock on 2/11/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK

class OTPersonAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        OpenTimeSDK.initSession(OpenTimeSDKTestConstants.API_KEY, inTestMode: true);
    }
    
    func testCreateUser() {
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["clear_users"], resetCache: true);
        
        if(response.success) {
            
            let theExpectation = expectation(description: "Create Users");
            
            let data = OTNewPersonData(
                firstName: "Mr",
                lastName: "Tester",
                email: "tester1@app.opentimeapp.com",
                cellPhone: "+1 407-235-4361",
                password: "ilovetesting",
                confirmPassword: "ilovetesting"
            );
            
            OTPersonAPI.make(data, done: { (response: OTRegisterPersonResponse) -> Void in
                
                XCTAssert(response.success == true);
                
                if(response.success && response.getPerson() != nil){
                    XCTAssertEqual(1, response.getPerson()!.getUserID());
                }
                
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler:nil)
        }
    }
    
    func testSignIn() {
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);

        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            
            let theExpectation = expectation(description: "Sign in");
            
            let email: String = "tester1@app.opentimeapp.com";
            let password: String = "ilovetesting";
            
            let signinData = OTSigninRequest(email: email, password: password);
            
            OTPersonAPI.signIn(signinData, done: { (response) -> Void in
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    let user: OTDeserializedPerson! = response.getPerson();
                    
                    XCTAssertTrue(user != nil);
                    
                    if(user != nil)
                    {
                        XCTAssertEqual("Mr", user.getFirstName());
                        XCTAssertEqual("Tester", user.getLastName());
                        XCTAssertEqual(1, user.getUserID());
                    }
                }
                
                theExpectation.fulfill();
            });
    
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }
    
    func testUpdatePassword() {
        
        // Setup test data on server.
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users"], resetCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            OpenTimeSDK.initSession(OpenTimeSDKTestConstants.API_KEY, inTestMode: true);
            OpenTimeSDK.session.setPlainTextCredentials(1, password: "ilovetesting");
            
            let theExpectation = expectation(description: "Update password");
            
            let request = OTUpdatePasswordRequest(password: "alsdfsjalsdfk", confirmPassword: "alsdfsjalsdfk");
            
            OTPersonAPI.updatePassword(request, done: { (response: OTAPIResponse) -> Void in
                XCTAssertTrue(response.success == true);
                
                theExpectation.fulfill();
            })
            
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }

    func testGetGroups(){
        
        let scripts = [
            "make_users",
            "make_groups",
            "make_group_availability",
            "make_meetings"
        ];
        
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: scripts, resetCache: true);
        
        XCTAssertTrue(response.success);
        
        if(response.success){
            
            let theExpectation = expectation(description: "A list of groups for the current user will be returned");
            
            OpenTimeSDK.initSession(OpenTimeSDKTestConstants.API_KEY, inTestMode: true);
            OpenTimeSDK.session.setPlainTextCredentials(1, password: "ilovetesting");
            
            OTPersonAPI.getGroups(done: { (response: OTGroupsResponse) -> Void in
                
                XCTAssertTrue(response.success);
                
                if(response.success){
                    XCTAssertEqual(1, response.getGroups().count);
                    
                    if(response.getGroups().count == 1){
                        let groups = response.getGroups();
                        let firstGroup = groups[0];
                        
                        XCTAssertEqual(2, firstGroup.getMembers().count);
                        
                        if(firstGroup.getMembers().count == 2){
                            let members = firstGroup.getMembers();
                            let firstMember = members[0];
                            
                            XCTAssertNotNil(firstMember.getUser());
                            
                            if(firstMember.getUser() != nil){
                                let firstUser:OTDeserializedPerson! = firstMember.getUser();
                                
                                XCTAssertEqual(1, firstUser.getUserID());
                                XCTAssertEqual("Mr", firstUser.getFirstName())
                                XCTAssertEqual("Tester", firstUser.getLastName())
                                XCTAssertEqual(0, firstUser.getEmails().count);
                                XCTAssertEqual(0, firstUser.getPhones().count);
                            }
                        }
                    }
                }
                
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler: nil);
        }

    }
}

