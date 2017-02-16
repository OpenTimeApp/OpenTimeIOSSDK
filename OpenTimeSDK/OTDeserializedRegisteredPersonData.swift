//
//  OTDeserializedRegisteredPersonData.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 11/16/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedRegisteredPersonData : OTDeserializer {
    
    private struct Keys {
        static let USER_ID = "user_id";
    }
    
    private var _userID: OpenTimeUserID;
    
    public required init(dictionary: NSDictionary){
        self._userID = dictionary.value(forKey: Keys.USER_ID) as! OpenTimeUserID;
    }
    
    public func getUserID() -> OpenTimeUserID {
        return self._userID;
    }
}
