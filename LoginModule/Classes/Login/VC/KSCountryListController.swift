//
//  KSCountryListController.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/21.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSCountryListController: UIViewController {
    var countryListModels: [KSCountryListModel] = [KSCountryListModel]()
    var selectedClosure: KShasParamaCallBack?
    lazy var countryListView: KSCoutryListView = {
       let countryListView = KSCoutryListView()
        return countryListView
    }()
    lazy var countrySearchView: KSCountrySearchView = {
        let searchView = KSCountrySearchView()
        searchView.isHidden = true
        return searchView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.hexColor("000000", alpha: 0.3)
        addChildViews()
        setupConstrains()
        bindUIEvent()
        updateDataSource()
    }
    private func addChildViews(){
        self.view.addSubview(countryListView)
        self.view.addSubview(countrySearchView)
    }
    private func setupConstrains(){
        countryListView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(50)
        }
        countrySearchView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(50)
        }
    }
    private func bindUIEvent(){
        countryListView.backBtnClosure = {[weak self] in
            guard let self = self else {return}
            self.dismiss(animated: true, completion: nil)
        }
        countryListView.searchClosure = {[weak self] in
            guard let self = self else {return}
            self.countrySearchView.isHidden = false
            var countryArray = [KSCountryModel]()
            for model in self.countryListModels{
                for country in model.children{
                    countryArray.append(country)
                }
            }
            self.countrySearchView.passSourceDataSource(dataArray: countryArray)
        }
        countrySearchView.clickClosure = {[weak self] (model) in
            guard let self = self else {return}
            if let model = model as? KSCountryModel{
                if self.selectedClosure != nil {
                    self.selectedClosure!(model)
                }
            }
            self.dismiss(animated: true, completion: nil)
            
            
        }
        countryListView.clickClosure = {[weak self] (model) in
            guard let self = self else {return}
            if let model = model as? KSCountryModel{
                if self.selectedClosure != nil {
                    self.selectedClosure!(model)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    func updateDataSource(){
        let path = Bundle.main.path(forResource: "phonePrefix", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let data = try Data(contentsOf: url)
            let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            if let jsonData = jsonData as? [String: Any],let jsonDataArray = jsonData["phonePrefixList"] as? [[String: Any]]{
            let modelArray = jsonDataArray.compactMap { (json) -> KSCountryListModel in
                return KSCountryListModel.paraseJsontoCountryListModel(json: json)
            }
            self.countryListModels = modelArray
            countryListView.updateCountryListView(datas: modelArray)
            }else{
                KSProgressHUD.showError("解析国家列表失败")
            }
        } catch  {
            print("读取本地数据出现错误!")
        }
        
    }
    
     

    

}
