//
//  UpdateOneTimeAvailabilityData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSetOneTimeAvailabilityData {
    
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _createdTimestamp: OpenTimeTimeStamp;
    private var _start: OpenTimeTimeStamp;
    private var _end: OpenTimeTimeStamp;
    
    public init(
        lastUpdated: OpenTimeTimeStamp,
        createdTimestamp: OpenTimeTimeStamp,
        start: OpenTimeTimeStamp,
        end: OpenTimeTimeStamp){
            
        self._lastUpdated      = lastUpdated;
        self._createdTimestamp = createdTimestamp;
        self._start            = start;
        self._end              = end;
    }
    
    public func getParameters() -> NSDictionary {
        
        let parameters = [
            "start":self._start,
            "end":self._end,
            "last_updated":self._lastUpdated
        ]
        
        return parameters as NSDictionary;
    }
    
    public func getCreatedTimestamp() -> OpenTimeTimeStamp {
        return self._createdTimestamp;
    }
}
