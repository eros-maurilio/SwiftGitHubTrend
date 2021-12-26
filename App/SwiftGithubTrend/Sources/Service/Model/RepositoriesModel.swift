import Foundation

struct Search: Codable {
    let items: [Item]
}

struct Item: Codable {
    let name: String
    let url: String
}
