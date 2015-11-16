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
        static let FIRST_NAME  = "first_name";
        static let LAST_NAME   = "last_name";
        static let EMAILS      = "emails";
        static let CELL_PHONES = "cell_phones";
    }
    
    private var _firstName: String;
    private var _lastName: String;
    private var _emails: Array<String>;
    private var _phoneNumbers: Array<String>;
    
    public init(dictionary: NSDictionary){
        self._firstName = dictionary.valueForKey(Keys.FIRST_NAME) as! String;
        self._lastName  = dictionary.valueForKey(Keys.LAST_NAME) as! String;
        self._emails    = (dictionary.valueForKey(Keys.EMAILS) as! NSArray) as! Array<String>;
        self._phoneNumbers = (dictionary.valueForKey(Keys.CELL_PHONES) as! NSArray) as! Array<String>;
    }
    
    public func getFirstName() -> String {
        return self._firstName;
    }
    
    public func getLastName() -> String {
        return self._lastName;
    }
    
    public func getEmails() -> Array<String>{
        return self._emails;
    }
    
    public func getPhones() -> Array<String>{
        return self._phoneNumbers;
    }
}
