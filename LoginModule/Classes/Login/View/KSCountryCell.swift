//
//  KSCountryCell.swift
//  Kit
//
//  Created by 韩志峰 on 2020/10/21.
//  Copyright © 2020 韩志峰. All rights reserved.
//

import UIKit

class KSCountryCell: UITableViewCell {
    lazy var countryNameView: UILabel = {
        let mainView = UILabel()
        mainView.font = UIFont.systemFont(ofSize: 17)
        return mainView
    }()
    lazy var phoneNumberView: UILabel = {
        let mainView = UILabel()
        mainView.font = UIFont.systemFont(ofSize: 17)
        mainView.textColor = UIColor.hexColor("#5D6877")
        return mainView
    }()
    lazy var horizalView: UIView = {
       let horizalView = UIView()
//        horizalView.backgroundColor = UIColor.hexColor("#989EA8", alpha: 0.3)
        return horizalView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addChildViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addChildViews(){
        contentView.addSubview(countryNameView)
        contentView.addSubview(phoneNumberView)
        contentView.addSubview(horizalView)
    }
    func setupConstrains(){
        countryNameView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.left.equalTo(23)
        }
        phoneNumberView.snp.makeConstraints { (make) in
            make.right.equalTo(-23)
            make.centerY.equalTo(contentView)
        }
        horizalView.snp.makeConstraints { (make) in
            make.left.equalTo(23)
            make.right.equalTo(-23)
            make.bottom.equalTo(-0.5)
            make.height.equalTo(0.5)
        }
    }
    func updateCountryCell(model: KSCountryModel){
        countryNameView.text = model.title
        phoneNumberView.text = model.content
    }
    

}
