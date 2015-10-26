//
//  RemoveOneTimeAvailability.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTRemoveOneTimeAvailabilityData {
    
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _createdTimestamp: OpenTimeTimeStamp;
    
    public init(
        lastUpdated: OpenTimeTimeStamp,
        createdTimestamp: OpenTimeTimeStamp){
            
        self._lastUpdated      = lastUpdated;
        self._createdTimestamp = createdTimestamp;
    }
    
    public func getParameters() -> NSDictionary {
        
        let parameters = [
            "last_updated":self._lastUpdated
        ];
        
        return parameters;
    }
    
    public func getCreatedTimestamp() -> OpenTimeTimeStamp {
        return self._createdTimestamp;
    }
}
