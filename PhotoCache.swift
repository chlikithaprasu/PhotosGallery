import Foundation

final class PhotoCache {
    
    static let shared = PhotoCache()
    
    private var cache: [Int: [Photo]] = [:]
    
    private init() {}
    
    func get(page: Int) -> [Photo]? {
        return cache[page]
    }
    
    func set(page: Int, photos: [Photo]) {
        cache[page] = photos
    }
    
    func getPhoto(id: String) -> Photo? {
        
        for photos in cache.values {
            
            if let photo = photos.first(where: { $0.id == id }) {
                print("Photo \(id) found in cache")
                return photo
            }
        }
        
        print("Photo \(id) not found in cache")
        return nil
    }
    
}
