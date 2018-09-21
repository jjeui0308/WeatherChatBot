//
//  ChatViewController.swift
//  WeatherChatBot
//
//  Created by USER on 2018. 9. 21..
//  Copyright © 2018년 practice. All rights reserved.
//

import UIKit
import MapKit

class ChatViewController: UIViewController {
    
    fileprivate var messages = [MessageInfo]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.isHidden = true
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.identifier)
        tableView.isUserInteractionEnabled = true
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:))))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    @objc func handleGesture(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private let messageInputView: MessageInputView = {
        let view = MessageInputView()
        view.sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func handleSend() {
        if let message = messageInputView.messageTextfield.text, !message.isEmpty {
            addMessage(message, isFromBot: false)
            messageInputView.messageTextfield.text = ""
        }
    }
    
    private var bottomConstraint: NSLayoutConstraint!
    private let locationManager = CLLocationManager()
    private let weatherManager = WeatherManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Ask Anything about wether!"
        view.backgroundColor = .white
        setupLayout()
        addNotifications()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addMessage("Hi. You can ask anything about weather!", isFromBot: true)
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse, let coordinate = locationManager.location {
            weatherManager.request(with: CLLocationCoordinate2D(latitude: coordinate.coordinate.latitude, longitude: coordinate.coordinate.longitude))
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.addMessage("Please, allow to access to your location so that I can help you with weather!", isFromBot: true)
            }
        }
    }
    
    private func addMessage(_ text: String, isFromBot: Bool) {
        let message = MessageInfo(text: text, isFromBot: isFromBot)
        messages.append(message)
        let row = messages.isEmpty ? 0 : messages.count - 1
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        self.tableView.endUpdates()
        scrollToBottom()
    }
    
    func addNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardPoppedUp(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillDismiss(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardWillDismiss(_ notification: Notification) {
        bottomConstraint.constant = 0
        view.layoutIfNeeded()
    }
    
    @objc func handleKeyboardPoppedUp(_ notification: Notification) {
        let keyboardFrame = (notification.userInfo![UIWindow.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.tableView.isScrollEnabled = false
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.view.layoutIfNeeded()
    
        bottomConstraint.constant = -keyboardFrame.height
    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.scrollToBottom()
        }) { (_) in
            self.tableView.isScrollEnabled = true
            self.tableView.decelerationRate = UIScrollView.DecelerationRate.normal
        }
    }
    
    private func scrollToBottom() {
        guard !messages.isEmpty else { return }
        tableView.scrollToRow(at: IndexPath(row: messages.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(messageInputView)
        
        bottomConstraint = messageInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
        
            messageInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 65),
                
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor)
            ])
        
    }

  

}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        return cell
    }
    
    
}




































































































