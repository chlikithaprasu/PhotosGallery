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

        if let cachedPhotos = PhotoCache.shared.get(page: currentPage) {
            photos = cachedPhotos
            state = .success
            return
        }

        do {
            
            let fetchedPhotos = try await photoService.fetchPhotos(
                page: currentPage
            )
            
            PhotoCache.shared.set(
                page: currentPage,
                photos: fetchedPhotos
            )
            
            // STEP 6: Display photos
            photos = fetchedPhotos
            
            state = .success
            
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func refreshPhotos() async {
        do{
            photos = try await photoService.fetchPhotos(page: currentPage)
        }catch is CancellationError {
            } catch {
            state = .error(error.localizedDescription)
            }
    }
    func nextPage() async {
        currentPage += 1
        await fetchPhotos()
    }

    func previousPage() async {
        if currentPage > 1 {
            currentPage -= 1
            await fetchPhotos()
        }
    }
}




