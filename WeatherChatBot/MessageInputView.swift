//
//  MessageInputView.swift
//  WeatherChatBot
//
//  Created by USER on 2018. 9. 21..
//  Copyright © 2018년 practice. All rights reserved.
//

import UIKit

class MessageInputView: UIView {
    
    let messageTextfield: UITextField = {
        let textfield = UITextField()
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 12)]
        textfield.attributedPlaceholder = NSAttributedString(string: "Please ask anything about weather.", attributes: attributes)
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 0.5
        textfield.layer.cornerRadius = 5
        textfield.backgroundColor = .white
        let leftPadding = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
        textfield.leftView = leftPadding
        textfield.leftViewMode = .always
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(hexString: "F6F6F6")
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(messageTextfield)
        addSubview(sendButton)
        NSLayoutConstraint.activate([
            
            sendButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            sendButton.widthAnchor.constraint(equalToConstant: 60),
            sendButton.heightAnchor.constraint(equalToConstant: 35),
            
            messageTextfield.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            messageTextfield.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            messageTextfield.heightAnchor.constraint(equalToConstant: 35),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
