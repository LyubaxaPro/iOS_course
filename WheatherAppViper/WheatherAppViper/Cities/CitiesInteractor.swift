import Foundation

final class CitiesInteractor {
    weak var output: CitiesInteractorOutput?
    private let networkManager: CitiesManagerDescription = CitiesManager.shared
}

extension CitiesInteractor: CitiesInteractorInput {
    
    func loadCity(with name: String) {
        networkManager.loadCity(with: name) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let city):
                    self?.output?.didLoad(city: city)
                case .failure(let error):
                    self?.output?.didRecieveError(error: error)
                }
            }
        }
    }
    
    func load(cities: [CityServiceInfo]) {
        networkManager.load(cities: cities) {[weak self] (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let cities):
                    self?.output?.didLoad(cities: cities)
                case .failure(let error):
                    self?.output?.didRecieveError(error: error)
                }
            }
        }
    }
}
