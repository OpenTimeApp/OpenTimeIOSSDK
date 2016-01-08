//
//  UpdatePasswordRequest.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 1/8/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

public class OTUpdatePasswordRequest {
    
    private var _password: String;
    private var _confirmPassword: String;
    private var _errorMessage: String;
    
    public init(password: String, confirmPassword: String) {
        self._password        = password;
        self._confirmPassword = confirmPassword;
        self._errorMessage    = "";
    }
    
    public func checkInputs() -> Bool {
        
        if(self._confirmPassword != self._password) {
            self._errorMessage = "Passwords do not match";
            return false;
        }
        
        if(self._password.characters.count < 8) {
            self._errorMessage = "Password must be at least 8 characters long";
            return false;
        }
        
        return true;
    }
    
    public func getErrorMessage() -> String {
        return self._errorMessage;
    }
    
    public func getParameters() -> NSDictionary {
        let password = OTPasswordHelper.encryptPlainTextPassword(self._password);
        return [
            "new_password":password
        ];
    }
}
