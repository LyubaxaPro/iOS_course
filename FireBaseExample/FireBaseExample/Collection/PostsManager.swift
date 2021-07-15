import Foundation
import FirebaseFirestore

protocol  PostsManagerDescription {
    func create(post: NewPost, complition: @escaping (Error?) -> Void)
    func observePosts(complition: @escaping (Result<[Post], Error>) -> Void)
}

enum NetworkError: Error {
    case unexpected
}

final class PostsManager: PostsManagerDescription {
    
    static let shared: PostsManagerDescription = PostsManager()
    private let database = Firestore.firestore()
    
    init(){}
    
    func observePosts(complition: @escaping (Result<[Post], Error>) -> Void) {
        database.collection("posts").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                complition(.failure(NetworkError.unexpected))
                return
            }
            let posts = documents.compactMap { PostConverter.post(from: $0)}
            complition(.success(posts))
        }
    }
    
    func create(post: NewPost, complition: @escaping (Error?) -> Void) {
        let data = PostConverter.dict(from: post)
        database.collection("posts").addDocument(data: data, completion: complition)
    }
}

private final class PostConverter {
    enum Key: String{
        case title
        case indentifier
        case image
    }
    
    static func post(from document: DocumentSnapshot) -> Post? {
        guard
            let dict = document.data(),
            let title = dict[Key.title.rawValue] as? String else {
            return nil
        }
        let image = dict[Key.image.rawValue] as? String
        return Post(identifier: document.documentID, title: title, image: image)
    }
    
    static func dict(from post: NewPost) -> [String: Any] {
        var data: [String : Any] = [:]
        data[Key.title.rawValue] = post.title
        post.image.map { data[Key.image.rawValue] = $0}
        return data
    }
}
