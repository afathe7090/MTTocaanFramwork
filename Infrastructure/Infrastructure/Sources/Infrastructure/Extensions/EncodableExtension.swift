import Foundation

public extension Encodable {
    func prepareBody() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
