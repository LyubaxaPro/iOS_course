import UIKit

final class CollectionRouter {
    private let imagePicker = ImagePicker()
    weak var viewController: UIViewController?
}

extension CollectionRouter: CollectionRouterInput {
    func showImagePicker(output: ImagePickerOutput) {
        imagePicker.output = output
        imagePicker.start(in: viewController)
    }
    
}
