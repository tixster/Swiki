import Foundation
import SwikiModels
import Testing

@Suite("AnimeV1Decoding")
struct AnimeV1DecodingTests {
    @Test
    func decodesAnimeListPreviewPayload() throws {
        let json = """
        {
          "id": 5114,
          "name": "Fullmetal Alchemist: Brotherhood",
          "russian": "Стальной алхимик: Братство",
          "image": {
            "original": "/system/animes/original/5114.jpg",
            "preview": "/system/animes/preview/5114.jpg",
            "x96": "/system/animes/x96/5114.jpg",
            "x48": "/system/animes/x48/5114.jpg"
          },
          "url": "/animes/5114-fullmetal-alchemist-brotherhood",
          "kind": "tv",
          "score": "9.12",
          "status": "released",
          "episodes": 64,
          "episodes_aired": 64,
          "aired_on": "2009-04-05",
          "released_on": "2010-07-04"
        }
        """

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let anime = try decoder.decode(SwikiAnimeV1Preview.self, from: Data(json.utf8))

        #expect(anime.id == 5114)
        #expect(anime.name == "Fullmetal Alchemist: Brotherhood")
        #expect(anime.kind == .tv)
        #expect(anime.status == .released)
        #expect(anime.episodesAired == 64)
        #expect(anime.airedOn != nil)
    }
}
