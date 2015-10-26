//
//  RegisterPersonResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit

public class OTRegisterPersonResponse : OTAPIResponse {
    
    private var _person: OTDeserializedPerson!;
    
    public init(success: Bool, message: String, rawData: AnyObject?) {
        if(success == true && rawData != nil) {
            self._person = OTDeserializedPerson(dictionary: rawData as! NSDictionary);
        }
        
        super.init(success: success, message: message);
    }
    
    public func getPerson() -> OTDeserializedPerson {
        return self._person;
    }
}
