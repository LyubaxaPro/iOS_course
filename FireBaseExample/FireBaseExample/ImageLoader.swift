import FirebaseStorage

protocol ImageLoaderDescription: AnyObject {
    func upload(image: UIImage, complition: @escaping (Result<String, Error>) -> Void)
    func image(with name: String, complition: @escaping (Result<UIImage, Error>) -> Void)
    
}

final class ImageLoader: ImageLoaderDescription {
    static let shared: ImageLoaderDescription = ImageLoader()
    private let storageRef = Storage.storage().reference()
    private var imageCashe: [String : UIImage] = [:]
    
    init(){}
    
    func image(with name: String, complition: @escaping (Result<UIImage, Error>) -> Void) {
        storageRef.child(name).getData(maxSize: 15 * 1024 * 1024) {[weak self] (data, error) in
            if let image = self?.imageCashe[name] {
                complition(.success(image))
                return
            }
            
            if let error = error {
                complition(.failure(error))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                self?.imageCashe[name] = image
                complition(.success(image))
                return
            } else {
                complition(.failure(NetworkError.unexpected))
                return
            }
        }
    }
    
    func upload(image: UIImage, complition: @escaping (Result<String, Error>) -> Void){
        
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            complition(.failure(NetworkError.unexpected))
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let randomName = UUID().uuidString
        
        storageRef.child(randomName).putData(data, metadata: metadata) {[weak self] (_, error) in
            if let error = error {
                complition(.failure(error))
                return
            } else {
                self?.imageCashe[randomName] = image
                complition(.success(randomName))
                return
            }
        }
    }
}
