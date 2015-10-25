//
//  RegisterPersonResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit

public class RegisterPersonResponse : APIResponse {
    
    private var _person: DeserializedPerson!;
    
    public init(success: Bool, message: String, rawData: AnyObject?) {
        if(success == true && rawData != nil) {
            self._person = DeserializedPerson(dictionary: rawData as! NSDictionary);
        }
        
        super.init(success: success, message: message);
    }
    
    public func getPerson() -> DeserializedPerson {
        return self._person;
    }
}
