import Foundation

struct LoggerNetwork {
    private init() { }
    static func logNetwork(
        urlRequest: URLRequest,
        response: HTTPURLResponse?,
        dataResponse: Data
    ) {
        #if DEBUG
        print("🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️ Request 🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️")
        print("🔗🔗🔗 URL: \(String(describing: urlRequest.url))")
        print("👉👉👉 methods: \(String(describing: urlRequest.httpMethod))")
        print("⏰⏰⏰ Headers: \(String(describing: urlRequest.allHTTPHeaderFields))")

        let body = try? JSONSerialization.jsonObject(
            with: urlRequest.httpBody ?? Data(),
            options: .fragmentsAllowed
        )
        print("🧠🧠🧠 Body: \(String(describing: body))")

        if let response {
            print("📲📲📲 StatusCode: \(response.statusCode), description: \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
            print("⏰⏰⏰ Headers_Response: \(String(describing: response.allHeaderFields))")

        }

        let json = try? JSONSerialization.jsonObject(with: dataResponse, options: .fragmentsAllowed)
        print("✅✅✅ ResponseData: \(String(describing: json))")
        print("🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️ End Request 🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️🏋️‍♀️")
        #endif
    }
}
