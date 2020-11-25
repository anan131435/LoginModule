//
//  KSVeriCodeModel.swift
//  Kit
//
//  Created by 韩志峰 on 2020/5/19.
//  Copyright © 2020 管清麟. All rights reserved.
//

class KSVeriCodeModel: NSObject {
    var code: Int = 0
    var message: String = ""
    class func paraseJsontoKSVeriCodeModel(json:[String:Any]) -> KSVeriCodeModel{
        let model = KSVeriCodeModel()
        model.code = json["code"] as? Int  ?? 2
        model.message = json["message"] as? String ?? ""
        return model
    }
}
