import Foundation
import SwikiModels
import Testing

@Suite("MangaV1Decoding")
struct MangaV1DecodingTests {
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
    func decodesMangaListPreviewPayload() throws {
        let json = """
        {
          "id": 154376,
          "name": "Yowayowa Sensei",
          "russian": "Учитель Ёваёва",
          "image": {
            "original": "/system/mangas/original/154376.jpg?1712892545",
            "preview": "/system/mangas/preview/154376.jpg?1712892545",
            "x96": "/system/mangas/x96/154376.jpg?1712892545",
            "x48": "/system/mangas/x48/154376.jpg?1712892545"
          },
          "url": "/mangas/154376-yowayowa-sensei",
          "kind": "manga",
          "score": "6.62",
          "status": "ongoing",
          "volumes": 0,
          "chapters": 0,
          "aired_on": "2022-11-16",
          "released_on": null,
          "roles": [
            "Main"
          ],
          "role": "Main"
        }
        """

        let decoder = makeRESTDecoder()
        let manga = try decoder.decode(SwikiMangaV1Preview.self, from: Data(json.utf8))

        #expect(manga.id == "154376")
        #expect(manga.name == "Yowayowa Sensei")
        #expect(manga.kind == .manga)
        #expect(manga.status == .ongoing)
        #expect(manga.roles == ["Main"])
        #expect(manga.role == "Main")
        #expect(manga.airedOn != nil)
        #expect(manga.releasedOn == nil)
    }

    @Test
    func decodesMangaFullPayload() throws {
        let json = """
        {
          "id": 13,
          "name": "One Piece",
          "russian": "Ван-Пис",
          "image": {
            "original": "/system/mangas/original/13.jpg?1712830834",
            "preview": "/system/mangas/preview/13.jpg?1712830834",
            "x96": "/system/mangas/x96/13.jpg?1712830834",
            "x48": "/system/mangas/x48/13.jpg?1712830834"
          },
          "url": "/mangas/z13-one-piece",
          "kind": "manga",
          "score": "9.22",
          "status": "ongoing",
          "volumes": 0,
          "chapters": 0,
          "aired_on": "1997-07-22",
          "released_on": null,
          "english": ["One Piece"],
          "japanese": ["ONE PIECE"],
          "synonyms": ["Большой куш"],
          "license_name_ru": "One Piece. Большой куш",
          "description": "desc",
          "description_html": "<div>desc</div>",
          "description_source": null,
          "franchise": "wanted",
          "favoured": false,
          "anons": false,
          "ongoing": true,
          "thread_id": 11022,
          "topic_id": 11022,
          "myanimelist_id": 13,
          "rates_scores_stats": [
            { "name": 10, "value": 5153 }
          ],
          "rates_statuses_stats": [
            { "name": "Запланировано", "value": 4492 }
          ],
          "licensors": ["Азбука-Аттикус"],
          "genres": [
            {
              "id": 56,
              "name": "Action",
              "russian": "Экшен",
              "kind": "genre",
              "entry_type": "Manga"
            }
          ],
          "publishers": [
            {
              "id": 83,
              "name": "Shounen Jump (Weekly)"
            }
          ],
          "user_rate": {
            "id": 208243942,
            "score": 8,
            "status": "planned",
            "text": null,
            "episodes": null,
            "chapters": 0,
            "volumes": 0,
            "text_html": "",
            "rewatches": 0,
            "created_at": "2026-03-04T16:11:07.860+03:00",
            "updated_at": "2026-03-04T16:11:09.498+03:00"
          }
        }
        """

        let manga = try makeRESTDecoder().decode(SwikiMangaV1.self, from: Data(json.utf8))

        #expect(manga.id == "13")
        #expect(manga.name == "One Piece")
        #expect(manga.kind == .manga)
        #expect(manga.status == .ongoing)
        #expect(manga.synonims == ["Большой куш"])
        #expect(manga.myAnimeListId == 13)
        #expect(manga.userRate?.status == .planned)
        #expect(manga.airedOn != nil)
        #expect(manga.releasedOn == nil)
    }
}
