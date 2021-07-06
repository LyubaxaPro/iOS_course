import UIKit

protocol SomeViewDelegate: AnyObject {
    func didTapLabel()
}

protocol SomeViewDataSource: AnyObject {
    func getImage() -> UIImage?
    func getText() -> String
}

class ViewController: UIViewController {
    
    private let someView = SomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(someView)
        someView.frame = view.frame
        someView.datasource = self
        someView.delegate = self
        
    }
}

extension ViewController: SomeViewDataSource {
    func getImage() -> UIImage? {
        return UIImage(named: "ozero")
    }
    
    func getText() -> String {
        return "text for title from dataSourse"
    }
}

extension ViewController: SomeViewDelegate {
    func didTapLabel() {
        print("TAP TAP TAP")
    }
}

final class SomeView: UIView {
    
    private let image = UIImageView()
    private let titleLabel = UILabel()
    
    weak var delegate: SomeViewDelegate?
    weak var datasource: SomeViewDataSource? {
        didSet {
            titleLabel.text = datasource?.getText()
            image.image = datasource?.getImage()
        }
    }
    
    override init (frame: CGRect){
        super.init(frame: frame)
        
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        titleLabel.backgroundColor = .red
        //titleLabel.text = datasource?.getText()
//        image.image = datasource?.getImage()
        
        titleLabel.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
        titleLabel.addGestureRecognizer(gestureRecognizer)
        
        addSubview(image)
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 40, y: 90, width: 400, height: 40)
        image.frame = frame
    }
    
    @objc private func didTapLabel(){
        delegate?.didTapLabel()
    }

}
