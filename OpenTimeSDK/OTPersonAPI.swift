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
public class OTPersonAPI {
    
    /**
        Creates a new user in OpenTime. The same person with different emails should never have more than one user account.
    
        - returns: void
    */
    public static func make(_ personData: OTNewPersonData, done: @escaping (_ response: OTRegisterPersonResponse)->Void)
    {
        let inputsValid = personData.checkInputs();
        
        if(inputsValid.success == false) {
            // Return response.
            done(OTRegisterPersonResponse(success: false, message: inputsValid.message, rawData: nil));
            return;
        }
        
        // Setup query manager.
        let requestManager = OTAPIRequestOperationManager();

        // Run query.
        _ = requestManager.post(OpenTimeSDK.getServer() + "/api/person",
            parameters: personData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!,responseObject: Any) in
                
                // Parse response.
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTRegisterPersonResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTRegisterPersonResponse(success: response.success, message: response.message, rawData: response.rawData!);
                    reply.makeEmpty();
                   done(reply);
                }
                
            }, failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: { (response: OTAPIResponse)->Void in
                    done(OTRegisterPersonResponse(success: response.success, message: response.message, rawData: nil));
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
    public static func signIn(_ signinData: OTSigninRequest, done: @escaping (_ response: OTSigninResponse)->Void) {
        
        // Validate inputs.
        let inputsValid = signinData.checkInputs();
        
        if(inputsValid.success == false) {
            // Return response.
            done(OTSigninResponse(success: inputsValid.success, message: inputsValid.message, rawData: nil));
            return;
        }
        
        // Setup query manager.
        let requestManager = OTAPIRequestOperationManager();
        
        // Run query.
        requestManager.get(OpenTimeSDK.getServer() +  "/api/person/signInWithEmail",
            parameters: signinData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!,responseObject: Any) in
                
                // Parse response.
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    // Build response.
                    if(response.success == true) {
                        // Read person object.
                        done(OTSigninResponse(success: response.success, message: response.message, rawData: response.rawData!));
                    }else{
                        done(OTSigninResponse(success: response.success, message: response.message, rawData: nil));
                    }
                }else{
                    let reply = OTSigninResponse(success: response.success, message: response.message, rawData: nil);
                    reply.makeEmpty();
                    done(reply);
                }
                
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                // Return response.
                requestManager.apiResult(operation, error: error as NSError!, done: { (response: OTAPIResponse)->Void in
                    done(OTSigninResponse(success: response.success, message: response.message, rawData: nil));
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
    public static func updatePassword(_ request: OTUpdatePasswordRequest, done: @escaping (_ response: OTAPIResponse)->Void) {
        
        if(!request.checkInputs()) {
            // Return response.
            done(OTAPIResponse(success: false, message: request.getErrorMessage()));
            return;
        }
        
        // Setup query manager.
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        // Run query.
        _ = requestManager.post(OpenTimeSDK.getServer() +  "/api/person/updatePassword",
            parameters: request.getParameters(),
            success: { (operation: AFHTTPRequestOperation!,responseObject: Any) in
                
                // Parse response.
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response);
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: { (response: OTAPIResponse)->Void in
                    done(response);
                });
            }
        );
    }
}
