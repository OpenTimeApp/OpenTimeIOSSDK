//
//  ConnectionData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedConnection : OTDeserializer{
    
    private struct Keys {
        static let ORG_ID       = "org_id";
        static let STATUS       = "status";
        static let LAST_UPDATED = "last_updated";
        static let PERSON       = "person";
    }
    
    private var _orgID: OpenTimeOrgID;
    private var _status: ConnectionStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _deserializedPerson: OTDeserializedPerson;
    
    public required init(dictionary: NSDictionary){
        self._orgID       = dictionary.valueForKey(Keys.ORG_ID) as! OpenTimeOrgID;
        self._status      = dictionary.valueForKey(Keys.STATUS) as! ConnectionStatus;
        self._lastUpdated = dictionary.valueForKey(Keys.LAST_UPDATED) as! OpenTimeTimeStamp;
        
        let personDictionary = dictionary.valueForKey(Keys.PERSON) as! NSDictionary;
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
    
    public func getOrgID()->OpenTimeOrgID {
        return self._orgID;
    }
}
