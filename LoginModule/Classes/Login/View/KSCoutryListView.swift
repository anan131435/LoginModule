//
//  KSCoutryListView.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/21.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSCoutryListView: KSBaseView {
    var backBtnClosure: KSNoParamaCallBack?
    var searchClosure: KSNoParamaCallBack?
    let cellIdentifier: String = "countryCell"
    var dataSource: [KSCountryListModel] = [KSCountryListModel]()
    var clickClosure: KShasParamaCallBack?
    lazy var whiteView: UIView = {
       let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    
    lazy var backBtn: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.setImage(UIImage.init(named: "searchBack"), for: .normal)
        logoutBtn.setImage(UIImage.init(named: "searchBack"), for: .highlighted)
        logoutBtn.addTarget(self, action: #selector(backBtnDidClick), for: .touchUpInside)
        return logoutBtn
    }()
    lazy var titleView : UILabel = {
        let mainView = UILabel()
        mainView.text = "选择国家和地区"
        mainView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        mainView.textAlignment = .center
        return mainView
    }()
    lazy var searchBtn: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.backgroundColor = UIColor.hexColor("#EFF0F3")
        logoutBtn.layer.cornerRadius = 10
        logoutBtn.clipsToBounds = true
        logoutBtn.addTarget(self, action: #selector(searchBtnDidClick), for: .touchUpInside)
        return logoutBtn
    }()
    lazy var searchIconBtn: UIButton = {
        let logoutBtn = UIButton()
        logoutBtn.setTitle("搜索", for: .normal)
        logoutBtn.setTitle("搜索", for: .highlighted)
        logoutBtn.setTitleColor(UIColor.black, for: .normal)
        logoutBtn.setTitleColor(UIColor.black, for: .highlighted)
        logoutBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        logoutBtn.setTitleColor(UIColor.hexColor("#989EA8"), for: .normal)
        logoutBtn.setTitleColor(UIColor.hexColor("#989EA8"), for: .highlighted)
        logoutBtn.setImage(UIImage.init(named: "eyeSearch"), for: .normal)
        logoutBtn.setImage(UIImage.init(named: "eyeSearch"), for: .highlighted)
        logoutBtn.backgroundColor = UIColor.clear
        logoutBtn.addTarget(self, action: #selector(searchBtnDidClick), for: .touchUpInside)
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
    override func addChildViews() {
        super.addChildViews()
        self.addSubview(whiteView)
        whiteView.addSubview(backBtn)
        whiteView.addSubview(titleView)
        whiteView.addSubview(searchBtn)
        searchBtn.addSubview(searchIconBtn)
        whiteView.addSubview(tableView)
    }
    override func setupConstrains() {
        super.setupConstrains()
        whiteView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(0)
        }
        backBtn.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(16)
            make.width.height.equalTo(22)
        }
        titleView.snp.makeConstraints { (make) in
            make.centerY.equalTo(backBtn)
            make.centerX.equalTo(whiteView.snp.centerX)
        }
        searchBtn.snp.makeConstraints { (make) in
            make.left.equalTo(backBtn.snp.left)
            make.right.equalTo(-16)
            make.top.equalTo(titleView.snp.bottom).offset(16)
            make.height.equalTo(36)
        }
        searchIconBtn.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.height.equalTo(21)
            make.width.equalTo(79)
            make.centerY.equalTo(searchBtn.snp.centerY)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.width.equalTo(ksScreenWidth)
            make.top.equalTo(searchBtn.snp.bottom).offset(16)
            make.bottom.equalTo(0)
        }
    }
    @objc func backBtnDidClick(){
        if self.backBtnClosure != nil {
            self.backBtnClosure!()
        }
    }
    @objc func searchBtnDidClick(){
        if self.searchClosure != nil {
            self.searchClosure!()
        }
    }
    func updateCountryListView(datas: [KSCountryListModel]){
        self.dataSource = datas
        self.tableView.reloadData()
    }
}
extension KSCoutryListView: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataSource.count > section else {
            return 0
        }
        let models = dataSource[section].children
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KSCountryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! KSCountryCell
        let listModel = dataSource[indexPath.section]
        let model = listModel.children[indexPath.row]
        cell.updateCountryCell(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let groupView = KSCountrySectionHeaderView()
        groupView.updateSectionHeaderView(title: dataSource[section].group)
        return groupView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listModel = dataSource[indexPath.section]
        let model = listModel.children[indexPath.row]
        if self.clickClosure != nil {
            self.clickClosure!(model)
        }
    }
    
    
}
