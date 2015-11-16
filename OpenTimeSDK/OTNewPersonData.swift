//
//  NewPersonData.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTNewPersonData {
    
    private var _firstName: String;
    private var _lastName: String;
    private var _email:String;
    private var _cellPhone: String;
    private var _password: String;
    private var _confirmPassword: String;
    
    public init(firstName: String, lastName: String, email: String, cellPhone: String, password:String, confirmPassword: String){
        self._firstName       = firstName;
        self._lastName        = lastName;
        self._email           = email;
        self._cellPhone       = cellPhone;
        self._password        = password;
        self._confirmPassword = confirmPassword;
    }
    
    public func getParameters() -> NSDictionary {
        let encryptedPW = OTPasswordHelper.encryptPlainTextPassword(self._password);
        
        let validFirstName = OTStringHelper.ucFirst(self._firstName);
        let validLastName  = OTStringHelper.ucFirst(self._lastName);
        let validPhone     = OTPhoneHelper.format(self._cellPhone);
        
        let parameters = [
            "email":self._email,
            "first_name":validFirstName,
            "last_name":validLastName,
            "password":encryptedPW,
            "cell_phone": validPhone
        ];
        
        return parameters;
    }
    
    public func checkInputs() -> OTAPIResponse {
        
        let validFirstName = OTStringHelper.ucFirst(self._firstName);
        let validLastName  = OTStringHelper.ucFirst(self._lastName);
        let validPhone     = OTPhoneHelper.format(self._cellPhone);
        
        let response = OTPersonValidationHelper.createUserInputsValid(_email, phoneNumber: validPhone, firstName: validFirstName, lastName: validLastName, password: _password, confirmPassword: _confirmPassword);
        
        return response;
    }
    
    public func getEmail() -> String {
        return _email;
    }
    
    public func getPassword() -> String {
        return _password;
    }
    
    public func getFirstName() -> String {
        return self._firstName;
    }
    
    public func getLastName() -> String {
        return self._lastName;
    }
    
    public func getPhone() -> String {
        return self._cellPhone;
    }
    
}