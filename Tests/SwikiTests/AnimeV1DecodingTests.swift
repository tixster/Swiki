import Foundation
import SwikiModels
import Testing

@Suite("AnimeV1Decoding")
struct AnimeV1DecodingTests {
    private func makeRESTDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.set(apiType: .rest)
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)

            let fractional = ISO8601DateFormatter()
            fractional.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let parsed = fractional.date(from: rawValue) {
                return parsed
            }

            let basic = ISO8601DateFormatter()
            basic.formatOptions = [.withInternetDateTime]
            if let parsed = basic.date(from: rawValue) {
                return parsed
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            if let parsed = dateFormatter.date(from: rawValue) {
                return parsed
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported date format: \(rawValue)"
            )
        }
        return decoder
    }

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

        #expect(anime.id == "5114")
        #expect(anime.name == "Fullmetal Alchemist: Brotherhood")
        #expect(anime.kind == .tv)
        #expect(anime.status == .released)
        #expect(anime.episodesAired == 64)
        #expect(anime.airedOn != nil)
    }

    @Test
    func decodesAnimeFullPayloadWithISO8601NextEpisodeAt() throws {
        let json = """
        {
          "id": 21,
          "name": "One Piece",
          "russian": "Ван-Пис",
          "image": {
            "original": "/system/animes/original/21.jpg?1718520367",
            "preview": "/system/animes/preview/21.jpg?1718520367",
            "x96": "/system/animes/x96/21.jpg?1718520367",
            "x48": "/system/animes/x48/21.jpg?1718520367"
          },
          "url": "/animes/21-one-piece",
          "kind": "tv",
          "score": "8.73",
          "status": "ongoing",
          "episodes": 0,
          "episodes_aired": 1155,
          "aired_on": "1999-10-20",
          "released_on": null,
          "rating": "pg_13",
          "english": ["One Piece"],
          "japanese": ["ONE PIECE"],
          "synonyms": ["Большой куш"],
          "license_name_ru": "One Piece",
          "duration": 24,
          "description": "desc",
          "description_html": "<div>desc</div>",
          "description_source": null,
          "franchise": "one_piece",
          "favoured": false,
          "anons": false,
          "ongoing": true,
          "thread_id": 3413,
          "topic_id": 3413,
          "myanimelist_id": 21,
          "rates_scores_stats": [
            { "name": 10, "value": 25736 }
          ],
          "rates_statuses_stats": [
            { "name": "Запланировано", "value": 21922 }
          ],
          "updated_at": "2026-03-04T14:15:36.594+03:00",
          "next_episode_at": "2026-03-08T17:15:00.000+03:00",
          "fansubbers": ["Crunchyroll"],
          "fandubbers": ["AniDUB"],
          "licensors": ["Crunchyroll"],
          "genres": [
            {
              "id": 1,
              "name": "Action",
              "russian": "Экшен",
              "kind": "genre",
              "entry_type": "Anime"
            }
          ],
          "studios": [
            {
              "id": 18,
              "name": "Toei Animation",
              "filtered_name": "Toei",
              "real": true,
              "image": "/system/studios/original/18.?1446981470"
            }
          ],
          "videos": [
            {
              "id": 15860,
              "url": "https://youtu.be/-tviZNY6CSw",
              "image_url": "http://img.youtube.com/vi/-tviZNY6CSw/hqdefault.jpg",
              "player_url": "http://youtube.com/embed/-tviZNY6CSw",
              "name": "Трейлер Madman",
              "kind": "pv",
              "hosting": "youtube"
            }
          ],
          "screenshots": [
            {
              "original": "/system/screenshots/original/625f8903677439e2a2a34878b8f619d57f537f0e.jpg?1620559070",
              "preview": "/system/screenshots/x332/625f8903677439e2a2a34878b8f619d57f537f0e.jpg?1620559070"
            }
          ]
        }
        """

        let anime = try makeRESTDecoder().decode(SwikiAnimeV1.self, from: Data(json.utf8))

        #expect(anime.id == "21")
        #expect(anime.status == .ongoing)
        #expect(anime.synonims == ["Большой куш"])
        #expect(anime.nextEpisodeAt != nil)
    }
}
