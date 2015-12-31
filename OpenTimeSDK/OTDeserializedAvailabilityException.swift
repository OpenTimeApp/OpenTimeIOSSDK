//
//  OTDeserializedAvailabilityException.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/31/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedAvailabilityException {
    
    private struct Keys {
        static let START = "start";
        static let END   = "end";
    }
    
    private var _start: OpenTimeUserID;
    private var _end: OpenTimeUserID;
    
    public init(dictionary: NSDictionary) {
        self._start = dictionary.objectForKey(Keys.START) as! Int;
        self._end   = dictionary.objectForKey(Keys.END) as! Int;
    }
    
    public static func deserializeList(rawData: NSArray) -> Array<OTDeserializedAvailabilityException> {
        
        var list: Array<OTDeserializedAvailabilityException> = Array<OTDeserializedAvailabilityException>();
        
        for var attendeeIndex = 0; attendeeIndex < rawData.count; attendeeIndex++ {
            
            let rawAttendeeData = rawData.objectAtIndex(attendeeIndex) as! NSDictionary;
            
            let attendee = OTDeserializedAvailabilityException(dictionary: rawAttendeeData);
            
            list.append(attendee);
        }
        
        return list;
    }
    
    public func getStart() -> OpenTimeTimeStamp {
        return self._start;
    }
    
    public func getEnd() -> OpenTimeTimeStamp {
        return self._end;
    }
}