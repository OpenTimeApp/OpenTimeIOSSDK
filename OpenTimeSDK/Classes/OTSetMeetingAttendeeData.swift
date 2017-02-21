//
//  OTSetMeetingAttendeeData.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSetMeetingAttendeeData {
    
    private var _meetingID: OpenTimeMeetingID;
    private var _userID: OpenTimeUserID;
    private var _status: MeetingAttendeeStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    
    public init(meetingID: OpenTimeMeetingID, attendeeUserID: OpenTimeUserID, status: MeetingAttendeeStatus, lastUpdated: OpenTimeTimeStamp) {
        
        self._meetingID   = meetingID;
        self._userID      = attendeeUserID;
        self._status      = status;
        self._lastUpdated = lastUpdated;
    }
    
    public func getParameters() -> NSDictionary {
        return [
            "status":self._status,
            "last_updated": self._lastUpdated
        ]
    }
    
    public func getMeetingID() -> OpenTimeMeetingID {
        return _meetingID;
    }
    
    public func getAttendeeUserID() -> OpenTimeUserID {
        return _userID;
    }
}
