import Foundation
import SwikiModels
import Testing

@Suite("RelatedDecoding")
struct RelatedDecodingTests {
    @Test
    func decodesRelatedWithMangaPreview() throws {
        let json = """
        {
          "relation": "adaptation",
          "relation_russian": "Адаптация",
          "anime": null,
          "manga": {
            "id": 16,
            "name": "manga_5",
            "russian": "манга_5",
            "image": {
              "original": "/assets/globals/missing_original.jpg",
              "preview": "/assets/globals/missing_preview.jpg",
              "x96": "/assets/globals/missing_x96.jpg",
              "x48": "/assets/globals/missing_x48.jpg"
            },
            "url": "/mangas/16-manga-5",
            "kind": "manga",
            "score": "1.0",
            "status": "released",
            "volumes": 0,
            "chapters": 0,
            "aired_on": null,
            "released_on": null
          }
        }
        """

        let related = try JSONDecoder().decode(SwikiRelated.self, from: Data(json.utf8))

        #expect(related.relation == .adaptation)
        #expect(related.relationRussian == "Адаптация")
        #expect(related.anime == nil)
        #expect(related.manga?.id == "16")
        #expect(related.manga?.kind == .manga)
        #expect(related.manga?.status == .released)
        #expect(related.manga?.url.relativeString == "/mangas/16-manga-5")
    }

    @Test
    func decodesRelatedWithAnimePreview() throws {
        let json = """
        {
          "relation": "adaptation",
          "relation_russian": "Адаптация",
          "anime": {
            "id": 53,
            "name": "anime_53",
            "russian": "аниме_53",
            "image": {
              "original": "/assets/globals/missing_original.jpg",
              "preview": "/assets/globals/missing_preview.jpg",
              "x96": "/assets/globals/missing_x96.jpg",
              "x48": "/assets/globals/missing_x48.jpg"
            },
            "url": "/animes/53-anime-53",
            "kind": "tv",
            "score": "1.0",
            "status": "released",
            "episodes": 0,
            "episodes_aired": 0,
            "aired_on": null,
            "released_on": null
          },
          "manga": null
        }
        """

        let related = try JSONDecoder().decode(SwikiRelated.self, from: Data(json.utf8))

        #expect(related.relation == .adaptation)
        #expect(related.relationRussian == "Адаптация")
        #expect(related.manga == nil)
        #expect(related.anime?.id == "53")
        #expect(related.anime?.kind == .tv)
        #expect(related.anime?.status == .released)
        #expect(related.anime?.url.relativeString == "/animes/53-anime-53")
    }
}
