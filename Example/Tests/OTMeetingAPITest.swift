//
//  MeetingAPITest.swift
//  OpenTime
//
//  Created by Josh Woodcock on 4/3/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK

class OTMeetingAPITest: OTAPITest {
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateMeeting()
    {
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users", "make_meetings"], resetCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success) {
            
            // Create an expectation to be fulfilled.
            let theExpectation = expectation(description: "Create Meeting");
            
            // Setup the test data to send to server.
            let start: Int = Int(NSDate().timeIntervalSince1970) + 3600;
            let end        = start + 3600;
            
            // Create object to send to server.
            let createMeetingData = OTCreateMeetingData(orgID: 1,
                creator: 1, start: start, end: end, lastUpdated: start, attendees: [1, 2]);
            
            OTMeetingAPI.create(createMeetingData: createMeetingData, done: { (response) -> Void in
                XCTAssertTrue(response.success);
                
                XCTAssertNotNil(response.getMeetingData());
                
                if(response.success == true && response.getMeetingData() != nil){
                    XCTAssertEqual(3, response.getMeetingData()?.getMeetingID());
                }
                
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler: nil);
        }
    }
    
    func testGetAllMyMeetings() {
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_users", "make_meetings"], resetCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success) {
            
            // Create an expectation to be fulfilled.
            let theExpectation = expectation(description: "Get all my meetings");
            
            OTMeetingAPI.getAllMyMeetings(done: { (response: OTGetAllMyMeetingsResponse) -> Void in
                XCTAssertTrue(response.success);
                XCTAssertEqual(2, response.getMeetings().count);
                
                if(response.success && response.getMeetings().count == 1){
                    
                    let meetings = response.getMeetings();
                    
                    let meeting: OTDeserializedMeeting = meetings[0] as OTDeserializedMeeting;
                    
                    XCTAssertEqual(2060020800, meeting.getStart());
                    XCTAssertEqual(2060028000, meeting.getEnd());
                    
                    XCTAssertNotNil(meeting.getLocation());
                    if(meeting.getLocation() != nil){
                        XCTAssertEqual(12.123456, meeting.getLocation()?.getLatitude());
                        XCTAssertEqual(123.123456, meeting.getLocation()?.getLongitude());
                        XCTAssertEqual("123 main street, Dallas, TX 75248", meeting.getLocation()?.getAddress());
                    }
                    
                    // We always want the create date to show as 0 so that the app will use the meeting id to coordinate storage.
                    // The use of the create data is a temporary way to store the meeting in case the user is offline.
                    XCTAssertNotEqual(0, meeting.getCreatedTimestamp());
                    XCTAssertEqual(OTMeetingStatusOption.Active, meeting.getStatus());
                    XCTAssertEqual(1427845204, meeting.getLastUpdated());
                    XCTAssertEqual(1, meeting.getCreator());
                    
                    XCTAssertEqual(2, meeting.getMeetingAttendees().count);
                    
                    if(meeting.getMeetingAttendees().count >= 2) {
                        var attendees = meeting.getMeetingAttendees();
                        let attendee1 = attendees[0] as OTDeserializedMeetingAttendee;
                        
                        XCTAssertEqual(1, attendee1.getUserID());
                        XCTAssertEqual(MeetingAttendeeStatusOption.Accepted, attendee1.getStatus());

                        XCTAssertEqual(1427845204, attendee1.getLastUpdated());
                    }
                }
                
                theExpectation.fulfill();
            });
            
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }
}
