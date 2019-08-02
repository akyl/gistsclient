//
//  Gist.swift
//  gistsclient
//

import Foundation

struct Gist: Decodable {
    let comments: Int
    let created_at: String
    let files: [String: GistFile]
    let owner: Owner
    let html_url: String
    let url: String
    let `public`: Bool
}
