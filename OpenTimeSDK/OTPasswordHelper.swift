//
//  PasswordHelper.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 10/25/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTPasswordHelper {
    
    private static let PASSWORD_FOR_SDK_WAS_FIXED = "PASSWORD_FOR_SDK_WAS_FIXED";
    
    public static func encryptPlainTextPassword(password: String)->String
    {
        // Double hash with salt so that the text stored in the ios database used to authenticate when a user opens the app isn't the same one being sent to the server.
        let hash1 = self._encryptString(password);
        let hash2 = self.encryptHashedPassword(hash1);
        
        return hash2;
    }
    
    private static func _encryptString(text: String)->String {
        
        let mash = OTConstant.SALT_1 + text;
        let hash = self._passwordWasFixed() ? mash.md5Fixed() : mash.md5Broken();
        
        return hash;
    }
    
    public static func encryptHashedPassword(password: String)->String
    {
        let mash = OTConstant.SALT_2 + password;
        let hash = self._passwordWasFixed() ? mash.md5Fixed() : mash.md5Broken();
        
        return hash;
    }
    
    private static func _passwordWasFixed() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(OTPasswordHelper.PASSWORD_FOR_SDK_WAS_FIXED);
    }
    
    public static func flagPasswordWasFixed(flag: Bool) {
        NSUserDefaults.standardUserDefaults().setBool(flag, forKey: OTPasswordHelper.PASSWORD_FOR_SDK_WAS_FIXED);
    }
}
