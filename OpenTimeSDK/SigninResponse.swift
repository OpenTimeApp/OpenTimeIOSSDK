//
//  LoginResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit

public class SigninResponse : APIResponse {
    
    private var _person: DeserializedPerson!;
    
    public init(success: Bool, message: String, rawData: AnyObject?) {
        
        if(success == true && rawData != nil) {
            let personDict = rawData!.objectForKey("person") as! NSDictionary;
            self._person   = DeserializedPerson(dictionary: personDict);
        }
        
        super.init(success: success, message: message);
    }
    
    public func getPerson() -> DeserializedPerson {
        return _person;
    }
}
