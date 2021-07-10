import Foundation

final class CitiesInteractor {
    weak var output: CitiesInteractorOutput?
}

extension CitiesInteractor: CitiesInteractorInput {
    func load(cities: [CityServiceInfo]) {
        let helper = CitiesServiceHelper(cities: cities)
        let urlString = helper.citiesUrl()
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { [weak self] data, _, error in
            guard let data = data else {
                return
            } //превращение из опционала в норм переменную которая имеет тип Data()
            
            let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode(CitiesResponse.self, from: data) else {
                return
            }
            print(result.list)
            
            DispatchQueue.main.async {
                self?.output?.didLoad(cities: result.list)
            }
            
        }).resume()
    }
}
