//
//  BotMessageCell.swift
//  TalkyFoxy
//
//  Created by Egor on 28.11.2020.
//

import UIKit

class MessageCell: UITableViewCell {

    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let messageTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
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
    
    func setup(with message: Message) {
        messageTextLabel.text = message.text
        
        if message.sender == .bot {
            bubbleView.backgroundColor = UIColor.green.withAlphaComponent(0.3)
            bubbleView.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
                make.leading.equalToSuperview().offset(10)
            }
        } else {
            bubbleView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            bubbleView.snp.remakeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)
                make.trailing.equalToSuperview().offset(-10)
            }
        }
    }
    
    private func setupViews() {
        bubbleView.addSubview(messageTextLabel)
        addSubview(bubbleView)
    }
    
    private func setupLayout() {
        bubbleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        messageTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-10)
            make.width.lessThanOrEqualTo(UIScreen.main.bounds.width / 2)
            make.leading.equalToSuperview().offset(10)
        }
    }

}
