//
//  ChatMessagesConfiguration.swift
//  ChatSocketIO
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import UIKit

public struct ChatMessagesConfiguration {
    public let navigationBackImage: UIImage?
    public let refreshControllerTintColor: UIColor
    public let currentUser: CurrentUser
    public let messageCellConfig: MessageCellConfiguration
    public let messageInputBarConfig: MessageInputBarConfiguration
    public let avatar: AvatarImage
    
    public init(
        navigationBackImage: UIImage?,
        refreshControllerTintColor: UIColor,
        currentUser: CurrentUser,
        messageCellConfig: MessageCellConfiguration,
        messageInputBarConfig: MessageInputBarConfiguration,
        avatar: AvatarImage
    ) {
        self.navigationBackImage = navigationBackImage
        self.refreshControllerTintColor = refreshControllerTintColor
        self.currentUser = currentUser
        self.messageCellConfig = messageCellConfig
        self.messageInputBarConfig = messageInputBarConfig
        self.avatar = avatar
    }
}
