//
//  PersonAPI.swift
//  OpenTime
//
//  Created by Josh Woodcock on 2/9/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

/// Communicates with the OpenTime API for Person operations.
public struct PersonAPI {
    
    /**
        Creates a new user in OpenTime. The same person with different emails should never have more than one user account.
    
        - returns: void
    */
    public static func make(personData: NewPersonData, done: (response: RegisterPersonResponse)->Void)
    {
        let inputsValid = personData.checkInputs();
        
        if(inputsValid.success == false) {
            // Return response.
            done(response: RegisterPersonResponse(success: false, message: inputsValid.message, rawData: nil));
            return;
        }
        
        // Setup query manager.
        let requestManager = APIRequestOperationManager();

        // Run query.
        requestManager.POST(OpenTimeSDK.getServer() + "/api/person",
            parameters: personData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                // Parse response.
                let response = APIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: RegisterPersonResponse(success: response.success, message: response.message, rawData: response.rawData));
                
            }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                // Return response.
                requestManager.apiResult(operation, error: error, done: { (response: APIResponse)->Void in
                    done(response: RegisterPersonResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    /**
        Determines whether or not the given email and password combination exists on the server.
    
        - parameter email:    The email the user wants to sign in with.
        - parameter password: The password the user wants to sign in with.
        - parameter done:     The callback method to be called when the server responds.
    
        - returns: void
    */
    public static func signIn(loginData: SigninData, done: (response: SigninResponse)->Void) {
        
        // Validate inputs.
        let inputsValid = loginData.checkInputs();
        
        if(inputsValid.success == false) {
            // Return response.
            done(response: SigninResponse(success: inputsValid.success, message: inputsValid.message, rawData: nil));
            return;
        }
        
        // Setup query manager.
        let requestManager = APIRequestOperationManager();
        
        // Run query.
        requestManager.GET(OpenTimeSDK.getServer() +  "/api/person/signInWithEmail",
            parameters: loginData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                // Parse response.
                let response = APIResponse.loadFromReqeustOperationWithResponse(operation);
                
                // Build response.
                if(response.success == true) {
                    // Read person object.
                    done(response: SigninResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    done(response: SigninResponse(success: response.success, message: response.message, rawData: nil));
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                
                // Return response.
                requestManager.apiResult(operation, error: error, done: { (response: APIResponse)->Void in
                    done(response: SigninResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
}
