//
//  KScoutryEmptyView.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/24.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KScoutryEmptyView: KSBaseView {
    
    lazy var headerIcon: UIImageView = {
        let headerIcon = UIImageView()
        headerIcon.image = UIImage.init(named: "loginLogo")
        return headerIcon
    }()
    
    lazy var noteView: UILabel = {
        let mainView = UILabel()
        mainView.text = "对不起，没有您要的数据呢"
        mainView.font = UIFont.systemFont(ofSize: 13)
        mainView.textColor = UIColor.hexColor("333333")
        mainView.textAlignment = .center
        return mainView
    }()
    
    override func addChildViews() {
        super.addChildViews()
        self.backgroundColor = .white
        self.addSubview(headerIcon)
        self.addSubview(noteView)
    }
    override func setupConstrains() {
        super.setupConstrains()
        headerIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-100)
            make.width.equalTo(80)
            make.height.equalTo(80)
            
        }
        noteView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(headerIcon.snp.bottom).offset(20)
        }
    }
    
    
}
