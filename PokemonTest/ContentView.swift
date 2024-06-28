//
//  ContentView.swift
//  Test
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
//	@Environment(\.managedObjectContext) var context
	@StateObject var viewModel: ContentViewModel
	@State var showFilterPopover: Bool
	
	let columns = [
		GridItem(.adaptive(minimum: 180))
	]
	
	init(context: NSManagedObjectContext, showFilterPopover: Bool = false) {
		self.showFilterPopover = showFilterPopover
		self._viewModel = StateObject(wrappedValue: ContentViewModel(context: context, apiClient: APIClient()))
	}
	
	var body: some View {
		VStack {
			NavigationStack {
				
				VStack(alignment: .leading) {
					Text("Pokedex 1.0").font(.largeTitle).fontWeight(.bold)
					Text("Use the advanced search to filter by type weakness ability and more!").font(.title3)
					
					HStack(alignment: .center) {
						TextField("Type to Search",
								  text: $viewModel.searchCriteria)
						.frame(height: 40)
						.overlay(
							RoundedRectangle(cornerRadius: 7)
								.strokeBorder(.primary, style: StrokeStyle(lineWidth: 0.8))
								.padding(.horizontal, -4)
						).padding(.leading, 6)

						HStack {
							Spacer()
							
							if viewModel.filterActive {
								Button {
									viewModel.filterActive = false
									viewModel.searchCriteria.removeAll()
								} label: {
									Text("Remove").foregroundStyle(.red)
									Image(systemName: "minus.circle.fill").foregroundStyle(.red)
								}
								
								Divider().frame(width: 1.5, height: 15).background(.primary)
							}
							
							Button {
								showFilterPopover.toggle()
							} label: {
								Text("Filters").font(.callout)
								Image(systemName: "line.3.horizontal.decrease.circle.fill")
							}
						}
					}.padding(.vertical, 10)
					
					ScrollView {
						LazyVGrid(columns: columns, spacing: 20) {
							
							ForEach(viewModel.filterActive ? viewModel.filteredObjects : viewModel.pokemonArray, id: \.id) { element in
								
								NavigationLink {
									DetailView(pokemon: element)
								} label: {
									pokemonCard(pokemon: element).tint(.primary)
								}
							}
						}
					}.scrollIndicators(.hidden)
					
					if viewModel.filterActive {
						Text("Showing: \(viewModel.filteredObjects.count) out of \(viewModel.pokemonArray.count)")
							.font(.callout)
							.padding(.top, 5)
					}
				}
			}
		}
		.padding()
		.alert("Select Type", isPresented: $showFilterPopover, actions: {
			VStack {
				ForEach(viewModel.pokemonTypes, id: \.self) { type in
					Button {
						viewModel.filterBy(.type, criteria: type)
					} label: {
						Text(type.capitalized)
					}
				}
			}
		})
	}
	
	@ViewBuilder
	func pokemonCard(pokemon: Pokemon) -> some View {
		RoundedRectangle(cornerRadius: 10).fill(.green).frame(width: 180, height: 200)
			.overlay(alignment: .bottom) {
				VStack(spacing: 5) {
					if let urlString = pokemon.pokemonDetails?.sprites.frontDefault,
					   let url = URL(string: urlString) {
						
						AsyncImage(url: url) { image in
							image
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 130, height: 130)
								.padding(.bottom, -10)
						} placeholder: {
							ProgressView("Loading...")
						}
					} else {
						Image(systemName: "exclamationmark.icloud")
							.resizable()
							.frame(width: 65, height: 50)
					}
					
					Text((pokemon.name ?? "").capitalized).font(.title)
					Text(pokemon.pokemonDetails?.typesString ?? "").font(.title3)
				}.padding(.bottom, 10)
			}
	}
}
