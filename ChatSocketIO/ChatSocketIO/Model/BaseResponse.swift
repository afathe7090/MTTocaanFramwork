//
//  BaseResponse.swift
//  Athdak
//
//  Created by Ahmed Fathy on 24/08/2023.
//

import Foundation

public struct BaseResponse<T: Codable>: Codable {
    public var key: String?
    public var msg: String?
    public var count_notifications: Int?
    public var data: T?
    
    public init(key: String? = nil, msg: String? = nil, count_notifications: Int? = nil, data: T?) {
        self.key = key
        self.msg = msg
        self.count_notifications = count_notifications
        self.data = data
    }
}
