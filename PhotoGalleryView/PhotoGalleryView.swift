//
//  PhotoGalleryView.swift
//  PhotoGallery
//
//  Created by Likitha Lakshmi Prasanna Chadaram (V) on 24/09/26.
//

import SwiftUI

struct PhotoGalleryView: View {
    
    var viewModel = PhotoViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            switch viewModel.state {
                
            case .loading:
                ProgressView("Loading Photos...")
                
            case .success:
                
                VStack {
                    
                    List(viewModel.photos) { photo in
                        
                        NavigationLink {
                            PhotoDetailView(photoID: photo.id)
                        }label: {
                            
                            HStack {
                                
                                AsyncImage(url: URL(string: photo.url)) { image in
                                    image
                                        .resizable()
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 80, height: 80)
                                
                                Text(photo.name)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.refreshPhotos()
                    }
                    HStack {
                        
                        Button("<<") {
                            Task {
                                await viewModel.previousPage()
                            }
                        }
                        
                        Spacer()
                        
                        Button(">>") {
                            Task {
                                await viewModel.nextPage()
                            }
                        }
                    }
                    .padding()
                }
                
            case .error(let error):
                Text(error)
            }
        }
        .task {
            await viewModel.fetchPhotos()
        }
    }
}
