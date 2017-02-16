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
    
    public static func getMyOrganizations(_ done: @escaping (_ response: OTGetMyOrganizationsResponse)->Void){
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.get(OpenTimeSDK.getServer() + "/api/person/organizations",
            parameters: [],
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) -> Void in
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTGetMyOrganizationsResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTGetMyOrganizationsResponse(success: false, message: "", rawData:nil);
                    reply.makeEmpty();
                    done(reply);
                }
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: Error) -> Void in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTGetMyOrganizationsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        )
        
    }
    
}
