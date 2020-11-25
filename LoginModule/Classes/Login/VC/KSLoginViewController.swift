//
//  KSLoginViewController.swift
//  Kit
//
//  Created by 韩志峰 on 2020/6/18.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit


public class KSLoginViewController: UIViewController {
    lazy var mainView: KSLoginMainView = {
        let mainView = KSLoginMainView()
        return mainView
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        addChidlView()
        setupConstrains()
        bindUI()
    }
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    private func addChidlView(){
        view.addSubview(mainView)
    }
    private func setupConstrains(){
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    private func bindUI(){
        mainView.loginClick = {
            KSUserDefault.standard.setValue(true, forKey: loginState)
            if let delegate = UIApplication.shared.delegate,let window = delegate.window {
                window?.rootViewController = KSTabBarViewController()
            }
        }
        mainView.userProtocolClick = {
            let webVC = KSWebViewController()
            if let urlPath = Bundle.main.path(forResource: userProtocol, ofType: fileType){
                webVC.loadUrl(urlPath: urlPath)
                webVC.setNavigationTitle(title: "用户协议")
                self.navigationController?.pushViewController(webVC, animated: true)
            }else{
                KSProgressHUD.showError("网络错误")
            }
        }
        mainView.privateProtoClick = {
            let webVC = KSWebViewController()
            if let urlPath = Bundle.main.path(forResource: privacyProtocol, ofType: fileType){
                webVC.loadUrl(urlPath: urlPath)
                webVC.setNavigationTitle(title: "隐私政策")
                self.navigationController?.pushViewController(webVC, animated: true)
            }else{
                KSProgressHUD.showError("网络错误")
            }
        }
        mainView.countryBtnClick = {[weak self] in
            guard let self = self else {return}
            let countryVC = KSCountryListController()
            countryVC.modalPresentationStyle = .fullScreen
            countryVC.selectedClosure = {[weak self] (model) in
                guard let self = self else {return}
                if let model = model as? KSCountryModel{
                    self.mainView.countryLabel.text = model.content
                }
            }
            self.present(countryVC, animated: true, completion: nil)
            
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    
    

}
