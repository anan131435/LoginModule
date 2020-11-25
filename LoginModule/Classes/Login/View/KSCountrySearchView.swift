//
//  KSCountrySearchView.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/23.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSCountrySearchView: KSBaseView {
     let cellIdentifier: String = "countryCell"
    var countryDataArray: [KSCountryModel] = [KSCountryModel]()
    var originalArray: [KSCountryModel]  = [KSCountryModel]()
    var clickClosure: KShasParamaCallBack?
    lazy var whiteView: UIView = {
       let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    lazy var grayView: UIView = {
       let grayView = UIView()
        grayView.backgroundColor = UIColor.hexColor("#EFF0F3")
        grayView.layer.cornerRadius = 10
        return grayView
    }()
    lazy var searchIconBtn: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.setImage(UIImage.init(named: "eyeSearch"), for: .normal)
        logoutBtn.setImage(UIImage.init(named: "eyeSearch"), for: .highlighted)
        return logoutBtn
    }()
    lazy var textFiled: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.addTarget(self, action: #selector(textFieldValueChange), for: .allEditingEvents)
        return textField
    }()
    lazy var closeBtn: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.setImage(UIImage.init(named: "searchClose"), for: .normal)
        logoutBtn.setImage(UIImage.init(named: "searchClose"), for: .highlighted)
        logoutBtn.addTarget(self, action: #selector(closeBtnDidClick), for: .touchUpInside)
        return logoutBtn
    }()
    lazy var cancelBtn: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.setTitle("取消", for: .normal)
        logoutBtn.setTitle("取消", for: .highlighted)
        logoutBtn.setTitleColor(mainColor, for: .normal)
        logoutBtn.setTitleColor(mainColor, for: .highlighted)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        logoutBtn.backgroundColor = UIColor.clear
        logoutBtn.addTarget(self, action: #selector(cancelBtnDidClick), for: .touchUpInside)
        return logoutBtn
    }()
    lazy var tableView: UITableView = {
           let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
           tableView.register(KSCountryCell.classForCoder(), forCellReuseIdentifier: "countryCell")
           tableView.separatorStyle = .none
           tableView.delegate = self
           tableView.dataSource = self
           tableView.backgroundColor = .white
           return tableView
       }()
    lazy var emptyView: KScoutryEmptyView = {
       let emptyView = KScoutryEmptyView()
        emptyView.isHidden = true
        return emptyView
    }()
    override func addChildViews() {
        super.addChildViews()
        self.addSubview(whiteView)
        whiteView.addSubview(grayView)
        grayView.addSubview(searchIconBtn)
        grayView.addSubview(textFiled)
        grayView.addSubview(closeBtn)
        whiteView.addSubview(cancelBtn)
        whiteView.addSubview(tableView)
        whiteView.addSubview(emptyView)
    }
    override func setupConstrains() {
        super.setupConstrains()
        whiteView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        grayView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(16)
            make.height.equalTo(36)
            make.right.equalTo(-56)
        }
        searchIconBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(grayView.snp.centerY)
            make.width.height.equalTo(20)
            make.left.equalTo(10)
        }
        textFiled.snp.makeConstraints { (make) in
            make.left.equalTo(searchIconBtn.snp.right).offset(2)
            make.right.equalTo(closeBtn.snp.left).offset(-2)
            make.centerY.equalTo(grayView)
        }
        closeBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(24)
            make.centerY.equalTo(grayView)
            make.right.equalTo(-6)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(grayView.snp.centerY)
            make.right.equalTo(-16)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(grayView.snp.bottom).offset(21)
        }
        emptyView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(grayView.snp.bottom).offset(21)
        }
        
    }
    @objc func closeBtnDidClick(){
        self.textFiled.text = ""
        self.textFieldValueChange()
    }
    @objc func cancelBtnDidClick(){
        self.isHidden = true
        self.textFiled.text = ""
        self.textFiled.resignFirstResponder()
    }
    @objc func textFieldValueChange(){
        var resultArray = [KSCountryModel]()
        if let keyWord = textFiled.text,keyWord.count > 0 {
            for model in originalArray{
                if model.title.contains(keyWord) == true {
                    print(model.title)
                    print("匹配上")
                    resultArray.append(model)
                }else{
                    print("\(model.title)没要匹配上")
                }
            }
            self.countryDataArray = resultArray
            emptyView.isHidden = self.countryDataArray.count > 0  ? true : false
        }else{
            emptyView.isHidden = true
            self.countryDataArray = self.originalArray
        }
        
        self.tableView.reloadData()
        
    }
    func passSourceDataSource(dataArray: [KSCountryModel]){
        self.countryDataArray = dataArray
        self.originalArray = dataArray
        self.tableView.reloadData()
    }
   
    
}
extension KSCountrySearchView: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KSCountryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KSCountryCell
        let model = countryDataArray[indexPath.row]
        cell.updateCountryCell(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.textFiled.resignFirstResponder()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard countryDataArray.count > indexPath.row else {return}
        let model = countryDataArray[indexPath.row]
        if self.clickClosure != nil {
            self.clickClosure!(model)
        }
        
    }
    
}
