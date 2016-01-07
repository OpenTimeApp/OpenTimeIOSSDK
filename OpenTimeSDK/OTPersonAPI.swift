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
public struct OTPersonAPI {
    
    /**
        Creates a new user in OpenTime. The same person with different emails should never have more than one user account.
    
        - returns: void
    */
    public static func make(personData: OTNewPersonData, done: (response: OTRegisterPersonResponse)->Void)
    {
        let inputsValid = personData.checkInputs();
        
        if(inputsValid.success == false) {
            // Return response.
            done(response: OTRegisterPersonResponse(success: false, message: inputsValid.message, rawData: nil));
            return;
        }
        
        // Setup query manager.
        let requestManager = OTAPIRequestOperationManager();

        // Run query.
        requestManager.POST(OpenTimeSDK.getServer() + "/api/person",
            parameters: personData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                // Parse response.
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: OTRegisterPersonResponse(success: response.success, message: response.message, rawData: response.rawData));
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                
                // Return response.
                requestManager.apiResult(operation, error: error, done: { (response: OTAPIResponse)->Void in
                    done(response: OTRegisterPersonResponse(success: response.success, message: response.message, rawData: nil));
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
    public static func signIn(signinData: OTSigninData, done: (response: OTSigninResponse)->Void) {
        
        // Validate inputs.
        let inputsValid = signinData.checkInputs();
        
        if(inputsValid.success == false) {
            // Return response.
            done(response: OTSigninResponse(success: inputsValid.success, message: inputsValid.message, rawData: nil));
            return;
        }
        
        // Setup query manager.
        let requestManager = OTAPIRequestOperationManager();
        
        // Run query.
        requestManager.GET(OpenTimeSDK.getServer() +  "/api/person/signInWithEmail",
            parameters: signinData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                
                // Parse response.
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                // Build response.
                if(response.success == true) {
                    // Read person object.
                    done(response: OTSigninResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    done(response: OTSigninResponse(success: response.success, message: response.message, rawData: nil));
                }
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                
                // Return response.
                requestManager.apiResult(operation, error: error, done: { (response: OTAPIResponse)->Void in
                    done(response: OTSigninResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
}
