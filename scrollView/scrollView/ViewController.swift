import UIKit

class ViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView (image: UIImage(named: "ozero"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.frame = view.frame
        scrollView.contentSize = imageView.image?.size ?? .zero
    
    }

}

