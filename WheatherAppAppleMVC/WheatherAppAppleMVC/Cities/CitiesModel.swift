import Foundation

protocol CitiesModelOutput: AnyObject {
    func didLoad(cities: [CityResponse])
}

final class CitiesModel {
    
    weak var output: CitiesModelOutput?
    func load(cities: [CityServiceInfo]){
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

            
            DispatchQueue.main.async {
                self?.output?.didLoad(cities: result.list)
            }
            
        }).resume()
    }
}

