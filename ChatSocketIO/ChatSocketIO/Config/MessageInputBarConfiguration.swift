//
//  MessageInputBarConfiguration.swift
//  ChatSocketIO
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import UIKit

public struct MessageInputBarConfiguration {
    public let inpuBackgroundColor: UIColor
    public let inputTextViewBackgroundColor: UIColor
    public let inputSendMessageImage: UIImage
    public let inputSendMessageTintColor: UIColor
    
    public init(
        inpuBackgroundColor: UIColor,
        inputTextViewBackgroundColor: UIColor,
        inputSendMessageImage: UIImage,
        inputSendMessageTintColor: UIColor
    ) {
        self.inpuBackgroundColor = inpuBackgroundColor
        self.inputTextViewBackgroundColor = inputTextViewBackgroundColor
        self.inputSendMessageImage = inputSendMessageImage
        self.inputSendMessageTintColor = inputSendMessageTintColor
    }
}
