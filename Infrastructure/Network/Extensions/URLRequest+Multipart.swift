import Foundation

extension URLRequest {
    func multiPart(withParameters params: [String: Any]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()

        if let parameters = params {
            for (key, value) in parameters {

                if let value = value as? Data {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data;"
                                + "name=\"\(key)\"; "
                                + "filename=\"\(UUID().uuidString).jpeg\"\(lineBreak)")
                    body.append("Content-Type: image/jpeg" + lineBreak + lineBreak)
                    body.append(value)
                    body.append(lineBreak)

                } else if let value = value as? String {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                    body.append("\(value + lineBreak)")

                } else if let value = value as? NSNumber {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                    body.append("\(value)" + lineBreak)
                }

            }
        }

        body.append("--\(boundary)--\(lineBreak)")

        return body
    }
}
