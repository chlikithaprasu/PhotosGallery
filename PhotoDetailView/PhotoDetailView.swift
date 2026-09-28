import SwiftUI

struct PhotoDetailView: View {
    
    let photo: Photo
    
    var body: some View {
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
    }
}
