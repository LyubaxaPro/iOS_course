import Foundation

final class CityWebInteractor {
	weak var output: CityWebInteractorOutput?
    private let manager: CityNetworkManagerDescription = CityNetworkManager.shared
}

extension CityWebInteractor: CityWebInteractorInput {
    func getRequest(with city: String) {
        manager.request(city: city) {[weak self] (result) in
            switch result {
            case .success(let request):
                self?.output?.request(with: request)
            case .failure(let error):
                self?.output?.didRecieveError(error: error)
            }
        }
    }
}
