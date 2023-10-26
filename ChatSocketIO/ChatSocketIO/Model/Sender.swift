//
//  Sender.swift
//  ChatSocketIO
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import Foundation

public struct Sender: SenderType {
    public var senderId: String
    public var displayName: String
    
    public init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}
