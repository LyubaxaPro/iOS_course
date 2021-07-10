import Foundation

//View должна сообщить презентеру о действиях пользователя(или о том что она загружена)
//Этот протокол реализуется в презентере

protocol CitiesViewOutput: AnyObject {
    var citiesViewModels: [CityViewModel] { get }
    
    func didLoadView()
    func didPullRefresh()
    func didTapAddButton()
}

protocol CitiesViewInput: AnyObject {
    func reloadData()
}

protocol CitiesInteractorInput: AnyObject {
    func load(cities: [CityServiceInfo])
}

protocol CitiesInteractorOutput: AnyObject {
    func didLoad(cities: [CityResponse])
}

protocol CitiesRouterInput: AnyObject {
    func openCities()
}
