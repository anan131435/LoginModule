//
//  KSVpnInterOutModel.swift
//  Kit
//
//  Created by 韩志峰 on 2020/7/6.
//  Copyright © 2020 com.kuaishou.org. All rights reserved.
//



class KSVpnInterOutModel: NSObject {
    var code: Int = 0
    var message: String = ""
    var data: KSVpnInterModel = KSVpnInterModel()
    class func paraseJsonToVPNOutModel(json:[String :Any]) -> KSVpnInterOutModel{
        let model = KSVpnInterOutModel()
        model.code = json["code"] as? Int ?? 1
        model.message = json["message"] as? String ?? ""
        if let jsonDict = json["data"] as? [String: Any]{
            model.data = KSVpnInterModel.paraseJsontoKSVpnInterModel(json: jsonDict)
        }
        return model
    }
}
