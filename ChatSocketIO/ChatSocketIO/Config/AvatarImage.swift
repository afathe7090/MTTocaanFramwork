//
//  AvatarImage.swift
//  ChatSocketIO
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import UIKit

public struct AvatarImage {
    public let senderAvatarImage: UIImage
    public let reciverAvatarImage: UIImage
    public init(
        senderAvatarImage: UIImage,
        reciverAvatarImage: UIImage
    ) {
        self.senderAvatarImage = senderAvatarImage
        self.reciverAvatarImage = reciverAvatarImage
    }
}
