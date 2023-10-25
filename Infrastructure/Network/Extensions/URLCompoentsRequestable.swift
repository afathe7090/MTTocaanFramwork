import Foundation

public extension URLComponents {
    init?(requester: Requestable) {
        let url = requester.baseUrl.appendingPathComponent(requester.path)
        self.init(url: url, resolvingAgainstBaseURL: false)
        
        // Parameters
        if case let HTTPRequestTask.requestBody(_, parameter) = requester.task {
            if parameter.isEmpty { return }
            queryItems = parameter.map(QueryItemsParamaterMapper.map)
        }

        if case let HTTPRequestTask.requestParameters(parameter) = requester.task {
            if parameter.isEmpty { return }
            queryItems = parameter.map(QueryItemsParamaterMapper.map)
        }
        
        if case let HTTPRequestTask.requestMultipart(_, _, parameter) = requester.task {
            if parameter.isEmpty { return }
            queryItems = parameter.map(QueryItemsParamaterMapper.map)
        }
    }
}
