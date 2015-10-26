//
//  OTDeserializedPerson.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit

public class OTDeserializedPerson {
    
    private struct Keys {
        static let FIRST_NAME = "first_name";
        static let LAST_NAME  = "last_name";
    }
    
    private var _firstName: String;
    private var _lastName: String;
    
    public init(dictionary: NSDictionary){
        _firstName = dictionary.valueForKey(Keys.FIRST_NAME) as! String;
        _lastName  = dictionary.valueForKey(Keys.LAST_NAME) as! String;
    }
    
    public func getFirstName() -> String {
        return self._firstName;
    }
    
    public func getLastName() -> String {
        return self._lastName;
    }
    
}
