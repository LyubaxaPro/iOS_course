import UIKit
import PinLayout
import Kingfisher

class DetailVIew: UIView {
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let containerView = UIView()
    private let likeButton = UIButton()
    private let dislikeButton = UIButton()
    
    weak var output: DetailViewOutput?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        backgroundColor = .systemTeal
        containerView.clipsToBounds = true
        temperatureLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        descriptionLabel.font = .systemFont(ofSize: 20, weight: .light)
        likeButton.setTitle("Like", for: .normal)
        dislikeButton.setTitle("Dislike", for: .normal)
        likeButton.backgroundColor = .red
        dislikeButton.backgroundColor = .purple
        likeButton.addTarget(self, action: #selector(didLikeTap), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(didDislikeTap), for: .touchUpInside)
            
        [iconImageView, temperatureLabel, descriptionLabel, likeButton, dislikeButton].forEach {
                    containerView.addSubview($0)
            
        }
        self.addSubview(containerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.pin
                    .left(15)
                    .right(15)
                    .top(80)
                    .bottom(8)
        
        iconImageView.pin
            .top(5)
            .size(130)
            .hCenter()
        
        temperatureLabel.pin
            .below(of: iconImageView)
            .sizeToFit()
            .hCenter()
        
        descriptionLabel.pin
            .below(of: temperatureLabel)
            .sizeToFit()
            .hCenter()
        
        likeButton.pin
            .below(of: descriptionLabel)
            .marginTop(10)
            .left(20)
            .sizeToFit()
        
        dislikeButton.pin
            .below(of: descriptionLabel)
            .marginTop(10)
            .right(20)
            .sizeToFit()
            
    }
    
    func configure(with model: CityViewModel){
        let urlString: String =  "https://openweathermap.org/img/wn/" + model.imageName + "@2x.png"
        iconImageView.kf.setImage(with: URL(string: urlString))
        temperatureLabel.text = "\(model.temperature) °C"
        descriptionLabel.text = model.description
    }
    
    @objc private func didLikeTap(){
        output?.didLikeTap()
    }
    
    @objc private func didDislikeTap(){
        output?.didDislikeTap()
    }
}
