//
//  GistFile.swift
//  gistsclient
//

import Foundation

struct GistFile: Decodable {
    
    let filename: String
    let type: String
    let raw_url: String
    let size: Int
    
}
