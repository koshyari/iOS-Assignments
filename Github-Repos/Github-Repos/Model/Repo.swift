//
//  Repo.swift
//  Github-Repos
//
//  Created by Anshul Singh Koshyari on 26/10/21.
//

import Foundation

struct Repo: Decodable {
    let items: [Items]
}

struct Items: Decodable {
    let name: String?
    let owner: Owner?
    let description: String?
    let forks_count: Int?
    let stargazers_count: Int?
    let language: String?
    //var isOpened: Bool = false
}

struct Owner: Decodable {
    let login: String?
    let avatar_url: String?
}
