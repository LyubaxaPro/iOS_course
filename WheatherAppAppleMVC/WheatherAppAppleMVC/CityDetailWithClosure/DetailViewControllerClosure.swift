import UIKit

class DetailViewControllerClosure: UIViewController {
    
    var city: CityViewModel
    let detailView = DetailVIewClosure()
    var closure: ((String) -> ())?
    
    init(city: CityViewModel) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = city.title
        detailView.closure = { [weak self] text in
                    self?.title = text
            self?.getOut(userString: text)
        }
        detailView.configure(with: city)
        view.addSubview(detailView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        detailView.frame = view.frame
    }
    
    private func getOut(userString: String){
        closure?(userString)
        navigationController?.popViewController(animated: true)
    }
}



