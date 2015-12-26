//
//  OTCreateMeetingData.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTCreateMeetingData {
    
    private var _attendees: Array<OpenTimeUserID>;
    private var _creator: OpenTimeUserID;
    private var _start: OpenTimeTimeStamp;
    private var _end: OpenTimeTimeStamp;
    private var _lastUpdated: OpenTimeTimeStamp;
    
    public init(
            creator: OpenTimeUserID,
            start: OpenTimeTimeStamp,
            end: OpenTimeTimeStamp,
            lastUpdated: OpenTimeTimeStamp,
            attendees: Array<OpenTimeUserID>) {
                
        self._attendees   = attendees;
        self._creator     = creator;
        self._start       = start;
        self._end         = end;
        self._lastUpdated = lastUpdated;
    }
    
    public func getParameters() -> NSDictionary{
        
        let parameters = [
            "start":_start,
            "end":_end,
            "created":_lastUpdated,
            "attendee_list": _attendees
        ];
        
        return parameters;
    }
}
