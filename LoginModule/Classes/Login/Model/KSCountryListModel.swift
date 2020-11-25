//
//  KSCountryListModel.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/21.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSCountryListModel: NSObject {
    var group: String = ""
    var children: [KSCountryModel] = [KSCountryModel]()
    class func paraseJsontoCountryListModel(json:[String:Any]) -> KSCountryListModel{
        let model = KSCountryListModel()
        model.group = json["group"] as? String  ?? ""
        if let jsonList = json["children"] as? [[String: Any]]{
            let models = jsonList.compactMap { (jsonDict) -> KSCountryModel in
                return KSCountryModel.paraseJsontoCountryModel(json: jsonDict)
            }
            model.children = models
        }
        return model
    }
}
