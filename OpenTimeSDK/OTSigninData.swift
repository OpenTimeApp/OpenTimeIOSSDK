//
//  LoginData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTSigninData {
    
    private var _email: String;
    private var _password: String;
    
    public init(email: String, password: String){
        self._email    = email;
        self._password = password;
    }
    
    public func checkInputs() -> OTAPIResponse {
        return OTPersonValidationHelper.signInInputsValid(self._email, password: self._password);
    }
    
    public func getParameters() -> NSDictionary {
        // Setup query parameters.
        let encryptedPW = OTPasswordHelper.encryptPlainTextPassword(self._password)
        
        let parameters = [
            "email":self._email,
            "password":encryptedPW
        ];
        
        return parameters;
    }
}
