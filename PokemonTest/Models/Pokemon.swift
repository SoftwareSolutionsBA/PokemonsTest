//
//  Pokemon.swift
//  PokemonTest
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import Foundation

struct Pokemon: Identifiable, Codable {
	var id = UUID()
	
	var name: String? = ""
	var url: String? = ""
	var pokemonDetails: PokemonDetails?	
	
	enum CodingKeys: CodingKey {
		case name
		case url
	}
}
