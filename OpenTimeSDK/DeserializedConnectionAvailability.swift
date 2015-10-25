//
//  DeserializedConnectionAvailability.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class DeserializedConnectionAvailability{
    
    private var _oneTime: Array<DeserializedOneTimeAvailability>;
    private var _userID: OpenTimeUserID;
    
    public init(dictionary: NSDictionary){
    
        let availabilityData: NSDictionary = dictionary.objectForKey("availability") as! NSDictionary;
        let oneTimeData: NSArray = availabilityData.objectForKey("one_time") as! NSArray;
        
        self._oneTime = Array<DeserializedOneTimeAvailability>();
        self._userID  = dictionary.objectForKey("user_id") as! Int;
        
        for var availabilityIndex = 0; availabilityIndex < oneTimeData.count; availabilityIndex++ {
            let element = oneTimeData.objectAtIndex(availabilityIndex) as! NSDictionary;
            let oneTimeAvailability = DeserializedOneTimeAvailability(dictionary: element);
            self._oneTime.append(oneTimeAvailability);
        }
    }
}
