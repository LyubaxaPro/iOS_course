import UIKit

protocol ProgressViewDelegate: AnyObject {
    func endProgress()
}

protocol ProgressViewProtocol: AnyObject {
    func start()
    func pause()
    func resume()
}

final class ProgressView: UIView{
    
    weak var delegate: ProgressViewDelegate?
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    private var startTime = CFAbsoluteTimeGetCurrent()
    private var duration: TimeInterval = 10
    private var pauseTime: CFAbsoluteTime?
    
    var displayLink: CADisplayLink?
    
    override func draw(_ rect: CGRect) {
        let cornerRadius: CGFloat = 8
        let backgroundColor = UIColor.systemGray
        let progressColor = UIColor.systemIndigo
        
        UIColor.systemBackground.setFill()
        UIRectFill(rect)
        
        let backgroundPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        backgroundColor.setFill()
        backgroundPath.fill()
        
        guard progress > 0 else {
            return
        }
        
        let progressRect = CGRect(x: 0, y: 0, width: rect.width * progress, height: rect.height)
        let progressPath = UIBezierPath(roundedRect: progressRect, cornerRadius: cornerRadius)
        progressColor.setFill()
        progressPath.fill()
    }
    
    @objc
    private func handleDisplayLink() {
        
        let value = CGFloat((CFAbsoluteTimeGetCurrent() - startTime) / duration)
        
        guard value < 1 else {
            progress = 1
            displayLink?.invalidate()
            displayLink = nil
            self.delegate?.endProgress()
            return
        }
        
        progress = value
    }
}

extension ProgressView: ProgressViewProtocol {
    func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink))
        displayLink?.add(to: .main, forMode: .common)
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    func pause() {
        displayLink?.isPaused = true
        pauseTime = CFAbsoluteTimeGetCurrent()
    }
    
    func resume() {
        displayLink?.isPaused = false
        if let pauseTime = pauseTime {
            startTime += CFAbsoluteTimeGetCurrent() - pauseTime
            self.pauseTime = nil
        }
    }
}
