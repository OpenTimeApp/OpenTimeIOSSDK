//
//  GetAllConnectionsResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class ConnectionsResponse : APIResponse {
    
    private var _connections: Array<DeserializedConnection>;
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        self._connections = Array<DeserializedConnection>();
        super.init(success: success, message: message);
        
        if(rawData != nil) {
            
            let connectionList: NSArray = rawData as! NSArray;
            
            for var index = 0; index < connectionList.count; index++ {
                let connectionData = connectionList.objectAtIndex(index) as! NSDictionary;
                let connection = DeserializedConnection(dictionary: connectionData);
                
                self._connections.append(connection);
            }
        }
    }
    
    public func getConnections() -> Array<DeserializedConnection> {
        return _connections;
    }
}
