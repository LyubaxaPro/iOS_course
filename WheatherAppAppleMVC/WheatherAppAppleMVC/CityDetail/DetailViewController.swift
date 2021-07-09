import UIKit

class DetailViewController: UIViewController {
    
    var city: CityViewModel
    let detailView = DetailVIew()
    weak var output: DetailViewControllerOutput?
    
    init(city: CityViewModel, output: DetailViewControllerOutput) {
        self.city = city
        self.output = output
        super.init(nibName: nil, bundle: nil)
        detailView.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = city.title
        detailView.configure(with: city)
        view.addSubview(detailView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        detailView.frame = view.frame
    }
}

extension DetailViewController: DetailViewOutput {
    func didLikeTap() {
        print("didLikeTap")
        navigationController?.popViewController(animated: true)
        output?.setUserResponce(userString: "didLikeTap() ==))")
    }
    
    func didDislikeTap() {
        print("didDislikeTap")
        navigationController?.popViewController(animated: true)
        output?.setUserResponce(userString: "didDislikeTap() ==))")
    }
}

