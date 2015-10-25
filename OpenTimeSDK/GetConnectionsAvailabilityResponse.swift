//
//  GetConnectionsAvailabilityResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class GetConnectionsAvailabilityResponse: APIResponse {
    
    private var _list: Array<DeserializedConnectionAvailability>!;
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        super.init(success: success, message: message);
        
        self._list = Array<DeserializedConnectionAvailability>();
        
        if(success == true && rawData != nil){
            self._deserializeConnectionsAvailability(rawData as! NSArray);
        }
    }
    
    private func _deserializeConnectionsAvailability(rawData: NSArray){
        
        for var connectionIndex = 0; connectionIndex < rawData.count; connectionIndex++ {
            
            let connectionData: NSDictionary = rawData.objectAtIndex(connectionIndex) as! NSDictionary;
            
            let connectionListItem = DeserializedConnectionAvailability(dictionary: connectionData);
            
            self._list.append(connectionListItem);
        }
    }
    
    public func getList() -> Array<DeserializedConnectionAvailability> {
        return self._list;
    }
}