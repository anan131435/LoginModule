//
//  KSVersionModel.swift
//  Kit
//
//  Created by 韩志峰 on 2020/7/21.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSVersionModel: NSObject {
    var devices: String = ""
    var login: String = ""
    var version: String = ""
    class func paraseJsontoVersionModel(json:[String:Any]) -> KSVersionModel{
        let model = KSVersionModel()
        model.devices = json["uuid"] as? String  ?? ""
        model.login = json["login"] as? String  ?? ""
        model.version = json["version"] as? String  ?? ""
        return model
    }
}
