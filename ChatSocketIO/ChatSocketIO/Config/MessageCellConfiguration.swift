//
//  MessageCellConfiguration.swift
//  ChatSocketIO
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import UIKit

public struct MessageCellConfiguration {
    public let senderBackgroundColor: UIColor
    public let reciverBackgroundColor: UIColor
    
    public let senderMessageTintColor: UIColor
    public let reciverMessageTintColor: UIColor
    
    public let cellFont: UIFont
    
    public init(
        senderBackgroundColor: UIColor,
        reciverBackgroundColor: UIColor,
        senderMessageTintColor: UIColor,
        reciverMessageTintColor: UIColor,
        cellFont: UIFont
    ) {
        self.senderBackgroundColor = senderBackgroundColor
        self.reciverBackgroundColor = reciverBackgroundColor
        self.senderMessageTintColor = senderMessageTintColor
        self.reciverMessageTintColor = reciverMessageTintColor
        self.cellFont = cellFont
    }
}
