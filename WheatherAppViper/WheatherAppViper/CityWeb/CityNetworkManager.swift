import Foundation

protocol CityNetworkManagerDescription: AnyObject {
    func request(city: String, complition: @escaping (Result<URLRequest, Error>)-> Void)
}

final class CityNetworkManager: CityNetworkManagerDescription {
    static var shared: CityNetworkManagerDescription = CityNetworkManager()
    private init(){}
    
    func request(city: String, complition: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let url = URL(string:"https://yandex.ru/pogoda/\(city)") else {
            complition(.failure(NetworkError.unexpected))
            return
        }
        
        let myRequest = URLRequest(url: url)
        complition(.success(myRequest))
    }
}
