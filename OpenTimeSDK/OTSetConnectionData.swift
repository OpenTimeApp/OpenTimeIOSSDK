//
//  SetConnectionData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSetConnectionData {
    
    private var _userID: OpenTimeUserID;
    private var _status: ConnectionStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _returnConnection: Bool;
    
    public init(userID: Int, status: Int, lastUpdated: OpenTimeTimeStamp){
        _userID           = userID;
        _status           = status;
        _lastUpdated      = lastUpdated;
        _returnConnection = false;
    }
    
    public func getUserID() -> OpenTimeUserID {
        return _userID;
    }
    
    public func getParameters() -> NSDictionary {
        
        // Setup query parameters.
        let parameters = [
            "status": self._status,
            "last_updated": self._lastUpdated,
            "return_connection": self._returnConnection
        ];
        
        return parameters;
    }
    
    public func shouldReturnConnection(shouldReturnConnection: Bool) {
        self._returnConnection = shouldReturnConnection;
    }
}
