//
//  OTDeserializedMeeting.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/26/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedMeeting : OTDeserializer {
    
    public struct Keys {
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
    private var _orgID: OpenTimeOrgID?;
    private var _creator: OpenTimeUserID;
    private var _created: OpenTimeTimeStamp
    private var _status: MeetingStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _start: OpenTimeTimeStamp;
    private var _end: OpenTimeTimeStamp;
    private var _location: OTDeserializedLocation?;
    private var _attendees: Array<OTDeserializedMeetingAttendee>;
    
    public required init(dictionary: NSDictionary){
        self._meetingID   = dictionary.value(forKey: Keys.MEETING_ID) as! OpenTimeMeetingID;
        self._orgID       = dictionary.value(forKey: Keys.ORG_ID) as? OpenTimeOrgID;
        self._creator     = dictionary.value(forKey: Keys.CREATOR) as! OpenTimeUserID;
        self._created     = dictionary.value(forKey: Keys.CREATED) as! OpenTimeTimeStamp;
        self._status      = dictionary.value(forKey: Keys.STATUS) as! MeetingStatus;
        self._lastUpdated = dictionary.value(forKey: Keys.LAST_UPDATED) as! OpenTimeTimeStamp;
        self._start       = dictionary.value(forKey: Keys.START) as! OpenTimeTimeStamp;
        self._end         = dictionary.value(forKey: Keys.END) as! OpenTimeTimeStamp;
        self._location    = OTDeserializedMeeting._getDeserializedLocation(dictionary.value(forKey: Keys.LOCATION) as AnyObject?);
        
        let rawAttendees = dictionary.value(forKey: Keys.ATTENDEES) as! NSArray;
        self._attendees = OTDeserializationHelper.deserializeList(rawAttendees, type: OTDeserializedMeetingAttendee.self) as! Array<OTDeserializedMeetingAttendee>
    }
    
    private static func _getDeserializedLocation(_ rawData: AnyObject?) -> OTDeserializedLocation? {
        return rawData != nil ? OTDeserializedLocation(dictionary: rawData as! NSDictionary) : nil;
    }
    
    public func getMeetingID() -> OpenTimeMeetingID {
        return self._meetingID;
    }
    
    public func getOrgID() -> OpenTimeOrgID? {
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
