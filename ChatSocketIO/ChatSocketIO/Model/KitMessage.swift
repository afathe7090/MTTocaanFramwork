//
//  KitMessage.swift
//  ChatSocketIO
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import Foundation

public struct KitMessage: MessageType {
    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
    public var createAt: String
    
    public init(sender: SenderType, messageId: String, sentDate: Date, kind: MessageKind, createAt: String) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
        self.createAt = createAt
    }
}
