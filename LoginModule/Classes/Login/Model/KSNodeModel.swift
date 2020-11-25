//
//  KSNodeModel.swift
//  Kit
//
//  Created by 韩志峰 on 2020/7/8.
//  Copyright © 2020 com.kuaishou.org. All rights reserved.
//



class KSNodeModel: NSObject,Codable {
    var Area: String = ""
    var SIP: String = ""
    var isSelected: Bool = false
    var duration: TimeInterval = 0.0
    class func paraseJsontoNodeModel(json:[String:Any]) -> KSNodeModel{
        let model = KSNodeModel()
        model.Area = json["Area"] as? String  ?? ""
        model.SIP = json["SIP"] as? String ?? ""
        return model
    }
}
