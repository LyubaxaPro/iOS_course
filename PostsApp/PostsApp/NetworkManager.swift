import Foundation

protocol NetworkManagerDescription: AnyObject {
    func posts(completion: @escaping (Result<[Post], Error>) -> Void)
}

enum NetworkError: Error {
    case unexpected
}

final class NetworkManager: NetworkManagerDescription {
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}
    
    func posts(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(.failure(NetworkError.unexpected))
            return
        } 
        
        URLSession.shared.dataTask(with: url) {(data, responce, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.unexpected))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data)
                completion(.success(posts))
            } catch let error {
                print("Parsing Failed \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
        
    }
}
