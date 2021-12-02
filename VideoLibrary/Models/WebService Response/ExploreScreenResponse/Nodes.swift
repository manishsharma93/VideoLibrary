import Foundation

struct Nodes : Codable {
	let video : Video?

	enum CodingKeys: String, CodingKey {

		case video = "video"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
		video = try values.decodeIfPresent(Video.self, forKey: .video)
	}

}
