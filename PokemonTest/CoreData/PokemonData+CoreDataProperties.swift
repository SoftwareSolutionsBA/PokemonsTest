//
//  PokemonData+CoreDataProperties.swift
//  PokemonTest
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//
//

import Foundation
import CoreData


extension PokemonData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonData> {
        return NSFetchRequest<PokemonData>(entityName: "PokemonData")
    }

    @NSManaged public var name: String?
    @NSManaged public var types: String?

}

extension PokemonData : Identifiable {

}
