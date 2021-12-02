import Foundation

struct Video : Codable {
	let encodeUrl : String?

	enum CodingKeys: String, CodingKey {

		case encodeUrl = "encodeUrl"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
		encodeUrl = try values.decodeIfPresent(String.self, forKey: .encodeUrl)
	}

}
