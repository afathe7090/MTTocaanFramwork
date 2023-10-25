import Foundation
import Combine

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    typealias ResultRequest = AnyPublisher<(Data, HTTPURLResponse), Error>
    /// Method Request
    /// - Parameters:
    ///   - requester:  It takes a URLRequest the need to Handle Manual Reuest
    ///   - completion: Response of request
    /// - Returns: HTTPClientTask -> Protocol that used to access spacific Task to can cancel Request
    @discardableResult
    func perform(urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask
    /// Method Request
    /// - Parameters:
    ///   - requester: It is an protocol that confirm all full Request handlers
    ///   - completion: Response of request
    /// - Returns: HTTPClientTask -> Protocol that used to access spacific Task to can cancel Request
    @discardableResult
    func perform(requester: Requestable, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask
    /// Publisher Request
    /// Logic of Decoding should be separated from Network Layer ,so Map your data outside network layer
    /// - Parameter requester: It is an protocol that confirm all full Request handlers
    /// - Returns: ( Data & HTTPURLResponse )
    /// - NOTE: Network Layer shoud not decode your data, you can Map it In your custom decode or using "decode()" method in Combine Network
    func perform(requester: Requestable) -> ResultRequest
    /// Publisher Request
    /// - Parameter urlRequest: It takes a URLRequest the need to Handle Manual Reuest
    /// - Returns: ( Data & HTTPURLResponse )
    /// - NOTE: Network Layer shoud not decode your data, you can Map it In your custom decode or using "decode()" method in Combine Network
    func perform(urlRequest: URLRequest) -> ResultRequest
}
