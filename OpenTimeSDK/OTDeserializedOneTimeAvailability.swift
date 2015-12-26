//
//  OTDeserializedOneTimeAvailability.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedOneTimeAvailability {
    
    private var _created: OpenTimeTimeStamp;
    private var _start: OpenTimeTimeStamp;
    private var _end: OpenTimeTimeStamp;
    private var _status: AvailabilityStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    
    public init(dictionary: NSDictionary){
        self._created     = dictionary.objectForKey("time_created") as! Int;
        self._start       = dictionary.objectForKey("start") as! Int;
        self._end         = dictionary.objectForKey("end") as! Int;
        self._status      = dictionary.objectForKey("status") as! Int;
        self._lastUpdated = dictionary.objectForKey("last_updated") as! Int;
    }
    
    public func getCreatedTimestamp() -> OpenTimeTimeStamp {
        return self._created;
    }
    
    public func getStart() -> OpenTimeTimeStamp {
        return self._start;
    }
    
    public func getEnd() -> OpenTimeTimeStamp {
        return self._end;
    }
    
    public func getStatus() -> AvailabilityStatus {
        return self._status;
    }
    
    public func getLastUpdated() -> OpenTimeTimeStamp {
        return self._lastUpdated;
    }
    
}
