import Foundation

protocol DetailViewOutput : AnyObject {
    func didLikeTap()
    func didDislikeTap()
}

protocol DetailViewControllerOutput: AnyObject {
    func setUserResponce(userString: String)
}

