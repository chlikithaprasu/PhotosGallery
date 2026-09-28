//
//  Photo.swift
//  PhotoGallery
//
//  Created by Likitha Lakshmi Prasanna Chadaram (V) on 22/09/26.
//
import Foundation
struct Photo: Codable, Identifiable {
    let id: String
    let name: String
    let url:String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "author"
        case url = "download_url"
    }
}
