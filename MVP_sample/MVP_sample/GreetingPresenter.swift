import Foundation

class GreetingPresenter: GreetingPresenterProtocol {
    let model = PersonModel()
    weak var view: GreetingViewProtocol?
    
    required init(view: GreetingViewProtocol) {
        self.model.output = self
        self.view = view
    }
    
    func didGreetingButtonTap() {
        self.model.load()
    }
}

extension GreetingPresenter: ModelOutput {
    func didLoad(info: PersonInfo) {
        self.view?.setNewGreeting(greeting: "Hello \(info.name)")
    }
}
