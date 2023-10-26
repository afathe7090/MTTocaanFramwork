//
//  CurrentUser.swift
//  ChatSocketIO
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import Foundation

public struct CurrentUser {
    public let id: Int
    public let name: String
    public let image: String
    
    public init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
