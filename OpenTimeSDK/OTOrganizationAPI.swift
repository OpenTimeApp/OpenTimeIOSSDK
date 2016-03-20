//
//  OTOrganizationAPI.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 3/19/16.
//  Copyright © 2016 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

public class OTOrganizationAPI {
    
    public static func getMyOrganizations(done: (response: OTGetMyOrganizationsResponse)->Void){
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.GET(OpenTimeSDK.getServer() + "/api/person/organizations",
            parameters: [],
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                done(response: OTGetMyOrganizationsResponse(success: response.success, message: response.message, rawData: response.rawData!));
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTGetMyOrganizationsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        )
        
    }
    
}
