//
//  TaskCell.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import UIKit

class TaskCell: UITableViewCell {
    
    private var task: Task?
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        return view
    }()

    private let timeImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "clock_ic")
        
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    private let leftSideView: UIView = {
        let view = UIView()
        view.backgroundColor = [#colorLiteral(red: 0.3137254902, green: 0.8235294118, blue: 0.7607843137, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.6705882353, blue: 0.3254901961, alpha: 1), #colorLiteral(red: 1, green: 0.2, blue: 0.4, alpha: 1)].randomElement()
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        wrapperView.addSubview(leftSideView)
        wrapperView.addSubview(timeImageView)
        wrapperView.addSubview(timeLabel)
        wrapperView.addSubview(titleLabel)
        
        addSubview(wrapperView)
    }
    
    private func setupLayout() {
        wrapperView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        leftSideView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.width.equalTo(3)
            make.height.equalToSuperview()
        }
        
        timeImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(leftSideView.snp.trailing).offset(10)
            make.size.equalTo(25)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(timeImageView.snp.trailing).offset(5)
            make.centerY.equalTo(timeImageView)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(leftSideView.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(timeImageView.snp.bottom).offset(20)
        }
    }
    
    func setup(with task: Task) {
        self.task = task
        
        timeLabel.text = task.time
        titleLabel.text = task.name
    }
    
}
