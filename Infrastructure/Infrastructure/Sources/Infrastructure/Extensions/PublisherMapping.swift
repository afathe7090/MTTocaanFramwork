import Foundation
import Combine

public extension Publisher where Output == (Data, HTTPURLResponse)  {
    func map<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        return tryMap({ try $0.0.decode(to: type.self) }).eraseToAnyPublisher()
    }
}
