//
//  ConnectionAPI.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/9/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTConnectionAPI {
   
    public static func set(connectionData: OTSetConnectionData, done: @escaping (_ response: OTSetConnectionResponse)->Void)
    {
        // Setup request manager.
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        // Validate inputs.
        if(connectionData.getUserID() == OpenTimeSDK.session.getUserID()) {
            fatalError("User cannot be a connection to themselves");
        }

        // Run query.
        _ = requestManager.put(OpenTimeSDK.getServer() + "/api/connection/" + String(connectionData.getUserID()),
            parameters: connectionData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTSetConnectionResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    done(OTSetConnectionResponse(success: response.success, message: response.message, rawData: nil));
                }
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTSetConnectionResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public static func remove(_ id: Int, lastUpdated: Int, done: @escaping (_ response: OTAPIResponse)->Void) -> Void
    {
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        // Setup request arguments
        let parameters = [
            "last_updated": lastUpdated,
        ];
        
        _ = requestManager.delete(
            OpenTimeSDK.getServer() + "/api/connection/" + String(id),
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation, error: Any) in
            requestManager.apiResult(operation, error: nil, done: done);
        }) { (operation: AFHTTPRequestOperation?, error: Error) in
            requestManager.apiResult(operation, error: error as NSError!, done: done);
        }
    }
    
    public static func getAll(_ done: @escaping (_ response: OTConnectionsResponse)->Void) -> Void
    {
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(1);
        
        // Start the request
        requestManager.get(OpenTimeSDK.getServer() + "/api/connection/all",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTConnectionsResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTConnectionsResponse(success: false, message: "", rawData: nil);
                    reply.makeEmpty();
                    done(reply)
                }
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTConnectionsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public static func getWithContactInfo(_ data: OTGetConnectionsWithContactInfoData, done: @escaping (_ response:OTConnectionsResponse)->Void)
    {
        
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(3);
        requestManager.setClearCacheForPostAndPut(false);
        
        // Start the request
        _ = requestManager.post(OpenTimeSDK.getServer() + "/api/connection/withContactInfoList",
            parameters: data.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                   done(OTConnectionsResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTConnectionsResponse(success: false, message: "", rawData: nil);
                    reply.makeEmpty();
                    done(reply)
                }
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTConnectionsResponse(success: response.success, message: response.message, rawData: nil))
                });
            }
        );
    }
    
    public static func getList(_ list: Array<Int>, done: @escaping (_ response: OTConnectionsResponse)->Void)
    {
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        // Setup request argument values
        var stringList = Array<String>();
        for item in list {
            stringList.append(String(item));
        }
        let joinedList = stringList.joined(separator: ",");
        
        // Build parameter list.
        let parameters = [
            "list":  joinedList,
        ];
        
        // Start the request
        _ = requestManager.get(OpenTimeSDK.getServer() + "/api/connection/withList",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: Any) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                if(response.rawData != nil){
                    done(OTConnectionsResponse(success: response.success, message: response.message, rawData: response.rawData!));
                }else{
                    let reply = OTConnectionsResponse(success: false, message: "", rawData: nil);
                    reply.makeEmpty();
                    done(reply)
                }
            },
            failure: { (operation: AFHTTPRequestOperation?, error: Error) in
                requestManager.apiResult(operation, error: error as NSError!, done: {(response: OTAPIResponse)->Void in
                    done(OTConnectionsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }

}
