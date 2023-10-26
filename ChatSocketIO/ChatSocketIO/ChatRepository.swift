//
//  ChatRepository.swift
//  Athdak
//
//  Created by Ahmed Fathy on 01/10/2023.
//

import Foundation
import Infrastructure

public protocol ChatRepository {
    func createChatRoom(for memberID: Int, completion: @escaping(BaseResponse<RoomMessagesModel>?)-> Void)
    func loadMessages(from roomId: Int,
                      messageModel: RoomMessagesModel?,
                      completion: @escaping(BaseResponse<RoomMessagesModel>?) -> Void)
}
