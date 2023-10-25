import Foundation

public struct QueryItemsParamaterMapper {
    static func map(key: String, value: Any) -> URLQueryItem {
        URLQueryItem(name: key, value: String(describing: value))
    }
}
