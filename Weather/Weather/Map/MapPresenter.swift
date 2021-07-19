import Foundation

final class MapPresenter {
    weak var view: MapViewInput?
    weak var moduleOutput: MapModuleOutput?

    private let router: MapRouterInput
    private let interactor: MapInteractorInput

    init(router: MapRouterInput, interactor: MapInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MapPresenter: MapModuleInput {
}

extension MapPresenter: MapViewOutput {
}

extension MapPresenter: MapInteractorOutput {
}
