import Foundation

extension [String: Any?] {
    var toParameters: Parameters {
        var parametes = [String : Any]()
        forEach { key, value in
            parametes.appendIfValueNotNil(key: key, value: value)
        }
        return parametes
    }
}

extension Dictionary where Self == [String: Any] {
    mutating func appendIfValueNotNil(key: String, value: Any?) {
        if let value {
            if let val = value as? String, !val.isEmpty {
                self[key] = value
            } else {
                self[key] = value
            }
        }
    }
}
