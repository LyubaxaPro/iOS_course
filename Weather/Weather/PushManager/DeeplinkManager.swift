import UIKit

protocol DeeplinkManagerDescription {
    func process(url: URL?)
    var navigationController: UINavigationController? {get set}
}

final class DeeplinkManager {
    static let shared: DeeplinkManagerDescription = DeeplinkManager()
    private init(){}
    weak var navigationController: UINavigationController?
}

extension DeeplinkManager: DeeplinkManagerDescription {
    func process(url: URL?) {
        guard let url = url else {
            return
        }
        
        guard let queryParams = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = queryParams.queryItems,
              !queryItems.isEmpty else {
            return
        }
        
        guard let screen = queryItems.first(where: {
            $0.name == "screen"
        }) else {
            return
        }
        
        guard let name = queryItems.first(where: {
            $0.name == "name"
        }) else {
            return
        }
        
        let viewController = UIViewController()

        viewController.title = name.value
        viewController.view.backgroundColor = .blue
        let tnavigationController = UINavigationController(rootViewController: viewController)

        navigationController?.present(tnavigationController, animated: true, completion: nil)
    }
}
