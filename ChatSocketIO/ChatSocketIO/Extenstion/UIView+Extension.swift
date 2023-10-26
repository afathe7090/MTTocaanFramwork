import UIKit

typealias Action = () -> Void

extension UIView {
    
    func lock(frameRect: CGRect = CGRect.zero, color: UIColor = .darkGray) {
        if (viewWithTag(10) != nil) {
            //View is already locked
        }
        else {
            let lockView = UIView()
            
            if frameRect == CGRect.zero{
                lockView.frame = bounds
            }
            else{
                lockView.frame = frameRect
            }
            
            lockView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
            
            lockView.tag = 10
            lockView.alpha = 0.0
            
            let activityIndicator = UIActivityIndicatorView.init(frame: CGRect(x: lockView.center.x, y: lockView.center.y, width: 50, height: 50))
            activityIndicator.style = .large
            activityIndicator.center.x = lockView.center.x
            activityIndicator.center.y = lockView.center.y
            activityIndicator.color = color
            
            activityIndicator.startAnimating()
            
            lockView.addSubview(activityIndicator)
            addSubview(lockView)
            
            UIView.animate(withDuration: 0.2) {
                lockView.alpha = 1.0
            }
        }
    }
    
    func unlock(parentView: UIView? = nil) {
        if let lockView = self.viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }) { finished in
                lockView.removeFromSuperview()
                parentView?.isUserInteractionEnabled = true
            }
        }
    }
}
