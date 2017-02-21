//
//  PersonValidationHelper.swift
//  OpenTime
//
//  Created by Josh Woodcock on 10/23/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OTPersonValidationHelper {
    
    private init() {}
    
    public static var PASSWORD_MIN_LEN: Int = 8;
    
    /**
    Determines whether or not the given sign in credentials are valid.
    
    - parameter email:    The email the user is trying to sign in with.
    - parameter password: The password the user is trying to sign in with.
    
    - returns: OTAPIResponse with message explaining failure reason.
    */
    public static func signInInputsValid(_ email: String, password: String)->OTAPIResponse
    {
        // Validate email.
        let validEmail = self._validEmail(email);
        if(validEmail.success == false)
        {
            // Return failed result.
            return validEmail;
        }
        
        // Validate password.
        let validPassword = self._validPassword(password, confirmPassword: password);
        if(validPassword.success == false)
        {
            // Return failed result.
            return validPassword;
        }
        
        // Return successful result.
        return OTAPIResponse(success: true, message: "");
    }
    
    /**
    Determines if the inputs used for creating a new uesr account are valid.
    
    - parameter email:           The email to be validated.
    - parameter firstName:       The first name of the person to be validated.
    - parameter lastName:        The last name of the person to be validated.
    - parameter password:        The password the user wants to sign up with.
    - parameter confirmPassword: The confirmation password to check the password against.
    
    - returns: OTAPIResponse with message explaining failure reason.
    */
    public static func createUserInputsValid(_ email: String, phoneNumber: String, firstName: String, lastName: String, password: String, confirmPassword: String)->OTAPIResponse
    {
        // Validate email.
        let validEmail = self._validEmail(email);
        if(validEmail.success == false)
        {
            // Return failed result.
            return validEmail;
        }
        
        // Validate phone.
        let validPhone = self._validPhone(phoneNumber);
        if(validPhone.success == false) {
            return validPhone;
        }
        
        // Validate name.
        let validName = self._validName(firstName, lastName: lastName);
        if(validName.success == false)
        {
            // Return failed result.
            return validName;
        }
        
        // Validate password.
        let validPassword = self._validPassword(password, confirmPassword: confirmPassword);
        if(validPassword.success == false)
        {
            // Return failed result.
            return validPassword;
        }
        
        // Return successful result.
        return OTAPIResponse(success: true, message: "");
    }
    
    private static func _validPhone(_ phone: String) -> OTAPIResponse {
        
        if(phone == "") {
            return OTAPIResponse(success: false, message: "Phone number cannot be blank");
        }
        
        
        
        return OTAPIResponse(success: true, message: "");
    }
    
    /**
    Determines if an email is a valid email.
    
    - parameter email: The email to be validated.
    
    - returns: OTAPIResponse with message explaining failure reason.
    */
    private static func _validEmail(_ email: String)->OTAPIResponse
    {
        // Verify email isn't blank.
        if(email == "")
        {
            // Return failed result.
            return OTAPIResponse(success: false, message: NSLocalizedString("message_email_cannot_be_blank", comment: ""));
        }
        
        // Verify email is a property formated email. Example: someone@domain.com.
        if(OTStringHelper.isValidEmail(email) == false)
        {
            // Return failed result.
            return OTAPIResponse(success: false, message: NSLocalizedString("message_invalid_email", comment: ""));
        }
        
        // Return successful result.
        return OTAPIResponse(success: true, message: "");
    }
    
    /**
    Determines if a first and last name is valid.
    
    - parameter firstName: The first name of the person's name to be validated.
    - parameter lastName:  The last name of the person's name to be validated.
    
    - returns: OTAPIResponse with message explaining failure reason.
    */
    private static func _validName(_ firstName: String, lastName: String)->OTAPIResponse
    {
        // Verify the first name is not blank.
        if(firstName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "")
        {
            // Return failed result.
            return OTAPIResponse(success: false, message: NSLocalizedString("message_first_name_cannot_be_blank", comment: ""));
        }
        
        // Verify the last name is not blank.
        if(lastName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "")
        {
            // Return failed result.
            return OTAPIResponse(success: false, message: NSLocalizedString("message_last_name_cannot_be_blank", comment: ""));
        }
        
        // Return successful result.
        return OTAPIResponse(success: true, message: "");
    }
    
    /**
    Determines if a password meets the password requirements.
    
    - parameter password:        The password to validate.
    - parameter confirmPassword: A confirmation to check the password against.
    
    - returns: OTAPIResponse with message explaining failure reason.
    */
    private static func _validPassword(_ password: String, confirmPassword: String)->OTAPIResponse
    {
        // Verify the password is at least 8 characters long.
        if(password.characters.count < self.PASSWORD_MIN_LEN)
        {
            var message = NSLocalizedString("message_min_password_len_not_met", comment: "");
            
            message = String.localizedStringWithFormat(message, self.PASSWORD_MIN_LEN);
            
            // Return failed result.
            return OTAPIResponse(success: false, message: message);
        }
        
        // Verify the password and the confirmed password match.
        if(password != confirmPassword)
        {
            // Return failed result.
            return OTAPIResponse(success: false, message: NSLocalizedString("message_passwords_dont_match", comment: ""));
        }
        
        // Return successful result.
        return OTAPIResponse(success: true, message: "");
    }
}
