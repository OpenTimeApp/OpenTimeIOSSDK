//
//  GetAllMyAvailabilityResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class GetAllMyAvailabilityResponse : APIResponse {
    
    private var _oneTimeAvailabilityList: Array<DeserializedOneTimeAvailability>;
    
    public init(success: Bool, message: String, rawData: AnyObject?) {
        
        self._oneTimeAvailabilityList = Array<DeserializedOneTimeAvailability>();
        
        super.init(success: success, message: message);
        
        if(success == true && rawData != nil) {
            
            let oneTimeData: NSArray = rawData!.objectForKey("one_time") as! NSArray;
            
            for var index = 0; index < oneTimeData.count; index++ {
                let element      = oneTimeData.objectAtIndex(index) as! NSDictionary;
                
                let oneTimeAvailability = DeserializedOneTimeAvailability(dictionary: element);
                
                self._oneTimeAvailabilityList.append(oneTimeAvailability);
            }
        }
    }
    
    public func getList() -> Array<DeserializedOneTimeAvailability> {
        return _oneTimeAvailabilityList;
    }
}
