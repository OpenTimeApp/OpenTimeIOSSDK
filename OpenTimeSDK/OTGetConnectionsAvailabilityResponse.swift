//
//  GetConnectionsAvailabilityResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTGetConnectionsAvailabilityResponse: OTAPIResponse {
    
    private var _list: Array<OTDeserializedConnectionAvailability>!;
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        super.init(success: success, message: message);
        
        self._list = Array<OTDeserializedConnectionAvailability>();
        
        if(success == true && rawData != nil){
            self._deserializeConnectionsAvailability(rawData as! NSArray);
        }
    }
    
    private func _deserializeConnectionsAvailability(_ rawData: NSArray){
        
        for connectionIndex in 0 ..< rawData.count {
            
            let connectionData: NSDictionary = rawData.object(at: connectionIndex) as! NSDictionary;
            
            let connectionListItem = OTDeserializedConnectionAvailability(dictionary: connectionData);
            
            self._list.append(connectionListItem);
        }
    }
    
    public func getList() -> Array<OTDeserializedConnectionAvailability> {
        return self._list;
    }
}
