import Foundation

public typealias Parameters = [String: Any]

/// Task of request 
public enum HTTPRequestTask {
    case requestPlain
    case requestBody(Encodable, Parameters = [:])
    case requestParameters(Parameters)
    case requestMultipart(Parameters ,boundary: String, Parameters = [:])
}
