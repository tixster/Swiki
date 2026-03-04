import Foundation

public enum SwikiFavoritesLinkedTypeCreate: Sendable {
    public enum PersonKind: String, Sendable, CaseIterable {
        case common
        case seyu
        case mangaka
        case producer
        case person
    }
    case anime
    case manga
    case ranobe
    case person(kind: PersonKind)
    case character
    var rawValue: String {
        switch self {
        case .anime:
            return "Anime"
        case .manga:
            return "Manga"
        case .ranobe:
            return "Ranobe"
        case .person:
            return "Person"
        case .character:
            return "Character"
        }
    }

    var kindRawValue: String? {
        switch self {
        case let .person(kind):
            return kind.rawValue
        default:
            return nil
        }
    }
}
