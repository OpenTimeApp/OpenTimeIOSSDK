//
//  SetConnectionsResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class SetConnectionResponse : APIResponse {
    
    private var _connection: DeserializedConnection!
    
    public init(success: Bool, message: String, connectionData: DeserializedConnection?){
        super.init(success: success, message: message);
        _connection = connectionData!;
    }
}
