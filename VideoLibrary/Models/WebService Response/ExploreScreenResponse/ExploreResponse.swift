import Foundation

struct ExploreResponse : Codable {
    let data : [ResponseData]?

    enum CodingKeys: String, CodingKey {

        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        data = try values.decodeIfPresent([ResponseData].self, forKey: .data)
    }

}
