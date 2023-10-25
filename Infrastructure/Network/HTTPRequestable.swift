import Foundation

public typealias Headers = [String: String]

public protocol Requestable {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethods { get }
    var task: HTTPRequestTask { get }
    var headers: Headers? { get }
}
