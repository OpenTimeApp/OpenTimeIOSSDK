//
//  OpenTimeSDK.swift
//  OpenTimeSDK
//
//  Created by Josh Woodcock on 10/25/15.
//  Copyright © 2015 Connecting Open Time, LLC. All rights reserved.
//

public class OpenTimeSDK {
    
    public static var session: OpenTimeSDK!;
    
    private var _apiKey: String;
    private var _inTestMode: Bool;
    private var _userID: OpenTimeUserID!;
    private var _encryptedPassword: String!;
    private var _server: String;
    
    private init(apiKey: String, inTestMode: Bool){
        self._apiKey = apiKey;
        self._inTestMode = inTestMode;
        self._server = inTestMode ? OTConstant.OPENTIME_TEST_SERVER : OTConstant.OPENTIME_LIVE_SERVER
    }
    
    public func setPlainTextCredentials(userID: OpenTimeUserID, password: String){
        self._userID = userID;
        self._encryptedPassword = OTPasswordHelper.encryptPlainTextPassword(password);
    }
    
    public func setHashedCredentials(userID: OpenTimeUserID, hashedPassword: String){
        self._userID = userID;
        self._encryptedPassword = OTPasswordHelper.encryptHashedPassword(hashedPassword);
    }
    
    public static func initSession(apiKey: String, inTestMode: Bool = false){
        self.session = OpenTimeSDK(apiKey: apiKey, inTestMode: inTestMode);
    }
    
    public static func getKey() -> String {
        if(self.session != nil){
            return self.session._apiKey;
        }else{
            return "";
        }
    }
    
    public func setServer(server: String){
        self._server = server;
    }
    
    public static func getServer()-> String {
        if(self.session != nil){
            return self.session._server;
        }else{
            return "";
        }
    }
    
    public func getUserID()->OpenTimeUserID {
        return self._userID;
    }
    
    public func getEncryptedPassword()->String {
        return self._encryptedPassword;
    }
}
