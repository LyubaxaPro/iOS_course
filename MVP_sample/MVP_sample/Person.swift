import Foundation

struct PersonInfo {
    let name: String
}

final class PersonModel {
    weak var output: ModelOutput?
    func load(){
        let newPersonInfo = PersonInfo(name: "LyubaxaPro")
        output?.didLoad(info: newPersonInfo)
    }
}
