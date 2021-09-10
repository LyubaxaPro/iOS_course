import Foundation

protocol CityWebModuleInput {
    var moduleOutput: CityWebModuleOutput? { get }
}

protocol CityWebModuleOutput: AnyObject {
}

protocol CityWebViewInput: AnyObject {
    func loadWebView(with request: URLRequest)
}

protocol CityWebViewOutput: AnyObject {
    func viewDidLoad()
    func didTapRefresh()
}

protocol CityWebInteractorInput: AnyObject {
    func getRequest(with city: String)
}

protocol CityWebInteractorOutput: AnyObject {
    func request(with request: URLRequest)
    func didRecieveError(error: Error)
}

protocol CityWebRouterInput: AnyObject {
}
