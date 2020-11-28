//
//  ProgressItem.swift
//  TalkyFoxy
//
//  Created by Богдан Марков on 28.11.2020.
//

import UIKit

class ProgressItem: UIView {
    
    private let title: String
    private let progress: Int
    private let progressColor: UIColor
    
    private let progressCircle: UIView = {
        let circle = UIView(frame: .zero)
        circle.layer.cornerRadius = 8;
        circle.layer.masksToBounds = true;
        circle.backgroundColor = .white
        return circle
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let progressTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    init(frame: CGRect = .zero, progress: Int = 0, progressColor: UIColor = .red, title: String) {
        self.progress = progress
        self.progressColor = progressColor
        self.title = title
        
        
        
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        progressCircle.backgroundColor = progressColor
        progressLabel.text = String(progress)
        progressTitle.text = title
        
        addSubview(progressCircle)
        addSubview(progressLabel)
        addSubview(progressTitle)
    }
    
    private func setupLayout() {
        progressCircle.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.width.equalTo(16)
        }
        
        progressLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressCircle.snp.bottom).offset(10)
        }
        
        progressTitle.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressLabel.snp.bottom).offset(10)
        }
    }
}
