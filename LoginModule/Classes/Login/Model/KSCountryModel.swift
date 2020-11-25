//
//  KSCountryModel.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/21.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSCountryModel: NSObject {
    var title: String = ""
    var content: String = ""
    var fullspell: String = ""
    var shortspell: String = ""
    class func paraseJsontoCountryModel(json:[String:Any]) -> KSCountryModel{
        let model = KSCountryModel()
        model.title = json["title"] as? String  ?? ""
        model.content = json["content"] as? String  ?? ""
        model.fullspell = json["fullspell"] as? String  ?? ""
        model.shortspell = json["shortspell"] as? String  ?? ""
        return model
    }
}
