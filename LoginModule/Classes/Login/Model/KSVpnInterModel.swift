//
//  KSVpnInterModel.swift
//  Kit
//
//  Created by 韩志峰 on 2020/5/19.
//  Copyright © 2020 管清麟. All rights reserved.
//



class KSVpnInterModel: NSObject,Codable {
    var uuid: String = ""
    var userName: String = ""
    var privateKey: String = ""
    var address: String = ""
    var dns: String = ""
    var mtu: Int = 0
    var publicKey: String = ""
    var endPoint: String = ""
    var allowedIps: String = ""
    var persistentKeepalive: Int = 0
    var heartAddress: String = ""
    var heartPort: String = ""
    var heartHost : String = ""
    class func paraseJsontoKSVpnInterModel(json:[String:Any]) -> KSVpnInterModel{
        let model = KSVpnInterModel()
        model.uuid = json["uuid"] as? String  ?? ""
        model.userName = json["username"] as? String ?? ""
        model.privateKey = json["c_private_key"] as? String ?? ""
        model.address = json["c_address"] as? String ?? ""
        model.dns = json["c_dns"] as? String ?? ""
        model.mtu = json["c_mtu"] as? Int ?? 0
        model.publicKey = json["s_public_key"] as? String ?? ""
        model.endPoint = json["s_endpoint"] as? String ?? ""
        model.allowedIps = json["s_allowed_ips"] as? String ?? ""
        model.persistentKeepalive = json["s_persistent_keepalive"] as? Int ?? 0
        model.heartAddress = json["heart_address"] as? String ?? ""
        if let port = model.heartAddress.components(separatedBy: ":").last{
            model.heartPort = port
        }
        if let host = model.heartAddress.components(separatedBy: ":").first{
            model.heartHost = host
        }
        return model
    }
    
}
