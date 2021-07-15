import Foundation

final class CityWebPresenter {
	weak var view: CityWebViewInput?
    weak var moduleOutput: CityWebModuleOutput?

	private let router: CityWebRouterInput
	private let interactor: CityWebInteractorInput
    private let city: String

    init(router: CityWebRouterInput, interactor: CityWebInteractorInput, city: String) {
        self.router = router
        self.interactor = interactor
        self.city = city
    }
}

extension CityWebPresenter: CityWebModuleInput {
}

extension CityWebPresenter: CityWebViewOutput {
    func viewDidLoad() {
        interactor.getRequest(with: city)
    }
    
    func didTapRefresh(){
        interactor.getRequest(with: city)
    }
}

extension CityWebPresenter: CityWebInteractorOutput {
    func request(with request: URLRequest) {
        view?.loadWebView(with: request)
    }
    
    func didRecieveError(error: Error) {
        print(error.localizedDescription)
    }
}
