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
        interactor.load(with: city)
    }
}

extension CityWebPresenter: CityWebInteractorOutput {
}
