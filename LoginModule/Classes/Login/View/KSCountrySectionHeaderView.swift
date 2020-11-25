//
//  KSCountrySectionHeaderView.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/23.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSCountrySectionHeaderView: KSBaseView {
    lazy var titleView: UILabel = {
        let mainView = UILabel()
        mainView.textColor = UIColor.hexColor("#989EA8")
        mainView.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        mainView.backgroundColor = UIColor.clear
        return mainView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hexColor("#F2F3F5")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func addChildViews() {
        super.addChildViews()
        self.addSubview(titleView)
    }
    override func setupConstrains() {
        super.setupConstrains()
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(23)
            make.centerY.equalTo(self)
        }
    }
    func updateSectionHeaderView(title: String){
        titleView.text = title
    }
    

}
