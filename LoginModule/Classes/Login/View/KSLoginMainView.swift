//
//  KSLoginMainView.swift
//  Kit
//
//  Created by 韩志峰 on 2020/6/18.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit
import Alamofire
class KSLoginMainView: UIView {
    let textFieldWidth: CGFloat = UIScreen.main.bounds.size.width - 70
    var loginClick: KSNoParamaCallBack?
    var userProtocolClick: KSNoParamaCallBack?
    var privateProtoClick: KSNoParamaCallBack?
    var countryBtnClick: KSNoParamaCallBack?
    var logoTop: CGFloat =  isiPhoneX() ? 136.5 : 116.5
    var timer: Timer?
    var personModel: KSPersonOutModel = KSPersonOutModel()
     var countryPhone: String = ""
    lazy var loginIcon: UIImageView = {
       let loginIcon = UIImageView()
        loginIcon.image = UIImage.init(named: "loginLogo")
        return loginIcon
    }()
    
    lazy var noteView: UILabel = {
       let noteView = UILabel()
        noteView.text = "请登录"
        noteView.font = UIFont.systemFont(ofSize: 23)
        return noteView
    }()
    lazy var welcomeView: UILabel = {
       let welcomeView = UILabel()
        welcomeView.text = "Hi,欢迎使用KIT"
        welcomeView.font = UIFont.systemFont(ofSize: 13)
        return welcomeView
    }()
    lazy var countryLabel: UILabel = {
        let mainView = UILabel()
        mainView.text = "+86"
        mainView.font = UIFont.systemFont(ofSize: 16)
        return mainView
    }()
    lazy var countryBtn: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.backgroundColor = UIColor.hexColor("ffffff")
        logoutBtn.setImage(UIImage.init(named: "countryArrow"), for: .normal)
        logoutBtn.setImage(UIImage.init(named: "countryArrow"), for: .highlighted)
        logoutBtn.addTarget(self, action: #selector(countryBtnDidClick), for: .touchUpInside)
        logoutBtn.setEnlargeEdgeWithTop(5, left: 5, bottom: 5, right: 5)
        return logoutBtn
    }()
    
    lazy var verticalLineView: UIView = {
       let verticalView = UIView()
        verticalView.backgroundColor = UIColor.hexColor("#D8DBDF")
        return verticalView
    }()
    
    lazy var phoneField: UITextField = {
        let phoneField = UITextField()
        phoneField.placeholder = "请输入手机号"
        phoneField.keyboardType = .numberPad
        return phoneField
    }()
    lazy var veriCodeView: UITextField = {
       let veriCodeView = UITextField()
        veriCodeView.placeholder = "验证码"
        veriCodeView.isHidden = true
        veriCodeView.keyboardType = .numberPad
        return veriCodeView
    }()
    
    lazy var hasSendNoteView: UILabel = {
       let hasSendNoteView = UILabel()
        hasSendNoteView.text = "已发送"
        hasSendNoteView.textColor = UIColor.hexColor("999999")
        hasSendNoteView.backgroundColor = UIColor.hexColor("f5f6f8")
        hasSendNoteView.layer.cornerRadius = 12
        hasSendNoteView.clipsToBounds = true
        hasSendNoteView.isHidden = true
        hasSendNoteView.textAlignment = .center
        hasSendNoteView.font = UIFont.systemFont(ofSize: 11)
        return hasSendNoteView
    }()
    
    lazy var horizonLineView: UIView = {
       let  horizonLineView = UIView()
        horizonLineView.backgroundColor = UIColor.hexColor("016efb")
        return horizonLineView
    }()
    lazy var verifyBtn: UIButton = {
       let verifyBtn = UIButton()
        verifyBtn.setTitle("获取验证码", for: .normal)
        verifyBtn.setTitle("获取验证码", for: .normal)
        verifyBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        verifyBtn.setTitleColor(UIColor.hexColor("016efb"), for: .normal)
        verifyBtn.setTitleColor(UIColor.hexColor("016efb"), for: .highlighted)
        verifyBtn.addTarget(self, action: #selector(getVeriFiedBtnDidClick), for: .touchUpInside)
        return verifyBtn
    }()
    lazy var countDownView: UILabel = {
       let countDownView = UILabel()
        countDownView.textColor = UIColor.hexColor("cccccc")
        countDownView.font = UIFont.boldSystemFont(ofSize: 16)
        countDownView.isHidden = true
        return countDownView
    }()
    lazy var loginBtn: UIButton = {
       let loginBtn = UIButton()
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .highlighted)
        loginBtn.backgroundColor = UIColor.hexColor("016efb")
        loginBtn.layer.cornerRadius = 6
        loginBtn.clipsToBounds = true
        loginBtn.isHidden = true
        loginBtn.addTarget(self, action: #selector(loginBtnDidClick), for: .touchUpInside)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitle("登录", for: .highlighted)
        return loginBtn
    }()
    lazy var featureLabel: YYLabel = {
       let featureView = YYLabel()
        featureView.textAlignment = .center
        featureView.font = UIFont.systemFont(ofSize: 13)
        featureView.textColor = UIColor.black
        featureView.isUserInteractionEnabled = true
        let text: String = "请您仔细阅读《用户协议》和《隐私政策》"
        let attributeString: NSMutableAttributedString = NSMutableAttributedString.init(string: text)
        let nsString = NSString.init(string: text)
        let range1 = nsString.range(of: "《用户协议》", options: .caseInsensitive)
        let range2 = nsString.range(of: "《隐私政策》", options: .caseInsensitive)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor: mainColor], range: range1)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor: mainColor], range: range2)
        attributeString.setTextHighlight(NSMakeRange(6, 6), color: mainColor, backgroundColor: UIColor.white) { (view, string, range, rect) in
            if self.userProtocolClick != nil{
                self.userProtocolClick!()
            }
            
        }
        attributeString.setTextHighlight(NSMakeRange(13, 6), color: mainColor, backgroundColor: UIColor.white) { (view, string, range, rect) in
            if self.privateProtoClick != nil {
                self.privateProtoClick!()
            }
        }
        featureView.attributedText = attributeString
        
        return featureView
    }()
    
    lazy var registerView: UILabel = {
        let mainView = UILabel()
        mainView.text = "未注册的手机号验证后自动注册"
        mainView.font = UIFont.systemFont(ofSize: 13)
        return mainView
    }()
    
    lazy var protocolBtn: UIButton = {
       let button = UIButton()
        button.setImage(UIImage.init(named: "notChoose"), for: .normal)
        button.setImage(UIImage.init(named: "selecteBtn"), for: .selected)
        button.addTarget(self, action: #selector(protocolBtnDidClick(button:)), for: .touchUpInside)
        button.layer.cornerRadius = 7.5
        button.setEnlargeEdgeWithTop(10, left: 10, bottom: 10, right: 10)
        return button
    }()
    var verifyCodeModel: KSVeriCodeModel = KSVeriCodeModel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addChildViews()
        setupConstrains()
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledChange(notification:)), name:UITextField.textDidChangeNotification, object: self.phoneField)
        self.requetRegisterViewIsShow()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func  protocolBtnDidClick(button: UIButton){
        button.isSelected = !button.isSelected
    }
    @objc func textFiledChange(notification: Notification){
        if let textField = notification.object as? UITextField,textField == self.phoneField{
            if let text = textField.text, text.count > 11{
                textField.text = String(text.prefix(11))
            }
        }
    }
    private func addChildViews(){
        self.addSubview(loginIcon)
        self.addSubview(noteView)
        self.addSubview(welcomeView)
        self.addSubview(countryLabel)
        self.addSubview(countryBtn)
        self.addSubview(verticalLineView)
        self.addSubview(phoneField)
        self.addSubview(veriCodeView)
        self.addSubview(horizonLineView)
        self.addSubview(hasSendNoteView)
        self.addSubview(verifyBtn)
        self.addSubview(countDownView)
        self.addSubview(loginBtn)
        addSubview(featureLabel)
        addSubview(protocolBtn)
        addSubview(registerView)
    }
    private func setupConstrains(){
        loginIcon.snp.makeConstraints { (make) in
            make.left.equalTo(27.5)
            make.top.equalTo(logoTop)
            make.width.equalTo(64)
            make.height.equalTo(64)
        }
        noteView.snp.makeConstraints { (make) in
            make.left.equalTo(loginIcon.snp.right).offset(16)
            make.centerY.equalTo(loginIcon.snp.centerY)
        }
        welcomeView.snp.makeConstraints { (make) in
            make.left.equalTo(noteView.snp.left)
            make.top.equalTo(noteView.snp.bottom).offset(5)
        }
        countryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(loginIcon.snp.left)
            make.centerY.equalTo(phoneField.snp.centerY)
            make.width.equalTo(40)
        }
        countryBtn.snp.makeConstraints { (make) in
            make.left.equalTo(countryLabel.snp.right).offset(5)
            make.centerY.equalTo(phoneField.snp.centerY)
        }
        verticalLineView.snp.makeConstraints { (make) in
            make.left.equalTo(countryBtn.snp.right).offset(10)
            make.centerY.equalTo(countryBtn.snp.centerY)
            make.width.equalTo(1)
            make.height.equalTo(16)
        }
        phoneField.snp.makeConstraints { (make) in
            make.left.equalTo(verticalLineView.snp.right).offset(15)
            make.width.equalTo(textFieldWidth)
            make.top.equalTo(loginIcon.snp.bottom).offset(44.5)
        }
        veriCodeView.snp.makeConstraints { (make) in
            make.left.equalTo(phoneField.snp.left)
            make.width.equalTo(textFieldWidth)
            make.top.equalTo(phoneField.snp.top)
        }
        hasSendNoteView.snp.makeConstraints { (make) in
            make.centerY.equalTo(phoneField.snp.centerY)
            make.width.equalTo(133)
            make.right.equalTo(-30)
            make.height.equalTo(24)
        }
        horizonLineView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(0.5)
            make.top.equalTo(phoneField.snp.bottom).offset(9)
        }
        
        registerView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.centerY.equalTo(verifyBtn)
        }
        
        verifyBtn.snp.makeConstraints { (make) in
            make.right.equalTo(horizonLineView.snp.right)
            make.top.equalTo(horizonLineView.snp.bottom).offset(10)
        }
        countDownView.snp.makeConstraints { (make) in
            make.right.equalTo(horizonLineView.snp.right)
            make.top.equalTo(horizonLineView.snp.bottom).offset(10)
        }
        loginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(horizonLineView.snp.bottom).offset(62.5)
            make.width.equalTo(314)
            make.height.equalTo(49)
        }
        featureLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.protocolBtn.snp.right).offset(5)
            make.centerY.equalTo(protocolBtn.snp.centerY)
            make.height.equalTo(30)
        }
        protocolBtn.snp.makeConstraints { (make) in
            make.left.equalTo(registerView)
            make.height.width.equalTo(15)
            make.top.equalTo(registerView.snp.bottom).offset(37)
        }
    }
    @objc func getVeriFiedBtnDidClick(){
        self.phoneField.resignFirstResponder()
        guard protocolBtn.isSelected == true else {
            KSProgressHUD.showInfor("请先阅读并勾选用户协议和隐私政策")
            return
        }
        if countryLabel.text == "+86"{
            guard phoneField.text?.count == 11 else {
                   KSProgressHUD.showInfor("请输入11位电话号码")
                   return
               }
        }else{
            if let text = self.phoneField.text{
                guard (text.count >= 8 && text.count <= 15) else{
                    KSProgressHUD.showInfor("电话号码位数错误")
                    return
                }
            }
        }
        if let text = phoneField.text{
            var countNumber: Int = 60
            verifyBtn.isHidden = true
            countDownView.isHidden = false
            hasSendNoteView.isHidden = false
            hasSendNoteView.text = "已发送到\(text)"
            loginBtn.isHidden = false
            phoneField.isHidden = true
            veriCodeView.isHidden = false
            protocolBtn.isHidden = true
            featureLabel.isHidden = true
            
            horizonLineView.backgroundColor = UIColor.hexColor("cccccc")
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {[weak self](timer) in
                guard let self = self else {return}
                countNumber = countNumber - 1
                self.countDownView.text = "重新获取(\(countNumber))"
                if (countNumber == 0){
                    self.failedTimer()
                }
            })
        }else{
            SVProgressHUD.setFont(UIFont.systemFont(ofSize: 12))
            SVProgressHUD.showError(withStatus: "请输入有效的电话号码")
            return
        }
       
        if let countryCode = self.countryLabel.text {
            countryPhone = countryCode
        }else{
            countryPhone = "+86"
        }
        let parama: [String: Any] = ["phone":phoneField.text!,"date":"2020-5-5 19:00:00","country":countryPhone]
        requestCode(parama: parama)
    }
    @objc func loginBtnDidClick(){
        if let vericodeText = self.veriCodeView.text, vericodeText.count > 0 {
            
            let parama: [String: Any] = ["phone":phoneField.text!,"code":veriCodeView.text!,"date":"2020-5-5 19:00:00","country":countryPhone]
            KSUserDefault.standard.setAnyValue(phoneField.text!, forKey: "phoneNumber")
            requestAuth(parama: parama)
        }else{
            KSProgressHUD.showError("验证码不能为空")
        }
        
    }
    func failedTimer(){
        timer?.invalidate()
        timer = nil
        countDownView.isHidden = true
        verifyBtn.isHidden = false
        horizonLineView.backgroundColor = UIColor.hexColor("016efb")
        hasSendNoteView.isHidden = true
        loginBtn.isHidden = true
        veriCodeView.isHidden = true
        phoneField.isHidden = false
        protocolBtn.isHidden = false
        featureLabel.isHidden = false
    }
    func requetRegisterViewIsShow(){
        let url: String = mainDomain + checkVersion
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let parama: [String: Any] = ["version":currentVersion,"date":"2020-5-5 19:00:00"]
        KSNetManager.shareInstance.requestPost(url: url, parama: parama, success: { [weak self](jsonDict) in
            guard let self = self else {return}
            if let dict = jsonDict["data"] as? [String: Any]{
                let model = KSVersionModel.paraseJsontoVersionModel(json: dict)
                    self.registerView.isHidden = model.login == "0" ? true : false
            }
        }) { (error) in
            if error != nil {
                KSProgressHUD.showError("审核接口网络错误")
            }
        }
        
    }
    
    func requestAuth(parama: [String: Any]){
        SVProgressHUD.showInfo(withStatus: "加载中...")
        let url = mainDomain + authUrl
        KSNetManager.shareInstance.requestPost(url: url, parama: parama, success: {[weak self] (jsonDict) in
            guard let self = self else {return}
            self.personModel = KSPersonOutModel.paraseJsonToPerOutModel(json: jsonDict)
            if let _ = KSKeyChainManager.keyChainReadData(identifier: personalModelUrl){//更新
                if let personData = KSFileManager.shareInstance.changeModelToData(model: self.personModel){
                    let result = KSKeyChainManager.keyChainUpdata(data: personData, withIdentifier: personalModelUrl)
                    print("更新结果\(result)")
                }
            }else{//第一次存储
                if let personData = KSFileManager.shareInstance.changeModelToData(model: self.personModel){
                    let result = KSKeyChainManager.keyChainSaveData(data: personData, withIdentifier: personalModelUrl)
                    print("存储结果\(result)")
                }
            }
            
            SVProgressHUD.dismiss()
            if self.personModel.code == 0 {
                if self.loginClick != nil {
                    self.loginClick!()
                }
            }else{
                switch self.personModel.code {
                case 10002:
                    KSProgressHUD.showError("POST数据结构错误")
                case 20003:
                    KSProgressHUD.showError("获取token失败")
                case 20109:
                    KSProgressHUD.showError("短信验证失败")
                case 20004:
                    KSProgressHUD.showError("错误超过10次锁24小时")
                default:
                    KSProgressHUD.showError("未知错误")
                }
            }
        }) { (error) in
            KSProgressHUD.showError("网络错误")
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
    }
    func requestCode(parama:[String: Any]){
        let url = mainDomain + codeUrl
        KSNetManager.shareInstance.requestPost(url: url, parama: parama, success: {[weak self] (jsonDict) in
            guard let self = self else {return}
            self.verifyCodeModel = KSVeriCodeModel.paraseJsontoKSVeriCodeModel(json: jsonDict)
            guard self.verifyCodeModel.code == 0 else{
                KSProgressHUD.showError("手机号不存在")
                return
            }
        }) { (error) in
            print(error ?? "")
           KSProgressHUD.showError("网络错误请查看网络设置")
        }
    }
    @objc func countryBtnDidClick(){
        if self.countryBtnClick != nil {
            self.countryBtnClick!()
        }
    }
    
    
}
