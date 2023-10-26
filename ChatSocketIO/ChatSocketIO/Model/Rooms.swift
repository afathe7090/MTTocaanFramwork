//
//  Rooms.swift
//  Athdak
//
//  Created by Ahmed Fathy on 01/10/2023.
//

import Foundation

public struct RoomModel: Codable {
    public var rooms: [Room]?
    public init(rooms: [Room]?) {
        self.rooms = rooms
    }
}

// MARK: - Room
public struct Room: Codable {
    public var id: Int?
    public var members: [Member]?
    public var lastMessageBody, lastMessageCreatedDt: String?

    public init(id: Int? = nil, members: [Member]? = nil, lastMessageBody: String? = nil, lastMessageCreatedDt: String? = nil) {
        self.id = id
        self.members = members
        self.lastMessageBody = lastMessageBody
        self.lastMessageCreatedDt = lastMessageCreatedDt
    }
    
    enum CodingKeys: String, CodingKey {
        case id, members
        case lastMessageBody = "last_message_body"
        case lastMessageCreatedDt = "last_message_created_dt"
    }
}

// MARK: - Member
public struct Member: Codable {
    public var id: Int?
    public var type, name: String?
    public var image: String?
    
    public init(id: Int? = nil, type: String? = nil, name: String? = nil, image: String? = nil) {
        self.id = id
        self.type = type
        self.name = name
        self.image = image
    }
}

public extension [Room]? {
    var isNilOrEmpty: Bool {
        self == nil || self?.isEmpty == true
    }
}
