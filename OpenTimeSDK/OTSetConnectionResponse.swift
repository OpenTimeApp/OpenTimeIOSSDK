//
//  SetConnectionsResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSetConnectionResponse : OTAPIResponse {
    
    private var _connection: OTDeserializedConnection!
    
    public init(success: Bool, message: String, connectionData: OTDeserializedConnection?){
        super.init(success: success, message: message);
        _connection = connectionData!;
    }
}
