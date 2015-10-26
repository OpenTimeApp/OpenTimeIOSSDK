//
//  OTDeserializedConnectionAvailability.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedConnectionAvailability{
    
    private var _oneTime: Array<OTDeserializedOneTimeAvailability>;
    private var _userID: OpenTimeUserID;
    
    public init(dictionary: NSDictionary){
    
        let availabilityData: NSDictionary = dictionary.objectForKey("availability") as! NSDictionary;
        let oneTimeData: NSArray = availabilityData.objectForKey("one_time") as! NSArray;
        
        self._oneTime = Array<OTDeserializedOneTimeAvailability>();
        self._userID  = dictionary.objectForKey("user_id") as! Int;
        
        for var availabilityIndex = 0; availabilityIndex < oneTimeData.count; availabilityIndex++ {
            let element = oneTimeData.objectAtIndex(availabilityIndex) as! NSDictionary;
            let oneTimeAvailability = OTDeserializedOneTimeAvailability(dictionary: element);
            self._oneTime.append(oneTimeAvailability);
        }
    }
}
