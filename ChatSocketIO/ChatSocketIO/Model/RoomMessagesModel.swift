//
//  RoomMessagesModel.swift
//  Athdak
//
//  Created by Ahmed Fathy on 01/10/2023.
//

import UIKit

public struct RoomMessagesModel: Codable {
    public var room: Room?
    public var members: [Member]?
    public var messages: MessagesModel?
    
    public init(room: Room? = nil, members: [Member]? = nil, messages: MessagesModel? = nil) {
        self.room = room
        self.members = members
        self.messages = messages
    }
    
    enum CodingKeys: String, CodingKey {
        case room, members, messages
    }
}

// MARK: - MessagesModel
public struct MessagesModel: Codable {
    public var pagination: Pagination?
    public var data: [Message]?
    
    public init(pagination: Pagination? = nil, data: [Message]? = nil) {
        self.pagination = pagination
        self.data = data
    }
}

// MARK: - Message
public struct Message: Codable {
    public var id, isSender: Int?
    public var body, type: String?
    public var duration: Int?
    public var name, createdAt: String?

    public init(
        id: Int? = nil,
        isSender: Int? = nil,
        body: String? = nil,
        type: String? = nil,
        duration: Int? = nil,
        name: String? = nil,
        createdAt: String? = nil
    ) {
        self.id = id
        self.isSender = isSender
        self.body = body
        self.type = type
        self.duration = duration
        self.name = name
        self.createdAt = createdAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case isSender = "is_sender"
        case body, type, duration, name
        case createdAt = "created_at"
    }
    
}
public extension RoomMessagesModel {
    
    func sender(for currentUser: CurrentUser) -> Sender {
        return Sender(senderId: currentUser.id.toString, displayName: currentUser.name)
    }
    
    var otherSender: Sender {
        let sMember = members?.first
        return Sender(senderId: sMember?.name ?? "" , displayName: sMember?.name ?? "")
    }
    
    func kitMessages(for sender: Sender, with configuration: MessageCellConfiguration) -> [KitMessage] {
        return messages?.data?.compactMap({
            KitMessage(
                sender: $0.isSender == 1 ? sender:otherSender ,
                messageId: $0.id?.toString ?? "",
                sentDate: Date().adding(minutes: $0.duration ?? 0),
                kind: .attributedText(
                    NSAttributedString(
                        string: $0.body ?? "",
                        attributes: [
                            .font:configuration.cellFont,
                            .foregroundColor: $0.isSender == 1 ? configuration.senderMessageTintColor:configuration.reciverMessageTintColor
                        ]
                    )
                ),
                createAt: $0.createdAt ?? ""
            )
        }) ?? []
    }

}

public extension Date {
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}
extension Int {
    var toString: String {
        String(self )
    }
}
