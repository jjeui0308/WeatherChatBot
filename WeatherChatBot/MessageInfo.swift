//
//  MessageInfo.swift
//  WeatherChatBot
//
//  Created by USER on 2018. 9. 21..
//  Copyright © 2018년 practice. All rights reserved.
//

import Foundation

struct MessageInfo {
    
    let text: String
    let isFromBot: Bool
    init(text: String, isFromBot: Bool) {
        self.text = text
        self.isFromBot = isFromBot
    }
}
