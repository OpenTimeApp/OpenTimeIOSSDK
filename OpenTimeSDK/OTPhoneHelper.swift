//
//  OTPhoneHelper.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 10/25/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

import Foundation
import libPhoneNumber_iOS

public class OTPhoneHelper {
    
    private static let _phoneUtil = NBPhoneNumberUtil();
    
    private static func _getCountry() -> String {
        let countryCode: String = NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
        return countryCode;
    }
    
    /**
    Formats the phone with the OpenTime standard international phone format +### ### #########
    If the phone number is not a valid phone number the phone will not be formatted.
    
    - returns: A formatted phone for valid phone numbers.
    */
    public static func format(phone: String) -> String
    {
        if(phone == "") {
            return "";
        }
        
        let country = self._getCountry();
        
        if(self._phoneUtil.isViablePhoneNumber(phone))  {
            
            var error: NSError? = nil;
            var number: NBPhoneNumber!
            do {
                number = try _phoneUtil.parse(phone, defaultRegion: country)
            } catch let error1 as NSError {
                error = error1
                number = nil
            };
            
            if(error != nil || number == nil) {
                return "";
            }
            
            var defaultFormatted: String!
            do {
                defaultFormatted = try _phoneUtil.format(number, numberFormat: NBEPhoneNumberFormat.INTERNATIONAL)
            } catch let error1 as NSError {
                error = error1
                defaultFormatted = nil
            };
            
            if(error != nil || defaultFormatted == nil || defaultFormatted == "") {
                return "";
            }
            
            if((defaultFormatted as NSString).rangeOfString("-").location == NSNotFound) {
                return defaultFormatted;
            }
            
            var formatted = self._replaceFirst("-", replaceWith: " ", subject: defaultFormatted);
            
            if((defaultFormatted as NSString).rangeOfString("-").location == NSNotFound) {
                return formatted;
            }
            
            formatted = self._replace("-", replaceWith: "", subject: formatted);
            
            number = nil;
            
            return formatted;
        }else{
            return phone;
        }
    }
    
    public static func isSearchable(phone: String) -> Bool {
        
        let isSearchable = self._phoneUtil.isViablePhoneNumber(phone);
        
        return isSearchable;
    }
    
    public static func getDialable(phoneNumber: String) -> String {
        let badChars    = NSCharacterSet(charactersInString: "0123456789-+()");
        let goodChars   = badChars.invertedSet;
        let expandPhone = phoneNumber.componentsSeparatedByCharactersInSet(goodChars);
        let cleanPhone  = expandPhone.joinWithSeparator("");
        
        return cleanPhone;
    }
    
    private static func _replaceFirst(find: String, replaceWith: Character, subject: String) -> String {
        
        if(subject != "") {
            var explode = subject.componentsSeparatedByString(find);
            
            var joined = "";
            if(explode.count >= 2) {
                joined = explode[0] + String(replaceWith) + explode[1];
                
                for(var i = 2; i < explode.count; i++) {
                    joined += explode[i];
                }
                return joined;
            }else{
                return subject;
            }
        }else{
            return "";
        }
    }
    
    private static func _replace(find: String, replaceWith: String, subject: String)->String
    {
        let myDictionary = [find:replaceWith];
        var newString = subject;
        for (originalWord, newWord) in myDictionary {
            newString = newString.stringByReplacingOccurrencesOfString(originalWord, withString:newWord, options: NSStringCompareOptions.LiteralSearch, range: nil)
        }
        
        return newString;
    }
    
    public static func isValid(phone: String) -> Bool {
        if(self._phoneUtil.isViablePhoneNumber(phone)) {
            let country = self._getCountry();
            var number: NBPhoneNumber!
            number = try! self._phoneUtil.parse(phone, defaultRegion: country);
            
            if(self._phoneUtil.isValidNumberForRegion(number, regionCode: country)) {
                number = nil;
                return true;
            }else{
                number = nil;
                return false;
            }
        }else{
            return false;
        }
    }

}