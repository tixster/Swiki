import Foundation

public enum SwikiOrder: String, Codable, Sendable {
    /// By Id
    case id
    case idDesc = "id_desc"
    /// By rank
    case ranked
    /// By type
    case kind
    /// By popularity
    case popularity
    /// In alphabetical order
    case name
    /// By release date
    case airedOn = "aired_on"
    /// By number of episodes
    case episodes
    /// By status
    case status
    /// By random
    case random
    /// By random.
    /// - Warning: Will be removed. Do not use it.
    case rankedRandom = "ranked_random"
    /// By Shikimori ranking.
    /// - Warning: Will be removed. Do not use it.
    case rankedShiki = "ranked_shiki"
    case createdAt = "created_at"
    case createdAtDesc = "created_at_desc"
    /// By field updated_at on entity.
    /// - Warning: The preview version, there may be problems.
    case updatedAt = "updated_at"
    case updatedAtDesc = "updated_at_desc"
}
