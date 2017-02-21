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

class OTMeetingAttendeeAPITest: OTAPITest {
    
    func testUpdate() {
        
        let response: OTAPIResponse = TestHelper.getDataResetResponse(testCase: self, scriptNames: ["make_meetings","make_users"], resetCache: true);
        
        XCTAssertTrue(response.success);
        if(response.success) {
            
            // Create an expectation to be fulfilled.
            let theExpectation = expectation(description: "Get a meeting");
            
            OTMeetingAPI.getAllMyMeetings(done: { (response) -> Void in
                
                XCTAssertTrue(response.success == true);
                if(response.success == true) {
                    
                    var meetings = response.getMeetings()
                    
                    XCTAssertEqual(1, meetings.count);
                    
                    if(meetings.count > 0) {
                        
                        let meeting: OTDeserializedMeeting = meetings[0] as OTDeserializedMeeting;
                        
                        let attendees = meeting.getMeetingAttendees();
                        let attendee = attendees[0];
                        
                        let attendeeStatusUpdateData = OTSetMeetingAttendeeData(
                            meetingID: meeting.getMeetingID(),
                            attendeeUserID: attendee.getUserID(),
                            status: MeetingAttendeeStatusOption.Accepted,
                            lastUpdated: attendee.getLastUpdated() + 1);
                        
                        OTMeetingAttendeeAPI.set(attendeeStatusUpdateData, done: { (response: OTSetMeetingAttendeeResponse) -> Void in
                            
                            OTMeetingAPI.getAllMyMeetings(done: { (response: OTGetAllMyMeetingsResponse) -> Void in
                                var updatedMeetings = response.getMeetings();
                                
                                XCTAssertTrue(updatedMeetings.count > 0);
                                
                                if(updatedMeetings.count > 0)
                                {
                                    let updatedMeeting: OTDeserializedMeeting = updatedMeetings[0] as OTDeserializedMeeting;
                                    
                                    let updatedAttendees = updatedMeeting.getMeetingAttendees();
                                    let updatedAttendee = updatedAttendees[0];
                                    
                                    XCTAssertEqual(MeetingAttendeeStatusOption.Accepted, updatedAttendee.getStatus());
                                }
                                
                                // Tell the test handler that the test is done.
                                theExpectation.fulfill();
                            });
                        })
                        
                    }else{
                        // Tell the test handler that the test is done.
                        theExpectation.fulfill();
                    }
                }
            })
            
            // Start waiting for the test to be fulfilled for 5 seconds.
            waitForExpectations(timeout: 5.0, handler:nil);
        }
    }
}
