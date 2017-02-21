//
//  OTDeserializedMeetingAttendee.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedMeetingAttendee : OTDeserializer {
    
    private struct Keys {
        static let USER_ID      = "user_id";
        static let STATUS       = "status";
        static let LAST_UPDATED = "last_updated";
    }
    
    private var _userID: OpenTimeUserID;
    private var _status: MeetingAttendeeStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    
    public required init(dictionary: NSDictionary){
        self._userID      = dictionary.value(forKey: Keys.USER_ID) as! OpenTimeUserID;
        self._status      = dictionary.value(forKey: Keys.STATUS) as! MeetingAttendeeStatus;
        self._lastUpdated = dictionary.value(forKey: Keys.LAST_UPDATED) as! OpenTimeTimeStamp;
    }
    
    public func getUserID() -> OpenTimeUserID {
        return self._userID;
    }
    
    public func getStatus() -> MeetingAttendeeStatus {
        return self._status;
    }
    
    public func getLastUpdated() -> OpenTimeTimeStamp {
        return self._lastUpdated;
    }

}
