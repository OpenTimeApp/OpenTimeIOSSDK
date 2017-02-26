//
//  OTDeserializedGroupMember.swift
//  Pods
//
//  Created by Josh Woodcock on 2/26/17.
//
//

public class OTDeserializedGroupMember : OTDeserializer {
    
    private struct Keys {
        static let USER_ID = "user_id";
        static let GROUP_ID = "group_id";
        static let STATUS = "status";
        static let LAST_UPDATED = "last_updated";
        static let CREATED = "created";
        static let GROUP = "group";
        static let USER = "user";
    }
    
    private var _userID: OpenTimeUserID;
    private var _groupID: OpenTimeGroupID;
    private var _status: OpenTimeGroupMemberStatus;
    private var _lastUpdated: OpenTimeTimeStamp;
    private var _created: OpenTimeTimeStamp;
    private var _user: OTDeserializedPerson?;
    
    public required init(dictionary: NSDictionary){
        self._userID = dictionary.value(forKey: Keys.USER_ID) as! OpenTimeUserID;
        self._groupID = dictionary.value(forKey: Keys.GROUP_ID) as! OpenTimeGroupID;
        self._status = dictionary.value(forKey: Keys.STATUS) as! OpenTimeGroupStatus;
        self._lastUpdated = dictionary.value(forKey: Keys.LAST_UPDATED) as! OpenTimeTimeStamp;
        self._created = dictionary.value(forKey: Keys.CREATED) as! OpenTimeTimeStamp;
        
        let rawUser = dictionary.value(forKey: Keys.USER) as? NSDictionary;
        if(rawUser != nil){
            self._user = OTDeserializedPerson(dictionary: rawUser);
        }
    }
    
    public func getUserID() -> OpenTimeUserID {
        return self._userID;
    }
    
    public func getGroupID() -> OpenTimeGroupID {
        return self._groupID;
    }
    
    public func getStatus() -> OpenTimeGroupStatus {
        return self._status;
    }
    
    public func getLastUpdated() -> OpenTimeGroupMemberStatus {
        return self._status;
    }
    
    public func getCreated() -> OpenTimeTimeStamp {
        return self._created;
    }
    
    public func getUser() -> OTDeserializedPerson? {
        return self._user;
    }
}
