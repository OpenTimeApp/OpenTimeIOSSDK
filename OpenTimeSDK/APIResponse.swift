//
//  APIResponse.swift
//  OpenTime
//
//  Created by Josh Woodcock on 3/4/15.
//  Copyright (c) 2014-2015 Connecting Open Time, LLC. All rights reserved.
//

import UIKit
import AFNetworking

/// A standard response from the OpenTime API.
public class APIResponse {
    
    /// Whether or not the request logically succeeded or logically failed.
    public var success: Bool;
    
    /// The message associated with the success or failed response.
    public var message: String;
    
    public var rawData: AnyObject!;
    
    private var _errorType: ErrorType;
    
    // The type of response
    public enum ErrorType {
        // The default which means there is no error.
        case None;
        
        // The server is responding with a 2** but the response body is empty.
        case Empty;
        
        // When there is no internet connection.
        case NoNetworkConnection;
        
        // For http 401 errors. The user credentials are invalid.
        case AuthenticationFailed;
        
        // For http 403 errors. The API key is invalid.
        case AuthorizationFailed;
        
        // 400 and 404 errors.
        case ClientError;
        
        // For http 420 and 500 errors.
        case ServerError;
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
        self._errorType = APIResponse.ErrorType.None;
    }
    
    /**
        Gets the type of error received by the server if any.
    
        - returns: The type of error determined from the server response.
    */
    public func getErrorType() -> APIResponse.ErrorType {
        return self._errorType;
    }
    
    public class func loadFromReqeustOperationWithResponse(operation: AFHTTPRequestOperation) -> APIResponse{
        
        let rawResponse = APIRawResponse.deserialize(operation.responseObject);
        
        var code = -1;
        if(operation.response != nil) {
            code = operation.response!.statusCode;
        }
        
        let response = self._loadSerializedResponse(rawResponse, httpStatusCode: code);
        
        return response;
    }
    
    /**
        Transforms a generic parsed JSON response object into an APIResponse object.
    
        - parameter responseObject: The generic parsed response object from the AFNetworking.RequestOperation
        
        - returns: An APIResponse object with at least the success and message fields populated.
    */
    private class func _loadSerializedResponse(responseObject: APIRawResponse!, httpStatusCode: Int)->APIResponse
    {
        // Check the response from the server is empty.
        if(responseObject != nil)
        {
            // Setup the API response with the success and message info from the server.
            let apiResponse        = APIResponse(success: responseObject.isSuccessful(), message: "");
            apiResponse.rawData    = responseObject.getRawData();
            apiResponse._errorType = self._getErrorType(httpStatusCode);
            apiResponse.message    = self._getUserMessage(apiResponse._errorType, serverMessage: responseObject.getMessage());
            
            // Return the successful response with the data property.
            return apiResponse;
        }else{
            // Return a failed response. This usually means there is an error with the server API.
            let response        = APIResponse(success: false, message: "");
            response._errorType = self.ErrorType.Empty;
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
    private class func _getErrorType(httpStatusCode: Int) -> APIResponse.ErrorType
    {
        // Setup tye type scope.
        var type: ErrorType;
    
        // Map the error type from the http response code.
        switch (httpStatusCode) {
            case -1:
                type = ErrorType.NoNetworkConnection;
                break;
            case 400, 404, 405, 412, 422:
                type = ErrorType.ClientError;
                break;
            case 401:
                type = ErrorType.AuthenticationFailed;
                break;
            case 403:
                type = ErrorType.AuthorizationFailed;
                break;
            case 420, 500:
                type = ErrorType.ServerError;
                break;
            default:
                type = ErrorType.None;
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
    private class func _getUserMessage(errorType: APIResponse.ErrorType, serverMessage: String) -> String {
        // Setup message scope.
        var message: String;
    
        // Map the user message from the error type.
        switch (errorType) {
            case .ClientError, .AuthorizationFailed:
                message = NSLocalizedString("message_client_error", comment: "") as String;
                break;
            case .ServerError, .Empty:
                message = NSLocalizedString("message_server_error", comment: "") as String;
                break;
            case .NoNetworkConnection:
                message = NSLocalizedString("message_no_network", comment: "") as String;
                break;
            case .AuthenticationFailed, .None:
                message = serverMessage;
                break;
            default:
                message = serverMessage;
                break;
        }
    
        return message;
    }
}
