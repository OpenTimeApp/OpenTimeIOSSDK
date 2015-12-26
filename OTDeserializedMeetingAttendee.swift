//
//  OTDeserializedMeetingAttendee.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedMeetingAttendee {
    
    private struct Keys {
        static let USER_ID      = "user_id";
        static let STATUS       = "status";
        static let LAST_UPDATED = "last_updated";
    }
    
    private var _userID: OpenTimeUserID;
    private var _status: MeetingAttendeeStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    
    public init(dictionary: NSDictionary){
        self._userID      = dictionary.valueForKey(Keys.USER_ID) as! OpenTimeUserID;
        self._status      = dictionary.valueForKey(Keys.STATUS) as! MeetingAttendeeStatus;
        self._lastUpdated = dictionary.valueForKey(Keys.LAST_UPDATED) as! OpenTimeTimeStamp;
    }
    
    public static func deserializeList(rawData: NSArray) -> Array<OTDeserializedMeetingAttendee>{
        
        var list: Array<OTDeserializedMeetingAttendee> = Array<OTDeserializedMeetingAttendee>();
        
        for var attendeeIndex = 0; attendeeIndex < rawData.count; attendeeIndex++ {
            
            let rawAttendeeData = rawData.objectAtIndex(attendeeIndex) as! NSDictionary;
            
            let attendee = OTDeserializedMeetingAttendee(dictionary: rawAttendeeData);
            
            list.append(attendee);
        }
        
        return list;
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
