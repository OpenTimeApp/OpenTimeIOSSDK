//
//  ContactInfo.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class ContactInfoData {
    
    private var _emails: Array<String>!;
    private var _cellPhones: Array<String>!;
    
    public init(emails: Array<String>?, cellPhones: Array<String>?) {
        self._emails     = emails!;
        self._cellPhones = cellPhones!;
    }
    
    public func getEmails() -> Array<String> {
        
        if(self._emails != nil) {
            return _emails;
        }else{
            return [];
        }
    }
    
    public func getCellPhones() -> Array<String> {
        if(self._cellPhones != nil) {
            return self._cellPhones;
        }else{
            return [];
        }
    }
}