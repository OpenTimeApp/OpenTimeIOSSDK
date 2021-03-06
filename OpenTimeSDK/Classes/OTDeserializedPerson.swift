//
//  OTDeserializedPerson.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTDeserializedPerson : OTDeserializer {
    
    private struct Keys {
        static let USER_ID     = "user_id";
        static let FIRST_NAME  = "first_name";
        static let LAST_NAME   = "last_name";
        static let EMAILS      = "emails";
        static let CELL_PHONES = "cell_phones";
    }
    
    private var _userID: OpenTimeUserID;
    private var _firstName: String;
    private var _lastName: String;
    private var _emails: Array<String>;
    private var _phoneNumbers: Array<String>;
    
    public required init(dictionary: NSDictionary){
        self._userID    = dictionary.value(forKey: Keys.USER_ID) as! OpenTimeUserID;
        self._firstName = dictionary.value(forKey: Keys.FIRST_NAME) as! String;
        self._lastName  = dictionary.value(forKey: Keys.LAST_NAME) as! String;
        self._emails    = (dictionary.value(forKey: Keys.EMAILS) as! NSArray) as! Array<String>;
        
        self._phoneNumbers = Array<String>();
        
        self._setCellPhones(dictionary);
    }
    
    private func _setCellPhones(_ dictionary: NSDictionary) {
        let phoneNumbersNSArray = dictionary.value(forKey: Keys.CELL_PHONES) as! NSArray;
        var phoneNumbers = Array<String>();
        
        for phoneNumberRaw in phoneNumbersNSArray {
            phoneNumbers.append(String(describing: phoneNumberRaw))
        }
        
        self._phoneNumbers = phoneNumbers;
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
    
    public func getUserID() -> OpenTimeUserID {
        return self._userID;
    }
}
