import UIKit
import PinLayout

final class PersonTableViewCell: UITableViewCell {
    
    let nameLable: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(nameLable)
        nameLable.text = "Test"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLable.pin
            .left(20)
            .right(20)
            .vCenter()
            .sizeToFit()
    }
    
    func configure(with name: String) {
        nameLable.text = name
    }
}
