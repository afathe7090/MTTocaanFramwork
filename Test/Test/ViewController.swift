//
//  ViewController.swift
//  Test
//
//  Created by Ahmed Fathy on 26/10/2023.
//

import UIKit
import ChatSocketIO
import SocketModule
import Infrastructure

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let av = AvatarImage(senderAvatarImage: .strokedCheckmark, reciverAvatarImage: .actions)
        let input = MessageInputBarConfiguration(
            inpuBackgroundColor: .blue,
            inputTextViewBackgroundColor: .green,
            inputSendMessageImage: .checkmark,
            inputSendMessageTintColor: .darkGray
        )
        
        let cellConfig = MessageCellConfiguration(
            senderBackgroundColor: .black,
            reciverBackgroundColor: .white,
            senderMessageTintColor: .gray,
            reciverMessageTintColor: .gray,
            cellFont: .systemFont(ofSize: 13, weight: .medium, width: .standard)
        )
        
        let chatConfig = ChatMessagesConfiguration(
            navigationBackImage: .actions,
            refreshControllerTintColor: .red,
            currentUser: .init(id: 10, name: "", image: ""),
            messageCellConfig: cellConfig,
            messageInputBarConfig: input,
            avatar: av
        )
        
        let chatMessage = ChatMessagesVC(
            memberId: 11,
            configuration: chatConfig,
            chatService: DefaultChatSocketService(
                url: URL(
                    string: "http://192.168.1.11:3000/"
                )!
            ),
            repository: ChatRepositoryImplementation()
        )
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigationController?.pushViewController(chatMessage, animated: true)
        }
    }


}

class ChatRepositoryImplementation: ChatRepository {

    func createChatRoom(for memberID: Int, completion: @escaping (ChatSocketIO.BaseResponse<ChatSocketIO.RoomMessagesModel>?) -> Void) {
        let member = Member(id: 1, type: "User", name: "Ah,ed ", image: "")
        let room = Room(id: 10, members: [member], lastMessageBody: "", lastMessageCreatedDt: "")
        let page = Pagination(totalItems: 10, countItems: 10, perPage: 10, totalPages: 1, currentPage: 1, nextPageURL: "", pervPageURL: "")
        
        let messge = Message(
            id: 10,
            isSender: 1,
            body: "New Message ",
            type: "User",
            duration: 10,
            name: "Ahmed",
            createdAt: "now"
        )
        let otherMessage = Message(
            id: 1,
            isSender: 0,
            body: "New Other Message ",
            type: "User",
            duration: 10,
            name: "Ahmed",
            createdAt: "now"
        )
        let messageModel = MessagesModel(pagination: page, data: [otherMessage,messge])
        let roomBase = RoomMessagesModel(room: room, members: [member], messages: messageModel)
        let baseComp = BaseResponse<RoomMessagesModel>.init(key: "", msg: "", count_notifications: 1, data: roomBase)
        completion(baseComp)
    }
    
    func loadMessages(from roomId: Int, messageModel: ChatSocketIO.RoomMessagesModel?, completion: @escaping (ChatSocketIO.BaseResponse<ChatSocketIO.RoomMessagesModel>?) -> Void) {
        
    }
}
