//
//  ChatMessagesVC.swift
//  Athdak
//
//  Created by Ahmed Fathy on 01/10/2023.
//

import UIKit
import SocketModule

final public class ChatMessagesVC: MessagesViewController {
        
    private let memberId: Int
    private var messages = [KitMessage]()
    private var messageModel: RoomMessagesModel?
    private let repo: ChatRepository
    
    private var refreshController = UIRefreshControl()
    private let chatService: ChatSocketService
    private let configuration: ChatMessagesConfiguration
    
    public init(
        memberId: Int,
        configuration: ChatMessagesConfiguration,
        chatService: ChatSocketService,
        repository: ChatRepository
    ) {
        self.memberId = memberId
        self.chatService = chatService
        self.configuration = configuration
        self.repo = repository
        super.init(
            nibName: nil,
            bundle: Bundle(
                for: Self.self
            )
        )
    }
    
    required init?(
        coder: NSCoder
    ) {
        fatalError()
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        connect()
        loadDelegates()
        setupCollectionView()
        handleInputBar()
        createRoomIFNeeded()
        listenNewMessage()
    }
    
    private func connect() {
        chatService.connectSocketServer()
    }
    
    func setupNavigation() {
        let item = UIBarButtonItem(
            image: configuration.navigationBackImage,
            style: .plain,
            target: self,
            action: #selector(
                backButtonPressed
            )
        )
        item.tintColor = .black
        self.navigationItem.leftBarButtonItems = [item]
    }
    
    private func setupTitle() {
        let memberName = messageModel?.members?.first?.name ?? ""
        title = memberName
    }
    
    @objc func backButtonPressed(){
        chatService.onExitConnectChat(
            on: ExitConnectionEvent()
        )
        chatService.disConnectSocketServer()
        navigationController?.popViewController(
            animated: true
        )
    }
    
    private func setupCollectionView() {
        messagesCollectionView.backgroundColor = .clear
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnInputBarHeightChanged = true
        refreshController.tintColor = configuration.refreshControllerTintColor
        messagesCollectionView.refreshControl = refreshController
    }
    
    private func loadDelegates() {
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    private func handleInputBar() {
        messageInputBar.delegate = self
        messageInputBar.backgroundView.backgroundColor = configuration.messageInputBarConfig.inpuBackgroundColor
        messageInputBar.inputTextView.backgroundColor = configuration.messageInputBarConfig.inputTextViewBackgroundColor
        messageInputBar.inputTextView.layer.cornerRadius = 5
        
        messageInputBar.sendButton.setTitle(
            "",
            for: .normal
        )
        messageInputBar.sendButton.setImage(
            configuration.messageInputBarConfig.inputSendMessageImage,
            for: .normal
        )
        messageInputBar.sendButton.tintColor = configuration.messageInputBarConfig.inputSendMessageTintColor
    }
    
    // MARK: - APIs
    private func createRoomIFNeeded() {
        messagesCollectionView.lock()
        repo.createChatRoom(
            for: memberId
        ) { [weak self] base in
            guard let self = self else {
                return
            }
            messagesCollectionView.unlock()
            guard let messageModel = base?.data else {
                return
            }
            self.messageModel = messageModel
            DispatchQueue.main.asyncAfter(
                deadline: .now() + 2,
                execute: enterChatRoom
            )
            handleCreationRoom(
                model: messageModel
            )
        }
    }
    
    // MARK: - Load Messages
    private func loadMessages() {
        guard let roomId = messageModel?.room?.id else {
            return
        }
        refreshController.beginRefreshing()
        repo.loadMessages(
            from: roomId,
            messageModel: messageModel
        ) { [weak self] base in
            guard let self = self , let messageModel = base?.data else {
                return
            }
            handleMessagesModel(
                model: messageModel
            )
        }
    }
    
    private func handleCreationRoom(
        model: RoomMessagesModel
    ) {
        self.messageModel = model
        setupTitle()
        
        guard let sender = messageModel?.sender(
            for: configuration.currentUser
        ) else {
            return
        }
        messages.append(
            contentsOf:  model.kitMessages(
                for: sender, with: configuration.messageCellConfig
            ).reversed()
        )
        refreshController.endRefreshing()
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
        }
    }
    
    private func handleMessagesModel(
        model: RoomMessagesModel
    ) {
        self.messageModel = model
        
        guard let sender = messageModel?.sender(
            for: configuration.currentUser
        ) else {
            return
        }
        messages.append(
            contentsOf:  model.kitMessages(
                for: sender, with: configuration.messageCellConfig
            ).reversed()
        )
        
        DispatchQueue.main.async {
            self.messages.isEmpty ? self.messagesCollectionView.scrollToLastItem(
                animated: true
            ):self.messagesCollectionView.reloadDataAndKeepOffset()
            self.refreshController.endRefreshing()
        }
    }
    
    private func enterChatRoom() {
        guard let roomId = messageModel?.room?.id else {
            return
        }
        let openChat = OpenChatSocketData(
            userId: configuration.currentUser.id,
            userType: "User",
            roomID: roomId
        )
        chatService.onConnectChat(
            on: EnterConnectionEvent(),
            connectionChat: openChat
        )
    }
    
    private func sendMessage(
        message: String
    ) {
        guard let reciver = messageModel?.members?.first,
              let roomId = messageModel?.room?.id else {
            return
        }
        let messageData = MessageData(
            roomID: roomId,
            receiverID: reciver.id ?? 0,
            receiverType: "User",
            senderID: configuration.currentUser.id,
            senderType: "User",
            senderName: configuration.currentUser.name,
            avatar: configuration.currentUser.image,
            messageType: "text",
            messageBody: message,
            createdAt: currentDate()
        )
        
        chatService.onSendMessage(
            on: SendMessageConnectionEvent(),
            message: messageData
        )
        //        guard let sender = messageModel?.sender(for: configuration.currentUser) else {return}
        //        appendNewMesaage(message: message, for: sender)
    }
    
    private func appendNewMesaage(
        message: String,
        for sender: SenderType
    ) {
        let kitMessage = KitMessage(
            sender: sender,
            messageId: UUID().uuidString,
            sentDate: Date(),
            kind: .attributedText(
                NSAttributedString(
                    string: message,
                    attributes: [
                        .font:configuration.messageCellConfig.cellFont,
                        .foregroundColor: sender.senderId == messageModel?.otherSender.senderId ? configuration.messageCellConfig.reciverMessageTintColor:configuration.messageCellConfig.senderMessageTintColor
                    ]
                )
            ),
            createAt: currentDate()
        )
        messages.append(
            kitMessage
        )
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem()
    }
    
    private func listenNewMessage() {
        chatService.observeNewMessage(
            on: ReceiveMessageConnectionEvent()
        ) { [weak self] message in
            guard let self = self,
                  let messageBody = message?.messageBody else {
                return
            }
            let sender = (
                message?.senderID == configuration.currentUser.id
            ) ? messageModel?.sender(
                for: configuration.currentUser
            ): messageModel?.otherSender
            
            appendNewMesaage(
                message: messageBody,
                for: sender!
            )
        }
    }
}

extension ChatMessagesVC: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    public var currentSender: SenderType {
        return messageModel?.sender(
            for: configuration.currentUser
        ) ?? Sender(
            senderId: "",
            displayName: ""
        )
    }
    
    public func numberOfSections(
        in messagesCollectionView: MessagesCollectionView
    ) -> Int {
        return messages.count
    }
    
    public func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) -> MessageType {
        return messages[indexPath.section]
    }
    
    public func messageStyle(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(
            message: message
        ) ? .bottomRight:.bottomLeft
        return .bubbleTail(
            tail,
            .curved
        )
    }
    
    public override func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {
        guard !refreshController.isRefreshing,
              messageModel?.messages?.pagination?.isLast() == false else {
            refreshController.endRefreshing(); return
        }
        loadMessages()
    }
    
    public func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) {
        if isFromCurrentSender(
            message: message
        ) {
            avatarView.image = configuration.avatar.senderAvatarImage
        } else {
            avatarView.image = configuration.avatar.reciverAvatarImage
        }
    }
    
    public func textColor(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) -> UIColor {
        isFromCurrentSender(
            message: message
        ) ? configuration.messageCellConfig.senderMessageTintColor:configuration.messageCellConfig.reciverMessageTintColor
    }
    
    
    public func cellBottomLabelAttributedText(
        for message: MessageType,
        at indexPath: IndexPath
    ) -> NSAttributedString? {
        let font = UIFont.boldSystemFont(
            ofSize: 10
        )
        let color = UIColor.darkGray
        return NSAttributedString(
            string: messages[indexPath.section].createAt,
            attributes: [
                .font: font ,
                .foregroundColor: color
            ]
        )
    }
    
    public func cellBottomLabelHeight(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) -> CGFloat {
        return 10
    }
    
    public func backgroundColor(
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) -> UIColor {
        let bubbleColorIngoing = configuration.messageCellConfig.reciverBackgroundColor
        let bubbleColorOutgoing = configuration.messageCellConfig.senderBackgroundColor
        return isFromCurrentSender(
            message: message
        ) ? bubbleColorOutgoing :bubbleColorIngoing
    }
}

// MARK: - Did tap send
extension ChatMessagesVC: InputBarAccessoryViewDelegate {
    
    public func inputBar(
        _ inputBar: InputBarAccessoryView,
        didPressSendButtonWith text: String
    ) {
        sendMessage(
            message: text
        )
        inputBar.inputTextView.text = ""
    }
}
extension ChatMessagesVC {
    func currentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(
            identifier: "en_US"
        )
        
        let currentDate = Date()
        return dateFormatter.string(
            from: currentDate
        )
    }
}
