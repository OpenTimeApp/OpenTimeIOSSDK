//
//  OTGetMyOrganizationsResponse.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 3/19/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

public class OTGetMyOrganizationsResponse : OTAPIResponse {
    
    private var _organizations: Array<OTDeserializedOrganization>;
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        
        self._organizations = Array<OTDeserializedOrganization>();
        
        super.init(success: success, message: message);
        
        if(success == true && rawData != nil) {
            self._organizations = (OTDeserializationHelper.deserializeList(rawData as! NSArray, type: OTDeserializedOrganization.self) as? Array<OTDeserializedOrganization>)!;
        }
    }
    
    public func getOrganizations() -> Array<OTDeserializedOrganization> {
        return self._organizations;
    }
    
}

