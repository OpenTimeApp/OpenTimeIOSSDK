//
//  OTDeserializedMeeting.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedMeeting {
    
    private struct Keys {
        static let MEETING_ID   = "meeting_id";
        static let ORG_ID       = "org_id";
        static let CREATOR      = "creator";
        static let CREATED      = "created";
        static let STATUS       = "status";
        static let LAST_UPDATED = "last_updated";
        static let START        = "start";
        static let END          = "end";
        static let LOCATION     = "location";
        static let ATTENDEES    = "attendees";
    }
    
    private var _meetingID: OpenTimeMeetingID;
    private var _orgID: OpenTimeOrgID;
    private var _creator: OpenTimeUserID;
    private var _created: OpenTimeTimeStamp
    private var _status: MeetingStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _start: OpenTimeTimeStamp;
    private var _end: OpenTimeTimeStamp;
    private var _location: OTDeserializedLocation?;
    private var _attendees: Array<OTDeserializedMeetingAttendee>;
    
    public init(dictionary: NSDictionary){
        self._meetingID   = dictionary.valueForKey(Keys.MEETING_ID) as! OpenTimeMeetingID;
        self._orgID       = dictionary.valueForKey(Keys.ORG_ID) as! OpenTimeOrgID;
        self._creator     = dictionary.valueForKey(Keys.CREATOR) as! OpenTimeUserID;
        self._created     = dictionary.valueForKey(Keys.CREATED) as! OpenTimeTimeStamp;
        self._status      = dictionary.valueForKey(Keys.STATUS) as! MeetingStatus;
        self._lastUpdated = dictionary.valueForKey(Keys.LAST_UPDATED) as! OpenTimeTimeStamp;
        self._start       = dictionary.valueForKey(Keys.START) as! OpenTimeTimeStamp;
        self._end         = dictionary.valueForKey(Keys.END) as! OpenTimeTimeStamp;
        self._location    = OTDeserializedMeeting._getDeserializedLocation(dictionary.valueForKey(Keys.LOCATION));
        self._attendees   = OTDeserializedMeetingAttendee.deserializeList(dictionary.valueForKey(Keys.ATTENDEES) as! NSArray);
    }
    
    public static func deserializeList(rawData: NSArray) -> Array<OTDeserializedMeeting>{
        
        var list: Array<OTDeserializedMeeting> = Array<OTDeserializedMeeting>();
        
        for var meetingIndex = 0; meetingIndex < rawData.count; meetingIndex++ {
            
            let rawMeetingData = rawData.objectAtIndex(meetingIndex) as! NSDictionary;
            
            let attendee = OTDeserializedMeeting(dictionary: rawMeetingData);
            
            list.append(attendee);
        }
        
        return list;
    }
    
    private static func _getDeserializedLocation(rawData: AnyObject?) -> OTDeserializedLocation? {
        return rawData != nil ? OTDeserializedLocation(dictionary: rawData as! NSDictionary) : nil;
    }
    
    public func getMeetingID() -> OpenTimeMeetingID {
        return self._meetingID;
    }
    
    public func getOrgID() -> OpenTimeOrgID {
        return self._orgID;
    }
    
    public func getCreator() -> OpenTimeUserID {
        return self._creator;
    }
    
    public func getCreatedTimestamp() -> OpenTimeTimeStamp {
        return self._created;
    }
    
    public func getStatus() -> MeetingStatus {
        return self._status;
    }
    
    public func getLastUpdated() -> OpenTimeTimeStamp {
        return self._lastUpdated;
    }
    
    public func getStart() -> OpenTimeTimeStamp {
        return self._start;
    }
    
    public func getEnd() -> OpenTimeTimeStamp {
        return self._end;
    }
    
    public func getLocation() -> OTDeserializedLocation? {
        return self._location;
    }
    
    public func getMeetingAttendees() -> Array<OTDeserializedMeetingAttendee> {
        return self._attendees;
    }
}
