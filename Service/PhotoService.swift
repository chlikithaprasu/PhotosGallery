//
//  PhotoService.swift
//  PhotoGallery
//
//  Created by Likitha Lakshmi Prasanna Chadaram (V) on 22/09/26.
//
import Foundation

class PhotoService {
    func fetchPhotos(page: Int, limit: Int = 20) async throws -> [Photo] {

        guard let url = URL(
            string: "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)"
        ) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let photos = try JSONDecoder().decode([Photo].self, from: data)

        return photos
    }
}



