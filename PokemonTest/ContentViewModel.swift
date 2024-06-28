//
//  ContentViewModel.swift
//  Test
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

//import Foundation
import SwiftUI
import CoreData

enum FilterType {
	case type
	case advanced
}

class ContentViewModel: ObservableObject {
	let context: NSManagedObjectContext
	
	@Published var pokemonArray: [Pokemon] = []
	@Published var filteredObjects: [Pokemon] = []
	
	@Published var filterActive: Bool = false {
		didSet {
			if !filterActive {
				filteredObjects.removeAll()
			}
		}
	}
	
	@Published var searchCriteria: String = "" {
		didSet {
			filterActive = !searchCriteria.isEmpty
			if filterActive {
				filteredObjects = pokemonArray.filter({ $0.name?.localizedCaseInsensitiveContains(searchCriteria) ?? false })
			}
		}
	}
	
	@Published var pokemonTypes: [String] = []
	
	var apiClient: APIClientProtocol
	
	init(apiClient: APIClientProtocol,
		 pokemonArray: [Pokemon] = [],
		 filteredObjects: [Pokemon] = [],
		 filterActive: Bool = false,
		 searchCriteria: String = "") {
		self.apiClient = apiClient
		self.pokemonArray = pokemonArray
		self.filteredObjects = filteredObjects
		self.filterActive = filterActive
		self.context = PersistenceController.shared.container.viewContext

		readData()
		fetchData()
	}
		
	func fetchData() {
		self.searchCriteria = searchCriteria
		
		Task(priority: .background) {
			let videoLink = await apiClient.fetchVideo()
			let pokemons = await apiClient.fetchPokemons()
			storeData(pokemons)
			await setPokemons(pokemons: pokemons)
			
			for (index, pokemon) in pokemonArray.enumerated() {
				var pokemonDetails = await apiClient.fetchPokemonInfo(urlString: pokemon.url ?? "")
				pokemonDetails?.videoUrl = URL(string: videoLink) ?? URL(string: "https://google.com")!
				await setPokemonDetails(index: index, pokemonDetails: pokemonDetails)
				await setPokemonTypes()
			}
		}
	}
	
	func storeData(_ pokemons: [Pokemon]) {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonData")
		let result = try? context.fetch(fetchRequest) as? [PokemonData]
		
		for pokemon in pokemons {
			if searchName(pokemon.name ?? "").count == 0 {
				let pokemonData = PokemonData(context: context)
				pokemonData.name = pokemon.name
				pokemonData.types = pokemon.pokemonDetails?.typesString
			}
		}
		try? context.hasChanges ? context.save() : ()
	}
	
	func searchName(_ name: String) -> [PokemonData] {
		let fetchRequest: NSFetchRequest<PokemonData> = PokemonData.fetchRequest()
		fetchRequest.entity = PokemonData.entity()
		fetchRequest.predicate = NSPredicate(
			 format: "name CONTAINS %@", name
		)
		return (try? context.fetch(fetchRequest)) ?? []
	}
	
	func readData() {
		let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonData")
		let result = try? context.fetch(fetchRequest) as? [PokemonData]
		
		for pokemon in result ?? [] {
			pokemonArray.removeAll()
			pokemonArray.append(Pokemon(name: pokemon.name))
		}
	}
	
	func filterBy(_ filterType: FilterType, criteria: String) {
		filterActive = true
		switch filterType {
		case .type:
			filteredObjects = pokemonArray.filter({ pokemon in
				pokemon.pokemonDetails?.types.contains(where: { type in
					type.type.name == criteria
				}) ?? false
			})
		default:
			break
		}
	}
	
	@MainActor func setPokemons(pokemons: [Pokemon]) async {
		self.pokemonArray = pokemons
	}
	
	
	@MainActor func setPokemonDetails(index: Int, pokemonDetails: PokemonDetails?) async {
		self.pokemonArray[index].pokemonDetails = pokemonDetails
	}
	
	@MainActor func setPokemonTypes() async {
		for pokemon in pokemonArray {
			for type in pokemon.pokemonDetails?.types ?? [] {
				pokemonTypes.append(type.type.name)
			}
		}
		pokemonTypes = Array(Set(pokemonTypes))
	}
}
