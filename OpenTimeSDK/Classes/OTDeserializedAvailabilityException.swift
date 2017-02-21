//
//  OTDeserializedAvailabilityException.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/31/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedAvailabilityException : OTDeserializer {
    
    private struct Keys {
        static let START = "start";
        static let END   = "end";
    }
    
    private var _start: OpenTimeUserID;
    private var _end: OpenTimeUserID;
    
    public required init(dictionary: NSDictionary) {
        self._start = dictionary.object(forKey: Keys.START) as! Int;
        self._end   = dictionary.object(forKey: Keys.END) as! Int;
    }
    
    public func getStart() -> OpenTimeTimeStamp {
        return self._start;
    }
    
    public func getEnd() -> OpenTimeTimeStamp {
        return self._end;
    }
}
