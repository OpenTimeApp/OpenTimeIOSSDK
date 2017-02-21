//
//  OTDeserializedAvailability.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 12/31/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedAvailability : OTDeserializer{
    
    public struct Keys {
        static let ONE_TIME_AVAILABILITY = "one_time";
        static let EXCEPTIONS            = "exceptions";
    }
    
    private var _oneTime: Array<OTDeserializedOneTimeAvailability>;
    private var _exceptions: Array<OTDeserializedAvailabilityException>;
    
    public required init(dictionary: NSDictionary){
        
        let exceptionsData: NSArray = dictionary.object(forKey: Keys.EXCEPTIONS) as! NSArray;
        let oneTimeData: NSArray = dictionary.object(forKey: Keys.ONE_TIME_AVAILABILITY) as! NSArray;
        
        self._oneTime = OTDeserializationHelper.deserializeList(oneTimeData, type: OTDeserializedOneTimeAvailability.self) as! Array<OTDeserializedOneTimeAvailability>;
        self._exceptions = OTDeserializationHelper.deserializeList(exceptionsData, type: OTDeserializedAvailabilityException.self) as! Array<OTDeserializedAvailabilityException>
    }
    
    public func getOneTimeAvailability() -> Array<OTDeserializedOneTimeAvailability> {
        return self._oneTime;
    }
    
    public func getExceptions() -> Array<OTDeserializedAvailabilityException> {
        return self._exceptions;
    }
    
}
