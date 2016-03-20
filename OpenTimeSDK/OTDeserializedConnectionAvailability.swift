//
//  OTDeserializedConnectionAvailability.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedConnectionAvailability : OTDeserializer{
    
    private struct Keys {
        static let USER_ID               = "user_id";
        static let AVAILABILITY          = "availability";
    }
    
    private var _userID: OpenTimeUserID;
    private var _availability: OTDeserializedAvailability;
    
    public required init(dictionary: NSDictionary){
    
        let availabilityData: NSDictionary = dictionary.objectForKey(Keys.AVAILABILITY) as! NSDictionary;
        self._userID  = dictionary.objectForKey(Keys.USER_ID) as! Int;
        
        self._availability = OTDeserializedAvailability(dictionary: availabilityData);
    }
    
    public func getAvailability() -> OTDeserializedAvailability {
        return self._availability;
    }
    
    public func getUserID() -> OpenTimeUserID {
        return self._userID;
    }
}
