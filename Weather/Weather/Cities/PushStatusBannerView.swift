import UIKit
import PinLayout

final class PushStatusBannerView: UIView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Push status unknown"
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 0.5
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.shadowOpacity = 0.8
        layer.cornerRadius = 8
        backgroundColor = UIColor.white
        
        addSubview(label)
    }
    
    func update(with status: PushStatus) {
        label.text = "Push status - \(status.rawValue)"
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.pin
            .top(12)
            .left(12)
            .height(24)
            .sizeToFit(.height)
    }
}

