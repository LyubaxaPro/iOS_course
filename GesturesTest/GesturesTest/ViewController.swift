import UIKit

protocol MagicViewDelegate: AnyObject {
    func actionEnded()
    func actionBegin()
}

class ViewController: UIViewController {
    private let magicView = MagicView()
    private let progressView = ProgressView()
    private let startButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        progressView.delegate = self
        magicView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.progressView.start()
        }
    
    }
    
    private func setup() {
        view.addSubview(magicView)
        view.addSubview(progressView)
        view.addSubview(startButton)
        
        magicView.translatesAutoresizingMaskIntoConstraints = false
        magicView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        magicView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        magicView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        magicView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        startButton.backgroundColor = .systemIndigo
        startButton.layer.cornerRadius = 8
        startButton.layer.masksToBounds = true
        startButton.setTitle("Start progress", for: .normal)
        startButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

    }
    
    override func  viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        progressView.frame = CGRect(x: 16, y: 48, width: view.bounds.width - 32, height: 40)
        
        startButton.frame = CGRect(x: 16, y: view.bounds.height - 100, width: view.bounds.width - 32, height: 40)
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        progressView.pause()
//    }
    
    @objc
    private func didTapButton() {
        magicView.imageView.image = UIImage(named: "Picture")
        progressView.start()
    }
}

extension ViewController: MagicViewDelegate {
    func actionEnded() {
        progressView.resume()
    }
    
    func actionBegin() {
        progressView.pause()
    }
}

extension ViewController: ProgressViewDelegate {
    func endProgress() {
        magicView.imageView.image = UIImage(named: "Duck")
    }
}

final class MagicView: UIView {
    let imageView = UIImageView()
    private let imageContainerView = UIView()
    weak var delegate: MagicViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "Picture")
        imageView.contentMode = .scaleAspectFit
        
        imageContainerView.addSubview(imageView)
        addSubview(imageContainerView)
        
        layout()
        addRecognizers()
    }
    
    private func layout() {
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageContainerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        imageContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        imageContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo:  imageContainerView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: imageContainerView.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: imageContainerView.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: imageContainerView.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func addRecognizers() {
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        [pinchGestureRecognizer, rotationGestureRecognizer, panGestureRecognizer, tapGestureRecognizer].forEach {
            $0.delegate = self
            imageView.addGestureRecognizer($0)
        }
    }
    
    @objc
    private func handlePinch(pinchGestureRecognizer: UIPinchGestureRecognizer) {
        if  pinchGestureRecognizer.state == .ended {
            self.delegate?.actionEnded()
            return
        }
        
        guard pinchGestureRecognizer.state == .began || pinchGestureRecognizer.state == .changed else {
            return
        }
        
        if pinchGestureRecognizer.state == .began {
            self.delegate?.actionBegin()
        }
        
        pinchGestureRecognizer.view?.transform = (pinchGestureRecognizer.view?.transform.scaledBy(x: pinchGestureRecognizer.scale, y: pinchGestureRecognizer.scale)) ?? .identity
        pinchGestureRecognizer.scale = 1.0
    }
    
    @objc
    private func handleRotation(rotationGestureRecognizer: UIRotationGestureRecognizer) {
        if  rotationGestureRecognizer.state == .ended {
            self.delegate?.actionEnded()
            return
        }
        
        guard rotationGestureRecognizer.state == .began || rotationGestureRecognizer.state == .changed else {
            return
        }
        
        if rotationGestureRecognizer.state == .began {
            self.delegate?.actionBegin()
        }
        
        rotationGestureRecognizer.view?.transform = rotationGestureRecognizer.view?.transform.rotated(by: rotationGestureRecognizer.rotation) ?? .identity
        rotationGestureRecognizer.rotation = 0
    }
    
    @objc
    private func handlePan(panGestureRecognizer: UIPanGestureRecognizer) {
        if panGestureRecognizer.state == .began {
            self.delegate?.actionBegin()
        }
        
        let translation = panGestureRecognizer.translation(in: panGestureRecognizer.view?.superview)
        panGestureRecognizer.view?.center.x += translation.x
        panGestureRecognizer.view?.center.y += translation.y
        panGestureRecognizer.setTranslation(.zero, in: panGestureRecognizer.view)
        
        if  panGestureRecognizer.state == .ended {
            self.delegate?.actionEnded()
            return
        }
    }
    
    @objc
    private func handleTap(tapGestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            tapGestureRecognizer.view?.transform = .identity
            self.imageView.frame = self.bounds
        }
    }
}

extension MagicView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
