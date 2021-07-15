import UIKit

final class CollectionPresenter {
	weak var view: CollectionViewInput?
    weak var moduleOutput: CollectionModuleOutput?

	private let router: CollectionRouterInput
	private let interactor: CollectionInteractorInput
    
    private var items: [CollectionItem] = []

    init(router: CollectionRouterInput, interactor: CollectionInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func collectionItem (from post: Post) -> CollectionItem {
        return PostViewModel(title: post.title, image: post.image)
    }
}

extension CollectionPresenter: CollectionModuleInput {
}

extension CollectionPresenter: CollectionViewOutput {
    func didTapCreateButton() {
//        let post = NewPost(title: "NewPost", image: "")
//        interactor.create(post: post)
        router.showImagePicker(output: self)
    }
    
    func didLoadView() {
        interactor.observePosts()
    }
    
    var itemsCount: Int {
        return items.count
    }
    
    func item(at index: Int) -> CollectionItem {
        return items[index]
    }
    
}

extension CollectionPresenter: CollectionInteractorOutput {
    func didLoad(posts: [Post]) {
        self.items = posts.map { collectionItem(from: $0) }
        view?.reloadData()
    }
    
    func didReceive(error: Error) {
        print(error)
    }
}

extension CollectionPresenter: ImagePickerOutput {
    func didSelect(image: UIImage?) {
        guard let image = image else {
            return
        }
        
        interactor.create(with: image, title: "Test title")
    }
}
