import Foundation
import Combine

public extension DispatchQueue {
    
    static var immediateWhenOnMainQuesueScheduler: ImmediateWhenOnMainQuesueScheduler {
        ImmediateWhenOnMainQuesueScheduler()
    }
    
    struct ImmediateWhenOnMainQuesueScheduler: Scheduler {
     
        public typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
        public typealias SchedulerOptions = DispatchQueue.SchedulerOptions
        
        public var now: DispatchQueue.SchedulerTimeType {
            DispatchQueue.main.now
        }
        
        public var minimumTolerance: DispatchQueue.SchedulerTimeType.Stride {
            DispatchQueue.main.minimumTolerance
        }
        
        public func schedule(options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) {
            guard Thread.isMainThread else {
                return DispatchQueue.main.async(execute: action)
            }
            action()
        }
        
        public func schedule(after date: DispatchQueue.SchedulerTimeType, tolerance: DispatchQueue.SchedulerTimeType.Stride, options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) {
            DispatchQueue.main.schedule(after: date, tolerance: tolerance, options: options, action)
        }
        
        public func schedule(after date: DispatchQueue.SchedulerTimeType, interval: DispatchQueue.SchedulerTimeType.Stride, tolerance: DispatchQueue.SchedulerTimeType.Stride, options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
            DispatchQueue.main.schedule(after: date, interval: interval, tolerance: tolerance, options: options, action)
        }
        
    }
}
