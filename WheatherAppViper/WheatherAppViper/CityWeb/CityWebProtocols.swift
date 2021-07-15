import Foundation

protocol CityWebModuleInput {
	var moduleOutput: CityWebModuleOutput? { get }
}

protocol CityWebModuleOutput: class {
}

protocol CityWebViewInput: class {
}

protocol CityWebViewOutput: class {
    func viewDidLoad()
}

protocol CityWebInteractorInput: class {
    func load(with city: String)
}

protocol CityWebInteractorOutput: class {
}

protocol CityWebRouterInput: class {
}
