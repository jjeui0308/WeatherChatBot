//
//  MessageCell.swift
//  WeatherChatBot
//
//  Created by USER on 2018. 9. 21..
//  Copyright © 2018년 practice. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    static let identifier = "MessageCell"
    
    var message: MessageInfo! {
        didSet {
            messageBackground.backgroundColor = message.isFromBot ?  UIColor.init(hexString: "F6F6F6") :UIColor.init(hexString: "0076FF")
            messageLabel.textColor = message.isFromBot ? .darkGray : .white
            messageLabel.text = message.text
            
            leadingConstraint.isActive = message.isFromBot ? true : false
            trailingConstraint.isActive = message.isFromBot ? false : true
            layoutIfNeeded()
        }
    }
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let messageBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(messageBackground)
        addSubview(messageLabel)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -28)
        
        leadingConstraint.isActive = true
        trailingConstraint.isActive = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -28),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageBackground.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -14),
            messageBackground.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -14),
            messageBackground.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 14),
            messageBackground.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 14),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
