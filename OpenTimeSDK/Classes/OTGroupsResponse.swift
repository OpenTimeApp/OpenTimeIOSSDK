//
//  OTGroupsResponse.swift
//  Pods
//
//  Created by Josh Woodcock on 2/26/17.
//
//

public class OTGroupsResponse : OTAPIResponse {
    
    private var _groups: Array<OTDeserializedGroup>;
    
    public init(success: Bool, message: String, rawData: AnyObject?){
        
        self._groups = Array<OTDeserializedGroup>();
        
        super.init(success: success, message: message);
        
        if(rawData != nil){
            self._groups = OTDeserializationHelper.deserializeList(rawData as! NSArray, type: OTDeserializedGroup.self) as! Array<OTDeserializedGroup>;
        }else{
            self._groups = Array<OTDeserializedGroup>();
        }
    }

    public func getGroups() -> Array<OTDeserializedGroup> {
        return _groups;
    }
    
}

