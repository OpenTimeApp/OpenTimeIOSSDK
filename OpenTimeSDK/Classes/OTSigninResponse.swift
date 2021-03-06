//
//  OTSigninResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSigninResponse : OTAPIResponse {
    
    private var _person: OTDeserializedPerson!;
    
    public init(success: Bool, message: String, rawData: AnyObject?) {
        
        if(success == true && rawData != nil) {
            let personDict = rawData!.object(forKey: "person") as! NSDictionary;
            self._person   = OTDeserializedPerson(dictionary: personDict);
        }
        
        super.init(success: success, message: message);
    }
    
    public func getPerson() -> OTDeserializedPerson {
        return _person;
    }
}
