import UIKit

final class CollectionInteractor {
    private let postsManager: PostsManagerDescription = PostsManager.shared
	weak var output: CollectionInteractorOutput?
    private let imageLoader: ImageLoaderDescription = ImageLoader.shared
    
    private func create(post: NewPost) {
        postsManager.create(post: post) {[weak self] (error) in
            error.map { self?.output?.didReceive(error: $0)}
        }
    }
}

extension CollectionInteractor: CollectionInteractorInput {
    func create(with image: UIImage, title: String) {
        imageLoader.upload(image: image) {[weak self] (result) in
            switch(result){
            case .success(let name):
                self?.create(post: NewPost(title: title, image: name))
            case .failure(let error):
                self?.output?.didReceive(error: error)
            }
            
        }
    }
    
    func observePosts() {
        postsManager.observePosts {[weak self] (result) in
            switch(result) {
            case .success(let posts):
                self?.output?.didLoad(posts: posts)
            case .failure(let error):
                self?.output?.didReceive(error: error)
            }
            
        }
    }
    
}
