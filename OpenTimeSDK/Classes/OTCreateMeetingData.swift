//
//  OTCreateMeetingData.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTCreateMeetingData {
    
    private var _attendees: Array<OpenTimeUserID>;
    private var _orgID: OpenTimeOrgID;
    private var _creator: OpenTimeUserID;
    private var _start: OpenTimeTimeStamp;
    private var _end: OpenTimeTimeStamp;
    private var _lastUpdated: OpenTimeTimeStamp;
    
    public init(
            orgID: OpenTimeOrgID,
            creator: OpenTimeUserID,
            start: OpenTimeTimeStamp,
            end: OpenTimeTimeStamp,
            lastUpdated: OpenTimeTimeStamp,
            attendees: Array<OpenTimeUserID>) {
        
        self._orgID       = orgID;
        self._attendees   = attendees;
        self._creator     = creator;
        self._start       = start;
        self._end         = end;
        self._lastUpdated = lastUpdated;
    }
    
    public func getParameters() -> NSDictionary{
        
        let parameters = [
            "org_id"       : self._orgID,
            "start"        : self._start,
            "end"          : self._end,
            "created"      : self._lastUpdated,
            "attendee_list": self._attendees
        ] as [String : Any];
        
        return parameters as NSDictionary;
    }
}
