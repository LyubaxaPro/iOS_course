import Foundation

//View должна сообщить презентеру о действиях пользователя(или о том что она загружена)
//Этот протокол реализуется в презентере

protocol CitiesViewOutput: AnyObject {
    var citiesViewModels: [CityViewModel] { get }
    
    func didLoadView()
    func didPullRefresh()
    func didTapAddButton()
    func didSelectItem(at index: Int)
}

protocol CitiesViewInput: AnyObject {
    func reloadData()
    func addCities()
    func updatePushStatusBannerView(pushStatus: PushStatus)
}

protocol CitiesInteractorInput: AnyObject {
    func load(cities: [CityServiceInfo])
    func loadCity(with name: String)
}

protocol CitiesInteractorOutput: AnyObject {
    func didLoad(cities: [CityResponse])
    func didLoad(city: CityResponse)
    func didRecieveError(error: Error)
}

protocol CitiesRouterInput: AnyObject {
    func openCities()
    func showCity(model: CityViewModel)
}

