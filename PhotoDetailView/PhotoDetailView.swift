import SwiftUI

struct PhotoDetailView: View {
    
    let photoID: String
    
    var body: some View {
        
        if let photo = PhotoCache.shared.getPhoto(id: photoID) {
            
            VStack(spacing: 20) {
                
                AsyncImage(url: URL(string: photo.url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                
                Text(photo.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Photo ID: \(photo.id)")
                    .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Photo Details")
            
        } else {
            Text("Photo not found in cache")
        }
    }
}
