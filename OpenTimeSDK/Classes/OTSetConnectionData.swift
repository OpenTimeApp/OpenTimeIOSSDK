//
//  SetConnectionData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSetConnectionData {
    
    private var _orgID: OpenTimeOrgID;
    private var _userID: OpenTimeUserID;
    private var _status: ConnectionStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _returnConnection: Bool;
    
    public init(orgID: OpenTimeOrgID, userID: OpenTimeUserID, status: ConnectionStatus, lastUpdated: OpenTimeTimeStamp){
        self._orgID            = orgID;
        self._userID           = userID;
        self._status           = status;
        self._lastUpdated      = lastUpdated;
        self._returnConnection = false;
    }
    
    public func getUserID() -> OpenTimeUserID {
        return _userID;
    }
    
    public func getParameters() -> NSDictionary {
        
        // Setup query parameters.
        let parameters = [
            "org_id"            : self._orgID,
            "status"            : self._status,
            "last_updated"      : self._lastUpdated,
            "return_connection" : self._returnConnection
        ] as [String : Any];
        
        return parameters as NSDictionary;
    }
    
    public func shouldReturnConnection(_ shouldReturnConnection: Bool) {
        self._returnConnection = shouldReturnConnection;
    }
}
