//
//  PhotoViewModel.swift
//  PhotoGallery
//
//  Created by Likitha Lakshmi Prasanna Chadaram (V) on 23/09/26.
//

import Foundation
enum ViewState {
    case loading
    case success
    case error(String)
}
@Observable
class PhotoViewModel {
    private var currentPage = 1
    
     var photos: [Photo] = []
     var state: ViewState = .loading

    private let photoService = PhotoService()

    func fetchPhotos() async {

        state = .loading

        do {
            photos = try await photoService.fetchPhotos(page: currentPage)
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
