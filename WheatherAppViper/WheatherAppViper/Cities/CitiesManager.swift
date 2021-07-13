import Foundation

protocol CitiesManagerDescription: AnyObject {
    func load (cities: [CityServiceInfo], complition: @escaping (Result<[CityResponse], Error>) -> Void)
    func loadCity(with name: String, complition: @escaping (Result<CityResponse, Error>) -> Void)
}

enum NetworkError: Error {
    case unexpected
}

final class CitiesManager: CitiesManagerDescription {
    func load(cities: [CityServiceInfo], complition: @escaping (Result<[CityResponse], Error>) -> Void) {
        let helper = CitiesServiceHelper(cities: cities)
        let urlString = helper.citiesUrl()
        
        guard let url = URL(string: urlString) else {
            complition(.failure(NetworkError.unexpected))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { [weak self] data, _, error in
            
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(NetworkError.unexpected))
                return
            } //превращение из опционала в норм переменную которая имеет тип Data()
            
            let decoder = JSONDecoder()
            
            guard let result = try? decoder.decode(CitiesResponse.self, from: data) else {
                complition(.failure(NetworkError.unexpected))
                return
            }
            
            complition(.success(result.list))
            
        }).resume()
    }
    

    static let shared: CitiesManagerDescription = CitiesManager()
    static let appId = "0772f05ad089e8446cdc4fb29e50593c"
    init(){}
    
    func loadCity(with name: String, complition: @escaping (Result<CityResponse, Error>) -> Void) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&units=metric&APIKEY=\(CitiesManager.appId)") else {
            complition(.failure(NetworkError.unexpected))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(CityResponse.self, from: data) else {
                complition(.failure(NetworkError.unexpected))
                return
            }
            
            complition(.success(result))
        }.resume()
    }

}
