//
//  OTDeserializedGroup.swift
//  Pods
//
//  Created by Josh Woodcock on 2/26/17.
//
//

public class OTDeserializedGroup : OTDeserializer {
    
    private struct Keys {
        static let GROUP_ID    = "id";
        static let ORG_ID      = "org_id";
        static let NAME        = "name";
        static let TYPE        = "type";
        static let STATUS      = "status";
        static let IMAGE       = "image";
        static let DESCRIPTION = "description";
        static let MEMBERS     = "members";
    }
    
    public struct TypeOption {
        static let External = 1;
        static let Internal = 2;
    }
    
    private var _groupID: OpenTimeGroupID;
    private var _orgID: OpenTimeOrgID;
    private var _name: String;
    private var _type: OpenTimeGroupType;
    private var _status: OpenTimeGroupStatus;
    private var _image: String?;
    private var _description: String;
    private var _members: Array<OTDeserializedGroupMember>;
    
    public required init(dictionary: NSDictionary){
        
        self._groupID = dictionary.value(forKey: Keys.GROUP_ID) as! OpenTimeGroupID;
        self._orgID = dictionary.value(forKey: Keys.ORG_ID) as! OpenTimeOrgID;
        self._name = dictionary.value(forKey: Keys.NAME) as! String;
        self._type = dictionary.value(forKey: Keys.TYPE) as! OpenTimeGroupType;
        self._status = dictionary.value(forKey: Keys.STATUS) as! OpenTimeGroupStatus;
        
        let rawImage = dictionary.value(forKey: Keys.IMAGE);
        if(rawImage != nil){
             self._image = dictionary.value(forKey: Keys.IMAGE) as! String;
        }else{
            self._image = nil;
        }
        
        self._description = dictionary.value(forKey: Keys.DESCRIPTION) as! String;
        
        let rawMembers = dictionary.value(forKey: Keys.MEMBERS);
        if(rawMembers != nil){
            self._members = OTDeserializationHelper.deserializeList(rawMembers as! NSArray, type: OTDeserializedGroupMember.self) as! Array<OTDeserializedGroupMember>;
        }else{
            self._members = Array<OTDeserializedGroupMember>();
        }
    }
    
    public func getGroupID() -> OpenTimeGroupID {
        return self._groupID;
    }
    
    public func getOrgID() -> OpenTimeOrgID {
        return self._orgID;
    }
    
    public func getName() -> String {
        return self._name;
    }
    
    public func getType() -> OpenTimeGroupType {
        return self._type;
    }
    
    public func getStatus() -> OpenTimeGroupStatus {
        return self._status;
    }
    
    public func getImage() -> String? {
        return self._image;
    }
    
    public func getDescription() -> String {
        return self._description;
    }
    
    public func getMembers() -> Array<OTDeserializedGroupMember> {
        return self._members;
    }
}
