import Foundation

struct TechnologyDomain: Equatable, Hashable {
    var id: String?
    var name: String?
    
    init(_ dataStruct: GithubResponseBody.Included) {
        id = dataStruct.id
        name = dataStruct.attributes?.name
    }
}
