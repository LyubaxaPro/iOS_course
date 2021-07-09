import Foundation

protocol GreetingViewProtocol: AnyObject {
    func setNewGreeting(greeting: String)
}

protocol  GreetingPresenterProtocol:  AnyObject {
    init (view: GreetingViewProtocol)
    func didGreetingButtonTap()
}

protocol ModelOutput: AnyObject {
    func didLoad(info: PersonInfo)
}
