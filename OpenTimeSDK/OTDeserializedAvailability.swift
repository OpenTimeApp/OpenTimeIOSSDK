//
//  OTDeserializedAvailability.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/31/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedAvailability {
    
    public struct Keys {
        static let ONE_TIME_AVAILABILITY = "one_time";
        static let EXCEPTIONS            = "exceptions";
    }
    
    private var _oneTime: Array<OTDeserializedOneTimeAvailability>;
    private var _exceptions: Array<OTDeserializedAvailabilityException>;
    
    public init(dictionary: NSDictionary){
        
        let exceptionsData: NSArray = dictionary.objectForKey(Keys.EXCEPTIONS) as! NSArray;
        let oneTimeData: NSArray = dictionary.objectForKey(Keys.ONE_TIME_AVAILABILITY) as! NSArray;
        
        self._oneTime = OTDeserializedOneTimeAvailability.deserializeList(oneTimeData);
        self._exceptions = OTDeserializedAvailabilityException.deserializeList(exceptionsData);
    }
    
    public func getOneTimeAvailability() -> Array<OTDeserializedOneTimeAvailability> {
        return self._oneTime;
    }
    
    public func getExceptions() -> Array<OTDeserializedAvailabilityException> {
        return self._exceptions;
    }
    
}
