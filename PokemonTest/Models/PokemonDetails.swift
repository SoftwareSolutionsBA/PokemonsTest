//
//  PokemonDetails.swift
//  PokemonTest
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import Foundation

// MARK: - PokemonDetails
struct PokemonDetails: Codable {	
	let abilities: [Ability]
	let baseExperience: Int
	let cries: Cries
	let forms: [Species]
	let gameIndices: [GameIndex]
	let height: Int
	let heldItems: [JSONAny]
	let id: Int
	let isDefault: Bool
	let locationAreaEncounters: String
	let moves: [Move]
	let name: String
	let order: Int
	let pastAbilities: [JSONAny]
	let pastTypes: [JSONAny]
	let species: Species
	let sprites: Sprites
	let stats: [Stat]
	let types: [TypeElement]
	let weight: Int
	var videoUrl: URL = URL(string: "https://google.com")!
	
	var typesString: String {
		types.map({ $0.type.name.capitalized }).joined(separator: ", ")
	}
	
	var abilitiesString: String {
		abilities.map({ $0.ability.name.capitalized }).joined(separator: ", ")
	}
	
	var movesString: String {
		moves.map({ $0.move.name.capitalized }).joined(separator: ", ")
	}

	enum CodingKeys: String, CodingKey {
		case abilities = "abilities"
		case baseExperience = "base_experience"
		case cries = "cries"
		case forms = "forms"
		case gameIndices = "game_indices"
		case height = "height"
		case heldItems = "held_items"
		case id = "id"
		case isDefault = "is_default"
		case locationAreaEncounters = "location_area_encounters"
		case moves = "moves"
		case name = "name"
		case order = "order"
		case pastAbilities = "past_abilities"
		case pastTypes = "past_types"
		case species = "species"
		case sprites = "sprites"
		case stats = "stats"
		case types = "types"
		case weight = "weight"
	}
}

// MARK: - Ability
struct Ability: Codable {
	let ability: Species
	let isHidden: Bool
	let slot: Int

	enum CodingKeys: String, CodingKey {
		case ability = "ability"
		case isHidden = "is_hidden"
		case slot = "slot"
	}
}

// MARK: - Species
struct Species: Codable {
	let name: String
	let url: String

	enum CodingKeys: String, CodingKey {
		case name = "name"
		case url = "url"
	}
}

// MARK: - Cries
struct Cries: Codable {
	let latest: String
	let legacy: String

	enum CodingKeys: String, CodingKey {
		case latest = "latest"
		case legacy = "legacy"
	}
}

// MARK: - GameIndex
struct GameIndex: Codable {
	let gameIndex: Int
	let version: Species

	enum CodingKeys: String, CodingKey {
		case gameIndex = "game_index"
		case version = "version"
	}
}

// MARK: - Move
struct Move: Codable {
	let move: Species
	let versionGroupDetails: [VersionGroupDetail]

	enum CodingKeys: String, CodingKey {
		case move = "move"
		case versionGroupDetails = "version_group_details"
	}
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
	let levelLearnedAt: Int
	let moveLearnMethod: Species
	let versionGroup: Species

	enum CodingKeys: String, CodingKey {
		case levelLearnedAt = "level_learned_at"
		case moveLearnMethod = "move_learn_method"
		case versionGroup = "version_group"
	}
}

// MARK: - GenerationV
struct GenerationV: Codable {
	let blackWhite: Sprites

	enum CodingKeys: String, CodingKey {
		case blackWhite = "black-white"
	}
}

// MARK: - GenerationIv
struct GenerationIv: Codable {
	let diamondPearl: Sprites
	let heartgoldSoulsilver: Sprites
	let platinum: Sprites

	enum CodingKeys: String, CodingKey {
		case diamondPearl = "diamond-pearl"
		case heartgoldSoulsilver = "heartgold-soulsilver"
		case platinum = "platinum"
	}
}

// MARK: - Versions
struct Versions: Codable {
	let generationI: GenerationI
	let generationIi: GenerationIi
	let generationIii: GenerationIii
	let generationIv: GenerationIv
	let generationV: GenerationV
	let generationVi: [String: Home]
	let generationVii: GenerationVii
	let generationViii: GenerationViii

	enum CodingKeys: String, CodingKey {
		case generationI = "generation-i"
		case generationIi = "generation-ii"
		case generationIii = "generation-iii"
		case generationIv = "generation-iv"
		case generationV = "generation-v"
		case generationVi = "generation-vi"
		case generationVii = "generation-vii"
		case generationViii = "generation-viii"
	}
}

// MARK: - Other
struct Other: Codable {
	let dreamWorld: DreamWorld
	let home: Home
	let officialArtwork: OfficialArtwork
	let showdown: Sprites

	enum CodingKeys: String, CodingKey {
		case dreamWorld = "dream_world"
		case home = "home"
		case officialArtwork = "official-artwork"
		case showdown = "showdown"
	}
}

// MARK: - Sprites
class Sprites: Codable {
	let backDefault: String
	let backFemale: JSONNull?
	let backShiny: String
	let backShinyFemale: JSONNull?
	let frontDefault: String
	let frontFemale: JSONNull?
	let frontShiny: String
	let frontShinyFemale: JSONNull?
	let other: Other?
	let versions: Versions?
	let animated: Sprites?

	enum CodingKeys: String, CodingKey {
		case backDefault = "back_default"
		case backFemale = "back_female"
		case backShiny = "back_shiny"
		case backShinyFemale = "back_shiny_female"
		case frontDefault = "front_default"
		case frontFemale = "front_female"
		case frontShiny = "front_shiny"
		case frontShinyFemale = "front_shiny_female"
		case other = "other"
		case versions = "versions"
		case animated = "animated"
	}

	init(backDefault: String, backFemale: JSONNull?, backShiny: String, backShinyFemale: JSONNull?, frontDefault: String, frontFemale: JSONNull?, frontShiny: String, frontShinyFemale: JSONNull?, other: Other?, versions: Versions?, animated: Sprites?) {
		self.backDefault = backDefault
		self.backFemale = backFemale
		self.backShiny = backShiny
		self.backShinyFemale = backShinyFemale
		self.frontDefault = frontDefault
		self.frontFemale = frontFemale
		self.frontShiny = frontShiny
		self.frontShinyFemale = frontShinyFemale
		self.other = other
		self.versions = versions
		self.animated = animated
	}
}

// MARK: - GenerationI
struct GenerationI: Codable {
	let redBlue: RedBlue
	let yellow: RedBlue

	enum CodingKeys: String, CodingKey {
		case redBlue = "red-blue"
		case yellow = "yellow"
	}
}

// MARK: - RedBlue
struct RedBlue: Codable {
	let backDefault: String
	let backGray: String
	let backTransparent: String
	let frontDefault: String
	let frontGray: String
	let frontTransparent: String

	enum CodingKeys: String, CodingKey {
		case backDefault = "back_default"
		case backGray = "back_gray"
		case backTransparent = "back_transparent"
		case frontDefault = "front_default"
		case frontGray = "front_gray"
		case frontTransparent = "front_transparent"
	}
}

// MARK: - GenerationIi
struct GenerationIi: Codable {
	let crystal: Crystal
	let gold: Gold
	let silver: Gold

	enum CodingKeys: String, CodingKey {
		case crystal = "crystal"
		case gold = "gold"
		case silver = "silver"
	}
}

// MARK: - Crystal
struct Crystal: Codable {
	let backDefault: String
	let backShiny: String
	let backShinyTransparent: String
	let backTransparent: String
	let frontDefault: String
	let frontShiny: String
	let frontShinyTransparent: String
	let frontTransparent: String

	enum CodingKeys: String, CodingKey {
		case backDefault = "back_default"
		case backShiny = "back_shiny"
		case backShinyTransparent = "back_shiny_transparent"
		case backTransparent = "back_transparent"
		case frontDefault = "front_default"
		case frontShiny = "front_shiny"
		case frontShinyTransparent = "front_shiny_transparent"
		case frontTransparent = "front_transparent"
	}
}

// MARK: - Gold
struct Gold: Codable {
	let backDefault: String
	let backShiny: String
	let frontDefault: String
	let frontShiny: String
	let frontTransparent: String?

	enum CodingKeys: String, CodingKey {
		case backDefault = "back_default"
		case backShiny = "back_shiny"
		case frontDefault = "front_default"
		case frontShiny = "front_shiny"
		case frontTransparent = "front_transparent"
	}
}

// MARK: - GenerationIii
struct GenerationIii: Codable {
	let emerald: OfficialArtwork
	let fireredLeafgreen: Gold
	let rubySapphire: Gold

	enum CodingKeys: String, CodingKey {
		case emerald = "emerald"
		case fireredLeafgreen = "firered-leafgreen"
		case rubySapphire = "ruby-sapphire"
	}
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
	let frontDefault: String
	let frontShiny: String

	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
		case frontShiny = "front_shiny"
	}
}

// MARK: - Home
struct Home: Codable {
	let frontDefault: String
	let frontFemale: JSONNull?
	let frontShiny: String
	let frontShinyFemale: JSONNull?

	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
		case frontFemale = "front_female"
		case frontShiny = "front_shiny"
		case frontShinyFemale = "front_shiny_female"
	}
}

// MARK: - GenerationVii
struct GenerationVii: Codable {
	let icons: DreamWorld
	let ultraSunUltraMoon: Home

	enum CodingKeys: String, CodingKey {
		case icons = "icons"
		case ultraSunUltraMoon = "ultra-sun-ultra-moon"
	}
}

// MARK: - DreamWorld
struct DreamWorld: Codable {
	let frontDefault: String
	let frontFemale: JSONNull?

	enum CodingKeys: String, CodingKey {
		case frontDefault = "front_default"
		case frontFemale = "front_female"
	}
}

// MARK: - GenerationViii
struct GenerationViii: Codable {
	let icons: DreamWorld

	enum CodingKeys: String, CodingKey {
		case icons = "icons"
	}
}

// MARK: - Stat
struct Stat: Codable {
	let baseStat: Int
	let effort: Int
	let stat: Species

	enum CodingKeys: String, CodingKey {
		case baseStat = "base_stat"
		case effort = "effort"
		case stat = "stat"
	}
}

// MARK: - TypeElement
struct TypeElement: Codable {
	let slot: Int
	let type: Species

	enum CodingKeys: String, CodingKey {
		case slot = "slot"
		case type = "type"
	}
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

	public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
		return true
	}

	public var hashValue: Int {
		return 0
	}

	public func hash(into hasher: inout Hasher) {
		// No-op
	}

	public init() {}

	public required init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		if !container.decodeNil() {
			throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encodeNil()
	}
}

class JSONCodingKey: CodingKey {
	let key: String

	required init?(intValue: Int) {
		return nil
	}

	required init?(stringValue: String) {
		key = stringValue
	}

	var intValue: Int? {
		return nil
	}

	var stringValue: String {
		return key
	}
}

class JSONAny: Codable {

	let value: Any

	static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
		let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
		return DecodingError.typeMismatch(JSONAny.self, context)
	}

	static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
		let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
		return EncodingError.invalidValue(value, context)
	}

	static func decode(from container: SingleValueDecodingContainer) throws -> Any {
		if let value = try? container.decode(Bool.self) {
			return value
		}
		if let value = try? container.decode(Int64.self) {
			return value
		}
		if let value = try? container.decode(Double.self) {
			return value
		}
		if let value = try? container.decode(String.self) {
			return value
		}
		if container.decodeNil() {
			return JSONNull()
		}
		throw decodingError(forCodingPath: container.codingPath)
	}

	static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
		if let value = try? container.decode(Bool.self) {
			return value
		}
		if let value = try? container.decode(Int64.self) {
			return value
		}
		if let value = try? container.decode(Double.self) {
			return value
		}
		if let value = try? container.decode(String.self) {
			return value
		}
		if let value = try? container.decodeNil() {
			if value {
				return JSONNull()
			}
		}
		if var container = try? container.nestedUnkeyedContainer() {
			return try decodeArray(from: &container)
		}
		if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
			return try decodeDictionary(from: &container)
		}
		throw decodingError(forCodingPath: container.codingPath)
	}

	static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
		if let value = try? container.decode(Bool.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(Int64.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(Double.self, forKey: key) {
			return value
		}
		if let value = try? container.decode(String.self, forKey: key) {
			return value
		}
		if let value = try? container.decodeNil(forKey: key) {
			if value {
				return JSONNull()
			}
		}
		if var container = try? container.nestedUnkeyedContainer(forKey: key) {
			return try decodeArray(from: &container)
		}
		if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
			return try decodeDictionary(from: &container)
		}
		throw decodingError(forCodingPath: container.codingPath)
	}

	static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
		var arr: [Any] = []
		while !container.isAtEnd {
			let value = try decode(from: &container)
			arr.append(value)
		}
		return arr
	}

	static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
		var dict = [String: Any]()
		for key in container.allKeys {
			let value = try decode(from: &container, forKey: key)
			dict[key.stringValue] = value
		}
		return dict
	}

	static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
		for value in array {
			if let value = value as? Bool {
				try container.encode(value)
			} else if let value = value as? Int64 {
				try container.encode(value)
			} else if let value = value as? Double {
				try container.encode(value)
			} else if let value = value as? String {
				try container.encode(value)
			} else if value is JSONNull {
				try container.encodeNil()
			} else if let value = value as? [Any] {
				var container = container.nestedUnkeyedContainer()
				try encode(to: &container, array: value)
			} else if let value = value as? [String: Any] {
				var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
				try encode(to: &container, dictionary: value)
			} else {
				throw encodingError(forValue: value, codingPath: container.codingPath)
			}
		}
	}

	static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
		for (key, value) in dictionary {
			let key = JSONCodingKey(stringValue: key)!
			if let value = value as? Bool {
				try container.encode(value, forKey: key)
			} else if let value = value as? Int64 {
				try container.encode(value, forKey: key)
			} else if let value = value as? Double {
				try container.encode(value, forKey: key)
			} else if let value = value as? String {
				try container.encode(value, forKey: key)
			} else if value is JSONNull {
				try container.encodeNil(forKey: key)
			} else if let value = value as? [Any] {
				var container = container.nestedUnkeyedContainer(forKey: key)
				try encode(to: &container, array: value)
			} else if let value = value as? [String: Any] {
				var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
				try encode(to: &container, dictionary: value)
			} else {
				throw encodingError(forValue: value, codingPath: container.codingPath)
			}
		}
	}

	static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
		if let value = value as? Bool {
			try container.encode(value)
		} else if let value = value as? Int64 {
			try container.encode(value)
		} else if let value = value as? Double {
			try container.encode(value)
		} else if let value = value as? String {
			try container.encode(value)
		} else if value is JSONNull {
			try container.encodeNil()
		} else {
			throw encodingError(forValue: value, codingPath: container.codingPath)
		}
	}

	public required init(from decoder: Decoder) throws {
		if var arrayContainer = try? decoder.unkeyedContainer() {
			self.value = try JSONAny.decodeArray(from: &arrayContainer)
		} else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
			self.value = try JSONAny.decodeDictionary(from: &container)
		} else {
			let container = try decoder.singleValueContainer()
			self.value = try JSONAny.decode(from: container)
		}
	}

	public func encode(to encoder: Encoder) throws {
		if let arr = self.value as? [Any] {
			var container = encoder.unkeyedContainer()
			try JSONAny.encode(to: &container, array: arr)
		} else if let dict = self.value as? [String: Any] {
			var container = encoder.container(keyedBy: JSONCodingKey.self)
			try JSONAny.encode(to: &container, dictionary: dict)
		} else {
			var container = encoder.singleValueContainer()
			try JSONAny.encode(to: &container, value: self.value)
		}
	}
}
