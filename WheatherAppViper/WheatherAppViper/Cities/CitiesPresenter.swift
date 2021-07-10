import Foundation

final class CitiesPresenter {
    private var cityServiceInfos: [CityServiceInfo] = [
        CityServiceInfo(name: "Moskow", id: "524901"),
        CityServiceInfo(name: "Tambov", id: "484646"),
        CityServiceInfo(name: "Cheboksary", id: "569696")
    ]
    weak var view: CitiesViewInput? 
    let interactor: CitiesInteractorInput
    //массив вью моделей
    private ( set ) var citiesViewModels: [CityViewModel] = []
    let router: CitiesRouterInput
    
    init (interactor: CitiesInteractorInput, router: CitiesRouterInput){
        self.interactor = interactor
        self.router = router
    }
}

extension CitiesPresenter: CitiesViewOutput {
    func didLoadView() {
        interactor.load(cities: cityServiceInfos)
    }
    
    func didPullRefresh() {
        interactor.load(cities: cityServiceInfos)
    }
    
    func didTapAddButton() {
        router.openCities()
    }
}

extension CitiesPresenter: CitiesInteractorOutput {
    func didLoad(cities: [CityResponse]) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        self.citiesViewModels = cities.map { city in
            return CityViewModel(title: city.name,
                                 temperature: String(Int(round(city.main.temp))),
                                 dateUpdated: dateFormatter.string(from: Date()),
                                 systemImageName: "pencil")
        }
        
        self.view?.reloadData()
    }
}
