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
/*
class MeetingAPITest: XCTestCase {

    override func setUp() {
        super.setUp()
        MeetingAPI.testing = true;
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateMeeting()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users", "make_meetings"]);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate that a user is signed in.
            let person = Person(id: 1);
            CurrentUser.sharedInstance().setUser(person);
            CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
            
            // Create an expectation to be fulfilled.
            let expectation = expectationWithDescription("Create Meeting");
            
            // Setup the test data to send to server.
            let start: Int = Int(NSDate().timeIntervalSince1970) + 3600;
            let end        = start + 3600;
            
            // Create object to send to server.
            let meeting = Meeting(creator: 1, start: start, end: end, lastUpdated: start);
            meeting.addAttendeePerson(CurrentUser.sharedInstance().getUser());
            meeting.addAttendeePerson(Person(id: 2));
            
            // Send object to server.
            MeetingAPI.create(meeting, done: {(response: APIResponse) -> () in
                
                // Verify the server responded with a success.
                XCTAssert(response.success == true);
                
                // Verify the response data isn't null.
                XCTAssert(response.data != nil);
                
                // If the response was successful and the data isn't empty check whether the meeting object contains a meeting id.
                if(response.success == true && response.data != nil)
                {
                    let meeting: Meeting = response.data as! Meeting;
                    XCTAssertEqual(2, meeting.id());
                }
                
                // Tell the test handler that the test is done.
                expectation.fulfill();
            });
            
            // Start waiting for the test to be fulfilled for 5 seconds.
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }
    
    // TODO: Incomplete
    func testUpdateMeeting()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_meetings"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
    }
    
    func testGetAllMyMeetings()
    {
        // Setup test data on server.
        let response = TestHelper.resetAPIData(["make_users", "make_meetings"], clearCache: true);
        
        // Verify test data was setup correctly.
        XCTAssertTrue(response.success, response.message);
        
        if(response.success)
        {
            // Emulate that a user is signed in.
            let person = Person(id: 1);
            let person2 = Person(id: 2);
            CurrentUser.sharedInstance().setUser(person);
            CurrentUser.sharedInstance().getUser().getConnections().setPersonInRamAndStorage(person2, withStatus: Connection.Status.Active);
            CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
            
            // Create an expectation to be fulfilled.
            let expectation = expectationWithDescription("Get all my meetings");
            
            MeetingAPI.getAll({(response: APIResponse)-> Void in
                
                XCTAssertTrue(response.success == true);
                if(response.success == true)
                {
                    var meetings = response.data as! Array<Meeting>;
                    
                    XCTAssertEqual(1, meetings.count);
                    
                    if(meetings.count > 0)
                    {
                        let meeting: Meeting = meetings[0] as Meeting;
                        
                        XCTAssertEqual(2060020800, meeting.start());
                        XCTAssertEqual(2060028000, meeting.end());
                        XCTAssertEqual(12.123456, meeting.location().lat());
                        XCTAssertEqual(123.123456, meeting.location().long());
                        XCTAssertEqual("123 main street, Dallas, TX 75248", meeting.location().address());
                        
                        // We always want the create date to show as 0 so that the app will use the meeting id to coordinate storage.
                        // The use of the create data is a temporary way to store the meeting in case the user is offline.
                        XCTAssertNotEqual(0, meeting.created());
                        XCTAssertEqual(SyncItem.Status.Active, meeting.status());
                        XCTAssertEqual(1427845204, meeting.lastUpdated());
                        XCTAssertEqual(1, meeting.creator());
                        
                        XCTAssertEqual(2, meeting.getAttendees().count);
                        
                        if(meeting.getParticipants().count >= 2)
                        {
                            var attendees = meeting.getAttendees();
                            let attendee1 = attendees[0] as MeetingAttendee;
                            
                            XCTAssertEqual(1, attendee1.attendee().getID());
                            XCTAssertEqual(MeetingAttendee.Status.Accepted, attendee1.status());
                            /// TODO implement attendee titles
                            //XCTAssertEqual("A meeting with Chris", attendee1.title());
                            XCTAssertEqual(1427845204, attendee1.lastUpdated());
                        }
                    }
                }
                
                // Tell the test handler that the test is done.
                expectation.fulfill();
            });
            
            // Start waiting for the test to be fulfilled for 5 seconds.
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }

}
*/
