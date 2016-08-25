//
//  RegisterPersonResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit

public class OTRegisterPersonResponse : OTAPIResponse {
    
    private var _registeredPersonData: OTDeserializedRegisteredPersonData?;
    
    public init(success: Bool, message: String, rawData: AnyObject?) {
        if(success == true && rawData != nil) {
            self._registeredPersonData = OTDeserializedRegisteredPersonData(dictionary: rawData as! NSDictionary);
        }
        
        super.init(success: success, message: message);
    }
    
    public func getPerson() -> OTDeserializedRegisteredPersonData? {
        return self._registeredPersonData;
    }
}
