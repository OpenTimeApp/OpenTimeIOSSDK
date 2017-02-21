//
//  OTAPIResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/4/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import AFNetworking

/// A standard response from the OpenTime API.
public class OTAPIResponse {
    
    /// Whether or not the request logically succeeded or logically failed.
    open var success: Bool;
    
    /// The message associated with the success or failed response.
    open var message: String;
    
    open var rawData: AnyObject?;
    
    private var _errorType: ErrorType;
    
    // The type of response
    public enum ErrorType {
        // The default which means there is no error.
        case none;
        
        // The server is responding with a 2** but the response body is empty.
        case empty;
        
        // When there is no internet connection.
        case noNetworkConnection;
        
        // For http 401 errors. The user credentials are invalid.
        case authenticationFailed;
        
        // For http 403 errors. The API key is invalid.
        case authorizationFailed;
        
        // 400 and 404 errors.
        case clientError;
        
        // For http 420 and 500 errors.
        case serverError;
    }
    
    /**
        Designated constructor.
    
        - parameter success: Whether or not the request logically succeeded or logically failed.
        - parameter message: The message associated with the success or failed response.
    */
    public init(success: Bool, message: String)
    {
        self.success    = success;
        self.message    = message;
        self.rawData    = nil;
        self._errorType = OTAPIResponse.ErrorType.none;
    }
    
    /**
        Gets the type of error received by the server if any.
    
        - returns: The type of error determined from the server response.
    */
    public func getErrorType() -> OTAPIResponse.ErrorType {
        return self._errorType;
    }
    
    public static func loadFromReqeustOperationWithResponse(_ operation: AFHTTPRequestOperation) -> OTAPIResponse{
        
        let rawResponse = OTAPIRawResponse.deserialize(operation.responseObject as AnyObject!);
        
        var code = -1;
        if(operation.response != nil) {
            code = operation.response!.statusCode;
        }
        
        let response = self._loadSerializedResponse(rawResponse, httpStatusCode: code);
        
        return response;
    }
    
    public func makeEmpty() {
        self._errorType = OTAPIResponse.ErrorType.empty;
        self.message    = OTAPIResponse._getUserMessage(self._errorType, serverMessage: "");
        self.rawData    = nil;
    }
    
    /**
        Transforms a generic parsed JSON response object into an OTAPIResponse object.
    
        - parameter responseObject: The generic parsed response object from the AFNetworking.RequestOperation
        
        - returns: An OTAPIResponse object with at least the success and message fields populated.
    */
    private class func _loadSerializedResponse(_ responseObject: OTAPIRawResponse!, httpStatusCode: Int)->OTAPIResponse
    {
        // Check the response from the server is empty.
        if(responseObject != nil)
        {
            // Setup the API response with the success and message info from the server.
            let apiResponse          = OTAPIResponse(success: responseObject.isSuccessful(), message: responseObject.getMessage());
            apiResponse.rawData    = responseObject.getRawData();
            apiResponse._errorType = self._getErrorType(httpStatusCode);
            apiResponse.message    = self._getUserMessage(apiResponse._errorType, serverMessage: responseObject.getMessage());
            
            // Return the successful response with the data property.
            return apiResponse;
        }else{
            // Return a failed response. This usually means there is an error with the server API.
            let response        = OTAPIResponse(success: false, message: "");
            response._errorType = self.ErrorType.empty;
            response.message    = self._getUserMessage(response._errorType, serverMessage: "");
            return response;
        }
    }
    
    /**
    * Gets the error type, if any based on the http response status code.
    *
    * @param httpStatusCode The HTTP status code sent from the server.
    *
    * @return The type of error based on the response from the server.
    */
    private class func _getErrorType(_ httpStatusCode: Int) -> OTAPIResponse.ErrorType
    {
        // Setup tye type scope.
        var type: ErrorType;
    
        // Map the error type from the http response code.
        switch (httpStatusCode) {
            case -1:
                type = ErrorType.noNetworkConnection;
                break;
            case 400, 404, 405, 412, 422:
                type = ErrorType.clientError;
                break;
            case 401:
                type = ErrorType.authenticationFailed;
                break;
            case 403:
                type = ErrorType.authorizationFailed;
                break;
            case 420, 500:
                type = ErrorType.serverError;
                break;
            default:
                type = ErrorType.none;
                break;
        }
    
        return type;
    }
    
    /**
    * Gets teh message that will be displayed to the user based on the type of error if any.
    *
    * @param errorType     The error type calculated based on the response from the server.
    * @param serverMessage The error message provided in the response body from the server.
    *
    * @return The message to be displayed to the user.
    */
    private class func _getUserMessage(_ errorType: OTAPIResponse.ErrorType, serverMessage: String) -> String {
        // Setup message scope.
        var message: String = serverMessage;
    
        // Map the user message from the error type.
        switch (errorType) {
            case .clientError, .authorizationFailed:
                message = NSLocalizedString("message_client_error", comment: "") as String;
                break;
            case .serverError, .empty:
                message = NSLocalizedString("message_server_error", comment: "") as String;
                break;
            case .noNetworkConnection:
                message = NSLocalizedString("message_no_network", comment: "") as String;
                break;
            case .authenticationFailed, .none:
                message = serverMessage;
                break;
        }
    
        return message;
    }
}
