import Foundation

public extension Data {
    func decode<T: Decodable>(to type: T.Type) throws -> T  {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: self)
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
