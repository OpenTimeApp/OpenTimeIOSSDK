//
//  ConnectionAPI.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/9/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTConnectionAPI {
   
    public class func set(connectionData: OTSetConnectionData, done: (response: OTSetConnectionResponse)->Void)
    {
        // Setup request manager.
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        // Validate inputs.
        if(connectionData.getUserID() == OpenTimeSDK.session.getUserID()) {
            fatalError("User cannot be a connection to themselves");
        }

        // Run query.
        requestManager.PUT(OpenTimeSDK.getServer() + "/api/connection/" + String(connectionData.getUserID()),
            parameters: connectionData.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                requestManager.apiResult(operation, error: nil, done: {(response: OTAPIResponse)->Void in
                    
                    if(response.success && response.rawData != nil){
                        let connectionData = OTDeserializedConnection(dictionary: response.rawData as! NSDictionary);
                        done(response: OTSetConnectionResponse(success: response.success, message: response.message, connectionData: connectionData));
                    }else{
                        done(response: OTSetConnectionResponse(success: response.success, message: response.message, connectionData: nil))
                    }
                });
            },
            
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTSetConnectionResponse(success: response.success, message: response.message, connectionData: nil));
                });
            }
        );
    }
    
    public class func remove(id: Int, lastUpdated: Int, done: (response: OTAPIResponse)->Void)
    {
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        // Setup request arguments
        let parameters = [
            "last_updated": lastUpdated,
        ];
        
        // Start the request
        requestManager.DELETE(OpenTimeSDK.getServer() + "/api/connection/" + String(id),
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                requestManager.apiResult(operation, error: nil, done: done);
            },
            failure: { (operation: AFHTTPRequestOperation?,error: NSError) in
                requestManager.apiResult(operation, error: error, done: done);
            }
        );
    }
    
    public class func getAll(done: (response: OTConnectionsResponse)->Void)
    {
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(1);
        
        // Start the request
        requestManager.GET(OpenTimeSDK.getServer() + "/api/connection/all",
            parameters: [String:AnyObject](),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: OTConnectionsResponse(success: response.success, message: response.message, rawData: response.rawData!));
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTConnectionsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }
    
    public class func getWithContactInfo(data: OTGetConnectionsWithContactInfoData, done: (response:OTConnectionsResponse)->Void)
    {
        
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        requestManager.setCacheMaxAge(3);
        requestManager.setClearCacheForPostAndPut(false);
        
        // Start the request
        requestManager.POST(OpenTimeSDK.getServer() + "/api/connection/withContactInfoList",
            parameters: data.getParameters(),
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: OTConnectionsResponse(success: response.success, message: response.message, rawData: response.rawData!));
                
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTConnectionsResponse(success: response.success, message: response.message, rawData: nil))
                });
            }
        );
    }
    
    public class func getList(list: Array<Int>, done: (response: OTConnectionsResponse)->Void)
    {
        // Setup request manager
        let requestManager = OTAPIAuthorizedRequestOperationManager();
        
        // Setup request argument values
        var stringList = Array<String>();
        for item in list {
            stringList.append(String(item));
        }
        let joinedList = stringList.joinWithSeparator(",");
        
        // Build parameter list.
        let parameters = [
            "list":  joinedList,
        ];
        
        // Start the request
        requestManager.GET(OpenTimeSDK.getServer() + "/api/connection/withList",
            parameters: parameters,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                
                let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
                
                done(response: OTConnectionsResponse(success: response.success, message: response.message, rawData: response.rawData!));
            },
            failure: { (operation: AFHTTPRequestOperation?, error: NSError) in
                requestManager.apiResult(operation, error: error, done: {(response: OTAPIResponse)->Void in
                    done(response: OTConnectionsResponse(success: response.success, message: response.message, rawData: nil));
                });
            }
        );
    }

}
