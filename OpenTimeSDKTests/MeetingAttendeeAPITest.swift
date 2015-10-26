//
//  MeetingAttendeeAPITest.swift
//  OpenTime
//
//  Created by Josh Woodcock on 5/5/15.
//  Copyright (c) 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import XCTest
import OpenTimeSDK
/*
class MeetingAttendeeAPITest: XCTestCase {

    override func setUp() {
        super.setUp();
        
        // Emulate that a user is signed in.
        let person = Person(id: 1);
        CurrentUser.sharedInstance().setUser(person);
        CurrentUser.sharedInstance().storeUser("tester1@app.opentimeapp.com", password: "I love testing", person: person);
    }
    
    func testUpdate()
    {
        let response: OTAPIResponse = TestHelper.resetAPIData(["make_meetings","make_users"]);
        
        XCTAssertTrue(response.success);
        if(response.success)
        {
            // Create an expectation to be fulfilled.
            let expectation = expectationWithDescription("Get a meeting");
            
            MeetingAPI.getAll({(response: OTAPIResponse)-> Void in
                
                XCTAssertTrue(response.success == true);
                if(response.success == true)
                {
                    var meetings = response.data as! Array<Meeting>;
                    
                    XCTAssertEqual(1, meetings.count);
                    
                    if(meetings.count > 0)
                    {
                        let meeting: Meeting = meetings[0] as Meeting;
                        
                        let attendee = meeting.getAttendees()[1];
                        
                        attendee.status(MeetingAttendee.Status.Accepted);
                        
                        MeetingAttendeeAPI.update(attendee, meetingID: meeting.id(), done: {(response: OTAPIResponse)->Void in
                            
                            MeetingAPI.getAll({(response: OTAPIResponse)-> Void in
                                
                                var updatedMeetings = response.data as! Array<Meeting>;
                                
                                if(updatedMeetings.count > 0)
                                {
                                    let updatedMeeting: Meeting = updatedMeetings[0] as Meeting;
                                    
                                    let updatedAttendee = updatedMeeting.getAttendees()[1];
                                    
                                    XCTAssertEqual(MeetingAttendee.Status.Accepted, updatedAttendee.status());
                                }
                                
                                // Tell the test handler that the test is done.
                                expectation.fulfill();
                            });
                        });
                    }else{
                        // Tell the test handler that the test is done.
                        expectation.fulfill();
                    }
                }
            });
            
            // Start waiting for the test to be fulfilled for 5 seconds.
            waitForExpectationsWithTimeout(5.0, handler:nil);
        }
    }

}
*/
