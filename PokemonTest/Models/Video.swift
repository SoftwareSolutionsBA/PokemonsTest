//
//  Video.swift
//  PokemonTest
//
//  Created by Figueroa, David(AWF) on 6/28/24.
//

import Foundation

struct Video: Identifiable, Codable {
	var id = UUID()
	var videoFiles: [VideoItem]
	
	enum CodingKeys: String, CodingKey {
		case videoFiles = "video_files"
	}
}

struct VideoItem: Codable {
	var link: String? = ""
}
