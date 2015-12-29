//
//  ConnectionData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedConnection {
    
    private var _status: ConnectionStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _deserializedPerson: OTDeserializedPerson;
    
    public init(dictionary: NSDictionary){
        self._status      = dictionary.valueForKey("status") as! Int;
        self._lastUpdated = dictionary.valueForKey("last_updated") as! Int;
        
        let personDictionary = dictionary.valueForKey("person") as! NSDictionary;
        self._deserializedPerson = OTDeserializedPerson(dictionary: personDictionary);
    }
    
    public func getPerson() -> OTDeserializedPerson {
        return self._deserializedPerson;
    }
    
    public func getStatus() -> ConnectionStatus {
        return self._status;
    }
    
    public func getLastUpdated() -> OpenTimeTimeStamp {
        return self._lastUpdated;
    }
}
