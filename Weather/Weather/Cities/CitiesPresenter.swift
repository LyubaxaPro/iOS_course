import Foundation

final class CitiesPresenter {
    private var cityServiceInfos: [CityServiceInfo] = [
        CityServiceInfo(name: "Moskow", id: "524901"),
        CityServiceInfo(name: "Tambov", id: "484646"),
        CityServiceInfo(name: "Cheboksary", id: "569696")
    ]
    weak var view: CitiesViewInput?
    let interactor: CitiesInteractorInput
    
    private ( set ) var citiesViewModels: [CityViewModel] = []
    let router: CitiesRouterInput
    
    private let pushManager: PushManagerDescription = PushManager.shared
    
    init (interactor: CitiesInteractorInput, router: CitiesRouterInput){
        self.interactor = interactor
        self.router = router
    }
    
    private func viewModel (from city: CityResponse) -> CityViewModel {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return CityViewModel(title: city.name,
                             temperature: String(Int(round(city.main.temp))),
                             dateUpdated: dateFormatter.string(from: Date()),
                             systemImageName: "pencil")
    }
}

extension CitiesPresenter: CitiesViewOutput {
    func didSelectItem(at index: Int) {
        router.showCity(model: citiesViewModels[index])
    }
    
    func didLoadView() {
        interactor.load(cities: cityServiceInfos)
        
        pushManager.add(observer: self)
        pushManager.requestAuth()
    }
    
    func didPullRefresh() {
        interactor.load(cities: cityServiceInfos)
    }
    
    func didTapAddButton() {
        interactor.loadCity(with: "Belgorod")
        //router.openCities()
    }
}

extension CitiesPresenter: CitiesInteractorOutput {
    func didLoad(city: CityResponse) {
        citiesViewModels.append(viewModel(from: city))
        self.view?.addCities()
    }
    
    func didRecieveError(error: Error) {
        print(error)
    }
    
    func didLoad(cities: [CityResponse]) {
        
        self.citiesViewModels = cities.map { viewModel(from: $0) }
        
        self.view?.reloadData()
    }
}

extension CitiesPresenter: PushStatusObserver {
    func didChange(status: PushStatus) {
        view?.updatePushStatusBannerView(pushStatus: status)
    }
}
