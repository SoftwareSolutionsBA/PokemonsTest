//
//  GETPokemons.swift
//  PokemonTest
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import Foundation

struct GETPokemons: Codable {
	var next: String? = ""
	var previous: String? = ""
	var results: [Pokemon]? = []
}
