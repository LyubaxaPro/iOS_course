import UIKit

protocol SomeViewDelegate: class {
    var textForLabel: String { get }
    func didTapLabel()
}

class ViewController: UIViewController{
    private lazy var someView = SomeView(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(someView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        someView.frame = view.frame
    }
}

extension ViewController: SomeViewDelegate{
    func didTapLabel() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        present(viewController, animated: true, completion: nil)
    }

    var textForLabel: String {"Some text from ViewController"}
}

final class SomeView: UIView {
    private let textLabel = UILabel()
    weak var delegate: SomeViewDelegate?

    init(delegate: SomeViewDelegate) {
        super.init(frame: .zero)
        self.delegate = delegate

        setup()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(){
        textLabel.backgroundColor = .red
        textLabel.text = delegate?.textForLabel
        textLabel.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
        textLabel.addGestureRecognizer(gestureRecognizer)
        addSubview(textLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        textLabel.frame = CGRect(x: 20, y: 80, width: 400, height: 40)
    }

    @objc private func didTapLabel(){
        delegate?.didTapLabel()
    }
}
























