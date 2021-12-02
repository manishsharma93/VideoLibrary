import Foundation

struct ResponseData : Codable {
	let title : String?
	let nodes : [Nodes]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case nodes = "nodes"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
		title = try values.decodeIfPresent(String.self, forKey: .title)
		nodes = try values.decodeIfPresent([Nodes].self, forKey: .nodes)
	}

}
