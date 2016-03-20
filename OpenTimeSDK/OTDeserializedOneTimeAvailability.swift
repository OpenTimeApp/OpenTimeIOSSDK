//
//  OTDeserializedOneTimeAvailability.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedOneTimeAvailability : OTDeserializer {
    
    private struct Keys {
        static let TIME_CREATED = "time_created";
        static let START        = "start";
        static let END          = "end";
        static let STATUS       = "status";
        static let LAST_UPDATED = "last_updated";
    }
    
    private var _created: OpenTimeTimeStamp;
    private var _start: OpenTimeTimeStamp;
    private var _end: OpenTimeTimeStamp;
    private var _status: AvailabilityStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    
    public required init(dictionary: NSDictionary){
        self._created     = dictionary.objectForKey(Keys.TIME_CREATED) as! Int;
        self._start       = dictionary.objectForKey(Keys.START) as! Int;
        self._end         = dictionary.objectForKey(Keys.END) as! Int;
        self._status      = dictionary.objectForKey(Keys.STATUS) as! Int;
        self._lastUpdated = dictionary.objectForKey(Keys.LAST_UPDATED) as! Int;
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
