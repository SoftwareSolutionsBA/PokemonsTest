//
//  NotesCreator.swift
//  Test
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import SwiftUI
import AVKit

struct DetailView: View {
	var pokemon: Pokemon
	
	var body: some View {
		VStack {
			
			VideoPlayer(player: AVPlayer(url: pokemon.pokemonDetails?.videoUrl ?? URL(string: "https://google.com")!))
				.frame(height: 200)
			
			AsyncImage(url: URL(string: pokemon.pokemonDetails?.sprites.other?.officialArtwork.frontDefault ?? "") ) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 200, height: 200)
					.padding(.bottom, -10)
			} placeholder: {
				ProgressView("Loading...")
			}
			
			ScrollView {
				VStack(alignment: .leading, spacing: 7) {
					Text(pokemon.name?.capitalized ?? "").font(.largeTitle).bold()
						.padding(.bottom, 5)
					Text("**Types:** ").font(.title2) + Text(pokemon.pokemonDetails?.typesString ?? "").font(.title3)
					Text("**Abilities:** ").font(.title2) + Text(pokemon.pokemonDetails?.abilitiesString ?? "").font(.title3)
					Text("**Moves:** ").font(.title2) + Text(pokemon.pokemonDetails?.movesString ?? "").font(.title3)
				}.padding(.top, 10)
			}
			Spacer()
		}.padding()
	}
}
