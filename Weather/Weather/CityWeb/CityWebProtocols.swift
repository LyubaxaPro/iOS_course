import Foundation

protocol CityWebModuleInput {
    var moduleOutput: CityWebModuleOutput? { get }
}

protocol CityWebModuleOutput: class {
}

protocol CityWebViewInput: class {
    func loadWebView(with request: URLRequest)
}

protocol CityWebViewOutput: class {
    func viewDidLoad()
    func didTapRefresh()
}

protocol CityWebInteractorInput: class {
    func getRequest(with city: String)
}

protocol CityWebInteractorOutput: class {
    func request(with request: URLRequest)
    func didRecieveError(error: Error)
}

protocol CityWebRouterInput: class {
}
