import UIKit

typealias CollectionItem = PostViewModel

protocol CollectionModuleInput {
	var moduleOutput: CollectionModuleOutput? { get }
}

protocol CollectionModuleOutput: AnyObject {
}

protocol CollectionViewInput: AnyObject {
    func reloadData()
}

protocol CollectionViewOutput: AnyObject {
    var itemsCount: Int { get }
    func item(at index: Int) -> CollectionItem
    func didLoadView()
    func didTapCreateButton()
    
}

protocol CollectionInteractorInput: AnyObject {
    func observePosts()
    func create(with image: UIImage, title: String)
}

protocol CollectionInteractorOutput: AnyObject {
    func didLoad(posts: [Post])
    func didReceive(error: Error)
}

protocol CollectionRouterInput: AnyObject {
    func showImagePicker(output: ImagePickerOutput)
}
