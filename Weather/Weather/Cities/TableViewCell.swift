import UIKit
import PinLayout

final class CityTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let dateUpdatedLabel = UILabel()
    private let iconImageButton = CustomTouchAreaButton()
    private let temperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
        backgroundColor = .white
        contentView.backgroundColor = .white
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.cornerRadius = 8
        
        selectionStyle = .none
        
        titleLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        dateUpdatedLabel.textColor = .darkGray
        temperatureLabel.font = .systemFont(ofSize: 48, weight: .medium)
        iconImageButton.addTarget(self, action: #selector(DidTapIconImageButton), for: .touchUpInside)
        
        [titleLabel, dateUpdatedLabel, iconImageButton, temperatureLabel].forEach{
            contentView.addSubview($0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.pin
            .horizontally(12)
            .vertically(18)
        
        titleLabel.pin
            .bottom(8)
            .left(12)
            .height(40)
            .sizeToFit(.height)
        
        dateUpdatedLabel.pin
            .above(of: titleLabel)
            .left(12)
            .height(20)
            .sizeToFit(.height)
        
        iconImageButton.pin
            .size(24)
            .after(of: dateUpdatedLabel)
            .marginLeft(8)
        
        temperatureLabel.pin
            .right(12)
            .height(64)
            .sizeToFit(.height)
            .vCenter()
    }
    
    func configure(with model: CityViewModel){
        titleLabel.text = model.title
        dateUpdatedLabel.text =  model.dateUpdated
        iconImageButton.setImage(UIImage(systemName: model.systemImageName), for: .normal)
        temperatureLabel.text = "\(model.temperature) C"
    }
    
    @objc
    private func DidTapIconImageButton() {
        print("hello")
    }
}

final class CustomTouchAreaButton : UIButton {
    private var touchableArea = CGSize(width: 44, height: 44)
    
    convenience init(touchableArea: CGSize = CGSize(width: 44, height: 44)) {
        self.init()
        self.touchableArea = touchableArea
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let dWidth = touchableArea.width - bounds.width
        let dHeight = touchableArea.height - bounds.height
        
        let rect = CGRect(x: (bounds.minX - dWidth) / 2,
                          y: (bounds.minY - dHeight) / 2,
                          width: touchableArea.width,
                          height: touchableArea.height)
        return rect.contains(point)
            
    }
}
