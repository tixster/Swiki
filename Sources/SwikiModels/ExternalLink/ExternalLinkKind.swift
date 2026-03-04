import Foundation

public enum SwikiExternalLinkKind: String, Decodable, Sendable {
    case officialSite = "official_site"
    case wikipedia
    case animeNewsNetwork = "anime_news_network"
    case myAnimeList = "myanimelist"
    case animeDb = "anime_db"
    case worldArt = "world_art"
    case kinopoisk
    case kageProject = "kage_project"
    case twitter
    case anime365 = "smotret_anime"
    case crunchyroll
    case amazon
    case hidive
    case hulu
    case ivi
    case kinopoiskHd = "kinopoisk_hd"
    case wink
    case netflix
    case okko
    case youtube
    case readmanga
    case mangalib
    case remanga
    case mangaupdates
    case mangadex
    case mangafox
    case mangachan
    case mangahub
    case novelTl = "novel_tl"
    case ruranobe
    case ranobelib
    case novelupdates
    case unknown
}
