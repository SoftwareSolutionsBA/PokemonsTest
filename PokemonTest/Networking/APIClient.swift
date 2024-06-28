//
//  APIClient.swift
//  PokemonTest
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import Foundation

protocol APIClientProtocol {
	func fetchPokemons() async -> [Pokemon]
	func fetchPokemonInfo(urlString: String) async -> PokemonDetails?
	func fetchVideo() async -> String
}

struct APIClient: APIClientProtocol {
	
	var urlSession: URLSession
	
	struct Constants {
		static let apiURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
	}
	
	init(urlSession: URLSession = URLSession(configuration: .default)) {
		self.urlSession = urlSession
	}
	
	func fetchPokemons() async -> [Pokemon] {
		guard let url = Constants.apiURL else { return [] }
		
		let urlRequest = URLRequest(url: url)

		if let result = try? await urlSession.data(for: urlRequest) {
			let response = try? JSONDecoder().decode(GETPokemons.self, from: result.0)
			return response?.results ?? []
		}
		return []
	}
	
	func fetchPokemonInfo(urlString: String) async -> PokemonDetails? {
		guard let url = URL(string: urlString) else { return nil }
		let urlRequest = URLRequest(url: url)
		
		if let result = try? await urlSession.data(for: urlRequest) {
			let response = try? JSONDecoder().decode(PokemonDetails.self, from: result.0)
			return response
		}
		return nil
	}
	
	func fetchVideo() async -> String {
		guard let url = URL(string: "https://api.pexels.com/videos/videos/3191901") else { return "" }
		var urlRequest = URLRequest(url: url)
		urlRequest.setValue("fK1hkaHEeqdEGuTjEKJbnD0aEsW6RwIaci3keWFRj2VUgyE6OiLN23LS", 
							forHTTPHeaderField: "Authorization") /// THIS API KEY MUST BE STORED IN A SECURE WAY I DID IT LIKE THIS BECAUSE OF THE TEST PURPOSES
		
		if let result = try? await urlSession.data(for: urlRequest) {
			let response = try? JSONDecoder().decode(Video.self, from: result.0)
			return response?.videoFiles.first?.link ?? ""
		}
		
		return ""
	}
}
