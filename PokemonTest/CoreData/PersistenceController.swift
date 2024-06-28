//
//  PersistenceController.swift
//  PokemonTest
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import Foundation
import CoreData
struct PersistenceController {
	static let shared = PersistenceController()

	let container: NSPersistentContainer

	init() {
		container = NSPersistentContainer(name: "Model")

		container.loadPersistentStores{ (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolve Error: \(error)")
			}
		}
	}
}
