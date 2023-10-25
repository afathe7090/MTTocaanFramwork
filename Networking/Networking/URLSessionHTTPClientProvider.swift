import Foundation
import Combine

public struct URLSessionHTTPClientProvider: HTTPClient {
    
    public struct InvalidHTTPRespnseError: Error {}
    private let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    /// Method Request
    /// - Parameters:
    ///   - requester:  It takes a URLRequest the need to Handle Manual Reuest
    ///   - completion: Response of request
    /// - Returns: HTTPClientTask -> Protocol that used to access spacific Task to can cancel Request
    @discardableResult
    public func perform(urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            // Logg Network
            LoggerNetwork.logNetwork(urlRequest: urlRequest, response: response as? HTTPURLResponse, dataResponse: data ?? Data())
            completion(Result {
                guard let data = data, let response = response as? HTTPURLResponse else {
                    throw InvalidHTTPRespnseError()
                }
                return (data, response)
            })
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
    /// Method Request
    /// - Parameters:
    ///   - requester: It is an protocol that confirm all full Request handlers
    ///   - completion: Response of request
    /// - Returns: HTTPClientTask -> Protocol that used to access spacific Task to can cancel Request
    @discardableResult
    public func perform(requester: Requestable, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        perform(urlRequest: URLRequest(requester: requester), completion: completion)
    }
    /// Publisher Request
    /// Logic of Decoding should be separated from Network Layer ,so Map your data outside network layer
    /// - Parameter requester: It is an protocol that confirm all full Request handlers
    /// - Returns: ( Data & HTTPURLResponse )
    /// - NOTE: Network Layer shoud not decode your data, you can Map it In your custom decode or using "decode()" method in Combine Network
    public func perform(urlRequest: URLRequest) -> ResultRequest {
        session.dataTaskPublisher(for: urlRequest).tryMap { result in
            // Log Network
            LoggerNetwork.logNetwork(urlRequest: urlRequest, response: result.response as? HTTPURLResponse, dataResponse: result.data)
            guard let response = result.response as? HTTPURLResponse else {
                throw InvalidHTTPRespnseError()
            }
            return (result.data, response)
        }
        .eraseToAnyPublisher()
    }
    /// Publisher Request
    /// - Parameter urlRequest: It takes a URLRequest the need to Handle Manual Reuest
    /// - Returns: ( Data & HTTPURLResponse )
    /// - NOTE: Network Layer shoud not decode your data, you can Map it In your custom decode or using "decode()" method in Combine Network
    public func perform(requester: Requestable) -> ResultRequest {
         perform(urlRequest: URLRequest(requester: requester))
    }
}
