//
//  OTStringHelper.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 10/25/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTStringHelper {
    
    public class func isValidEmail(email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate! = NSPredicate(format:"SELF MATCHES %@", emailRegEx);
        
        if(emailTest != nil)
        {
            return emailTest.evaluateWithObject(email)
        }
        
        return false
    }
    
    public class func ucFirst(text: String)->String
    {
        if(text.characters.count > 0) {
            let myText = text.lowercaseString;
            let firstLetter = text.substringToIndex(myText.startIndex.advancedBy(1));
            let firstCharRange = Range<String.Index>(start: myText.startIndex, end: myText.startIndex.advancedBy(1));
            let finalText = text.stringByReplacingCharactersInRange(firstCharRange, withString: firstLetter.uppercaseString);
            return finalText;
        }else{
            return text;
        }
    }
}
