//
//  OTStringHelper.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 10/25/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTStringHelper {
    
    public static func isValidEmail(_ email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate! = NSPredicate(format:"SELF MATCHES %@", emailRegEx);
        
        if(emailTest != nil)
        {
            return emailTest.evaluate(with: email)
        }
        
        return false
    }
    
    public static func ucFirst(_ text: String)->String
    {
        if(text.characters.count > 0) {
            let myText = text.lowercased();
            let firstLetter = text.substring(to: myText.characters.index(myText.startIndex, offsetBy: 1));
            let firstCharRange = (myText.startIndex ..< myText.characters.index(myText.startIndex, offsetBy: 1));
            let finalText = text.replacingCharacters(in: firstCharRange, with: firstLetter.uppercased());
            return finalText;
        }else{
            return text;
        }
    }
}
