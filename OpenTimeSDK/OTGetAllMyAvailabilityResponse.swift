//
//  GetAllMyAvailabilityResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTGetAllMyAvailabilityResponse : OTAPIResponse {
    
    private var _availability: OTDeserializedAvailability?;
    
    public init(success: Bool, message: String, rawData: AnyObject?) {
        
        super.init(success: success, message: message);
        
        if(success == true && rawData != nil) {
            self._availability = OTDeserializedAvailability(dictionary: rawData as! NSDictionary);
        }
    }
    
    public func getAvailability() -> OTDeserializedAvailability {
        return self._availability!;
    }
}
