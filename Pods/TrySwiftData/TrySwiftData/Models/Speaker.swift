//
//  Speaker.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/10/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import RealmSwift
import UIKit

@objc public enum SpeakerType: Int {
    case presentation
    case lightningTalk
}

public class Speaker: Object {
    open dynamic var id: Int = 0
    open dynamic var name: String = "TBD"
    open dynamic var nameJP: String?
    open dynamic var twitter: String = "TBD"
    open dynamic var imageAssetName: String? = nil
    open dynamic var imageWebURL: String? = nil
    open dynamic var bio: String = "TBD"
    open dynamic var bioJP: String?
    open dynamic var hidden: Bool = false
    open dynamic var type: SpeakerType = .presentation
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
    public override static func indexedProperties() -> [String] {
        return ["name", "hidden"]
    }

    public class var all: Results<Speaker> {
        let realm = try! Realm.trySwiftRealm()
        return realm.objects(Speaker.self)
            .filter("hidden == false AND type == %d", SpeakerType.presentation.rawValue)
            .sorted(byKeyPath: "name")
    }

    public var localizedName: String {
        return self.localizedString(for: name, japaneseString: nameJP)
    }

    public var localizedBio: String {
        return self.localizedString(for: bio, japaneseString: bioJP)
    }

    public var imageURL: URL? {
        if let url = imageWebURL {
            return URL(string: url)!
        }

        if let assetName = imageAssetName {
            return Bundle.trySwiftAssetURL(for: assetName)!
        }

        return Bundle.trySwiftAssetURL(for: "Logo.png")!
    }
}


