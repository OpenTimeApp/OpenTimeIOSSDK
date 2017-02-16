//
//  APIRequestOperationManager.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/7/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

public class OTAPIRequestOperationManager: AFHTTPRequestOperationManager {
   
    private static var _enableCache: Bool = true;
    
    private var _maxCacheAgeInSeconds: Int = 0;
    private var _useCache = false;
    private var _clearCacheForPostAndPut = true;
    
    public static func disableCache() {
        OTAPIRequestOperationManager._enableCache = false;
    }
    
    required public init()
    {
        super.init(baseURL: nil);
        
        if(OpenTimeSDK.session.getSecurityPolicy() != nil){
            self.securityPolicy = OpenTimeSDK.session.getSecurityPolicy()!;
        }

        self.setupHeaders();
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
    }
    
    public func setCacheMaxAge(_ inMinutes: Double)
    {
        self._maxCacheAgeInSeconds = Int(inMinutes * 60);
        // If caching is allowed the enable caching.
        if(OTAPIRequestOperationManager._enableCache == true)
        {
            self._useCache = true;
        }
    }
    
    public func setClearCacheForPostAndPut(_ clearCache: Bool) {
        self._clearCacheForPostAndPut = clearCache;
    }
    
    public override func httpRequestOperation(with request: URLRequest, success: ((AFHTTPRequestOperation, Any) -> Void)?, failure: ((AFHTTPRequestOperation, Error) -> Void)? = nil) -> AFHTTPRequestOperation {
        
                var modifiedRequest = request;
                let reachability: AFNetworkReachabilityManager = self.reachabilityManager;
                if(reachability.isReachable == false)
                {
                    if(OTReachability.shouldForceCacheUse()) {
                        modifiedRequest.cachePolicy = NSURLRequest.CachePolicy.returnCacheDataDontLoad;
                    }else{
                        modifiedRequest.cachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy;
                    }
                }else if(self._useCache == false){
                    modifiedRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData;
                }else{
                    modifiedRequest.cachePolicy = NSURLRequest.CachePolicy.reloadRevalidatingCacheData;
                }
        
                let operation = super.httpRequestOperation(with: modifiedRequest as URLRequest, success: success , failure: failure);
        
                if(self._useCache)
                {
                    operation.setCacheResponseBlock({ (connection: NSURLConnection!, cachedResponse: CachedURLResponse!) -> CachedURLResponse in
                        let response:URLResponse         = cachedResponse.response;
                        let httpResponse:HTTPURLResponse = response as! HTTPURLResponse;
                        let headers:NSDictionary           = httpResponse.allHeaderFields as NSDictionary;
        
                        var modifiedHeaders:[String : String] =  headers.mutableCopy() as! [String : String];
        
                        modifiedHeaders["Cache-Control"] = "private, max-age="+String(self._maxCacheAgeInSeconds);
        
                        let modifiedHttpResponse: HTTPURLResponse = HTTPURLResponse(
                            url: httpResponse.url!,
                            statusCode: httpResponse.statusCode,
                            httpVersion: "HTTP/1.1", headerFields: modifiedHeaders)!;
        
                        //var modifiedHttpResponse:NSHTTPURLResponse = NSHTTPURLResponse(URL: httpResponse.URL!, statusCode: httpResponse.statusCode, HTTPVersion: "HTTP/1.1", headerFields: modifiedHeaders as [NSObject : AnyObject])!;
        
                        let proposedResponse:CachedURLResponse = CachedURLResponse(
                            response: modifiedHttpResponse,
                            data: cachedResponse.data,
                            userInfo: cachedResponse.userInfo,
                            storagePolicy: URLCache.StoragePolicy.allowedInMemoryOnly);
                        
                        return proposedResponse;
                    });
                }
                
                return operation;
    }
    
    public override func post(_ URLString: String, parameters: Any?, success: ((AFHTTPRequestOperation, Any) -> Void)?, failure:((AFHTTPRequestOperation?, Error) -> Void)? = nil) -> AFHTTPRequestOperation? {
        
        self.requestSerializer = AFJSONRequestSerializer();
        self.setupHeaders();
        let mySuccess = success;
        
        return super.post(URLString, parameters: parameters, success: { (operation: AFHTTPRequestOperation, responseObject: Any) in
            
            mySuccess!(operation, responseObject);
            
            if(self._clearCacheForPostAndPut) {
                
                // Clear cache for POST requests because the cache data will be out of date after the server is updated.
                // When the RAM cache is out is out of date it causes sync operations to continuously re-submit updates.
                // Continuously re-submitting updates will cause write-locks to the database... hypothetically it will waste write resources.
                URLCache.shared.removeAllCachedResponses();
            }

        }, failure: failure);
    }
    
    public override func put(_ URLString: String, parameters: Any?, success: ((AFHTTPRequestOperation, Any) -> Void)?, failure: ((AFHTTPRequestOperation?, Error) -> Void)? = nil) -> AFHTTPRequestOperation? {
        
        self.requestSerializer = AFJSONRequestSerializer();
        self.setupHeaders();
        let mySuccess = success;
        
        return super.put(URLString, parameters: parameters, success: { (operation: AFHTTPRequestOperation, responseObject: Any) in
            
            mySuccess!(operation, responseObject);
            
            if(self._clearCacheForPostAndPut) {
                /*
                Clear cache for POST requests because the cache data will be out of date after the server is updated.
                When the RAM cache is out is out of date it causes sync operations to continuously re-submit updates.
                Continuously re-submitting updates will cause write-locks to the database... hypothetically it will waste write resources.
                */
                URLCache.shared.removeAllCachedResponses();
            }
        }, failure: failure);
    }
    
    public func setupHeaders() {
        self.requestSerializer.setValue(OpenTimeSDK.getKey(), forHTTPHeaderField: OTConstant.API_KEY_NAME);
        self.requestSerializer.setValue(OTConstant.API_VERSION, forHTTPHeaderField: "V");
        let lang = NSLocale.current.languageCode;
        self.requestSerializer.setValue(lang, forHTTPHeaderField: "Lang");
    }
    
    public func apiResult(_ operation: AFHTTPRequestOperation!, error: NSError!, done: (_ response: OTAPIResponse)->Void)
    {
        if(error != nil && AFNetworkReachabilityManager.shared().isReachable == true) {
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
        
        let response = OTAPIResponse.loadFromReqeustOperationWithResponse(operation);
        
        done(response);
    }
}

