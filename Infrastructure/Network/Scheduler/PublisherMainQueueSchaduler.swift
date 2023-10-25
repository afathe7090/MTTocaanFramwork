import Combine
import Foundation

public extension Publisher {
    /// DispatchQueue in Main thread if needed 
    /// - Returns: AnyPublisher<Output, Failure>
    func dispatchOnMainQueue() -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.immediateWhenOnMainQuesueScheduler).eraseToAnyPublisher()
    }
}
