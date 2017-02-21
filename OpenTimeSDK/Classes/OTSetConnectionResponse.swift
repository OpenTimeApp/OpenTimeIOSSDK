//
//  SetConnectionsResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSetConnectionResponse : OTAPIResponse {
    
    private var _connection: OTDeserializedConnection?
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        super.init(success: success, message: message);
        
        if(rawData != nil){
            _connection = OTDeserializedConnection(dictionary: rawData! as! NSDictionary);
        }
    }
    
    public func getConnection() -> OTDeserializedConnection? {
        return self._connection;
    }
}
