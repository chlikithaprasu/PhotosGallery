//
//  CachedImageView.swift
//  PhotoGallery
//
//  Created by Likitha Lakshmi Prasanna Chadaram (V) on 06/10/26.
//

import SwiftUI

struct CachedImageView: View {

    let photo: Photo

    @State private var image: UIImage?

    var body: some View {

      
            if let image = image {
                
                Image(uiImage: image)
                    .resizable()
                
            } else {
                
                ProgressView()
                    .task(id: photo.id) {
                        await loadImage()
                    }
            }
        }
    private func loadImage() async {

        if let cachedImage = PhotoCache.shared.getImage(id: photo.id) {

            print("Image loaded from cache: \(photo.id)")

            image = cachedImage
            return
        }

        guard let url = URL(string: photo.url) else {
            return
        }

        do {

            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode),
                  let downloadedImage = UIImage(data: data) else {
                return
            }

            PhotoCache.shared.setImage(
                id: photo.id,
                image: downloadedImage
            )

            image = downloadedImage

            print("Image downloaded and cached: \(photo.id)")

        } catch {
            print("Image loading error: \(error.localizedDescription)")
        }
    }
}
