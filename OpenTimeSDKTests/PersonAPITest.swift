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
/*
class PersonAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        APIRequestOperationManager.disableCache();
        
        // Emulate that a user is signed in.
        let person = Person(id: 1);
        CurrentUser.sharedInstance().setUser(person);
        CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
    }
    
    func testCreateUser()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["clear_users"]);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        if(response.success)
        {
            let expectation = expectationWithDescription("Create Users");
            
            PersonAPI.make("Mr", lastName: "Tester", email: "tester1@app.opentimeapp.com", cellPhone: "+1 407-235-4361", password: "I love testing", confirmPassword: "I love testing", done: {
                (response: OTAPIResponse) -> () in
                XCTAssert(response.success == true);
                XCTAssert(response.data != nil);
                if(response.data != nil)
                {
                    XCTAssertEqual(1, (response.data as! Person).getID());
                }
                
                expectation.fulfill();
            });
            
            waitForExpectationsWithTimeout(5.0, handler:nil)
        }
    }
    
    
    func testGetPersonsNearLocation()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            
            let expectation = expectationWithDescription("Search Nearby Users");
            
            let location = Location(name: Word(text: "", gender: Word.Gender.Generic));
            
            PersonAPI.getPeopleNearLocation(location, done: {(response: OTAPIResponse) -> () in
                
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    var array:Array<AnyObject> = response.data as! Array<AnyObject>;
                    
                    XCTAssertEqual(1, array.count);
                    if(array.count == 1)
                    {
                        XCTAssertEqual("Tester", array[0][2] as? String);
                    }
                }

                expectation.fulfill();

            });
            
            waitForExpectationsWithTimeout(10.0, handler:nil)
        }
    }
    
    func testSignIn()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            
            let expectation = expectationWithDescription("Sign in");
            
            let email: String = "tester1@app.opentimeapp.com";
            let password: String = "I love testing";
            
            PersonAPI.signIn(email, password: password, done:{(response: OTAPIResponse)->Void in
            
                XCTAssertTrue(response.success == true);
                
                if(response.success == true)
                {
                    let user: Person! = response.data as! Person!;
                    
                    XCTAssertTrue(user != nil);
                    
                    if(user != nil)
                    {
                        XCTAssertEqual("Mr", user.getFirstName());
                        XCTAssertEqual("Tester", user.getLastName());
                        XCTAssertEqual(1, user.getID());
                    }
                }
                
                expectation.fulfill();
            
            });
    
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }
    
}
*/
