//
//  APIRequestOperationManager.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/7/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

// Global var says whether or not caching is allowed.
var enableCache = true;

public class APIRequestOperationManager: AFHTTPRequestOperationManager {
   
    private var _maxCacheAgeInSeconds: Int = 0;
    private var _useCache = false;
    private var _clearCacheForPostAndPut = true;
    
    public class func disableCache()
    {
        enableCache = false;
    }
    
    required public init()
    {
        super.init(baseURL: nil);

        self.setupHeaders();
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
    }
    
    public func setCacheMaxAge(inMinutes: Double)
    {
        self._maxCacheAgeInSeconds = Int(inMinutes * 60);
        // If caching is allowed the enable caching.
        if(enableCache == true)
        {
            self._useCache = true;
        }
    }
    
    public func setClearCacheForPostAndPut(clearCache: Bool) {
        self._clearCacheForPostAndPut = clearCache;
    }
    
    public override func HTTPRequestOperationWithRequest(request: NSURLRequest, success: ((AFHTTPRequestOperation, AnyObject) -> Void)?, failure: ((AFHTTPRequestOperation, NSError) -> Void)?) -> AFHTTPRequestOperation {
        
        
        let modifiedRequest: NSMutableURLRequest = request.mutableCopy() as! NSMutableURLRequest;
        let reachability: AFNetworkReachabilityManager = self.reachabilityManager;
        if(reachability.reachable == false)
        {
            if(Reachability.shouldForceCacheUse()) {
                modifiedRequest.cachePolicy = NSURLRequestCachePolicy.ReturnCacheDataDontLoad;
            }else{
                modifiedRequest.cachePolicy = NSURLRequestCachePolicy.UseProtocolCachePolicy;
            }
        }else if(self._useCache == false){
            modifiedRequest.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData;
        }else{
            modifiedRequest.cachePolicy = NSURLRequestCachePolicy.ReloadRevalidatingCacheData;
        }
        
        let operation = super.HTTPRequestOperationWithRequest(modifiedRequest, success: success, failure: failure);
        
        if(self._useCache)
        {
            operation.setCacheResponseBlock({ (connection: NSURLConnection!, cachedResponse: NSCachedURLResponse!) -> NSCachedURLResponse in
                let response:NSURLResponse         = cachedResponse.response;
                let httpResponse:NSHTTPURLResponse = response as! NSHTTPURLResponse;
                let headers:NSDictionary           = httpResponse.allHeaderFields;
                
                var modifiedHeaders:[String : String] =  headers.mutableCopy() as! [String : String];
                
                modifiedHeaders["Cache-Control"] = "private, max-age="+String(self._maxCacheAgeInSeconds);
                
                let modifiedHttpResponse: NSHTTPURLResponse = NSHTTPURLResponse(
                    URL: httpResponse.URL!,
                    statusCode: httpResponse.statusCode,
                    HTTPVersion: "HTTP/1.1", headerFields: modifiedHeaders)!;
                
                //var modifiedHttpResponse:NSHTTPURLResponse = NSHTTPURLResponse(URL: httpResponse.URL!, statusCode: httpResponse.statusCode, HTTPVersion: "HTTP/1.1", headerFields: modifiedHeaders as [NSObject : AnyObject])!;
                
                let proposedResponse:NSCachedURLResponse = NSCachedURLResponse(
                    response: modifiedHttpResponse,
                    data: cachedResponse.data,
                    userInfo: cachedResponse.userInfo,
                    storagePolicy: NSURLCacheStoragePolicy.AllowedInMemoryOnly);
                
                return proposedResponse;
            });
        }
        
        return operation;
    }
    
    public override func POST(URLString: String, parameters: AnyObject!, success: ((AFHTTPRequestOperation!, AnyObject!) -> Void)!, failure: ((AFHTTPRequestOperation!, NSError!) -> Void)!) -> AFHTTPRequestOperation? {
        
        self.requestSerializer = AFJSONRequestSerializer();
        self.setupHeaders();
        let mySuccess = success;
        
        return super.POST(URLString, parameters: parameters, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            
            mySuccess(operation, responseObject);
            
            if(self._clearCacheForPostAndPut) {
                // Clear cache for POST requests because the cache data will be out of date after the server is updated.
                // When the RAM cache is out is out of date it causes sync operations to continuously re-submit updates.
                // Continuously re-submitting updates will cause write-locks to the database... hypothetically it will waste write resources.
                NSURLCache.sharedURLCache().removeAllCachedResponses();
            }
        }, failure: failure);
    }
    
    public override func PUT(URLString: String, parameters: AnyObject!, success: ((AFHTTPRequestOperation!, AnyObject!) -> Void)!, failure: ((AFHTTPRequestOperation!, NSError!) -> Void)!) -> AFHTTPRequestOperation? {
        
        self.requestSerializer = AFJSONRequestSerializer();
        self.setupHeaders();
        let mySuccess = success;

        return super.PUT(URLString, parameters: parameters, success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            
            mySuccess(operation, responseObject);
            
            if(self._clearCacheForPostAndPut) {
                /*
                Clear cache for POST requests because the cache data will be out of date after the server is updated.
                When the RAM cache is out is out of date it causes sync operations to continuously re-submit updates.
                Continuously re-submitting updates will cause write-locks to the database... hypothetically it will waste write resources.
                */
                NSURLCache.sharedURLCache().removeAllCachedResponses();
            }
            
        }, failure: failure);
    }
    
    public func setupHeaders()
    {
        self.requestSerializer.setValue(OpenTimeSDK.getKey(), forHTTPHeaderField: OTConstant.API_KEY_NAME);
        self.requestSerializer.setValue(OTConstant.API_VERSION, forHTTPHeaderField: "V");
        self.requestSerializer.setValue(NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode) as? String, forHTTPHeaderField: "Lang");
    }
    
    public func apiResult(operation: AFHTTPRequestOperation!, error: NSError!, done: (response: APIResponse)->Void)
    {
        if(error != nil && AFNetworkReachabilityManager.sharedManager().reachable == true) {
            // We only want to print an error if the device is online. If the device started while offline and is still offline tt is likely to create an error.
            // This happens because the app is trying to force all network requests to the cache, though one may not exist because cache is in memory only.
            print("Error: " + error.description, terminator: "");
            print("\n", terminator: "");
            if(operation.response != nil) {
                print("Status Code: " + String(operation.response!.statusCode));
                print("\n", terminator: "");
            }
            
            print("\n", terminator: "");
        }
        
        let response = APIResponse.loadFromReqeustOperationWithResponse(operation);
        
        done(response: response);
    }
}

