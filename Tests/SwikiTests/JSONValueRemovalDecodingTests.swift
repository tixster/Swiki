import Foundation
import SwikiModels
import Testing

@Suite("JSONValueRemovalDecoding")
struct JSONValueRemovalDecodingTests {
    @Test
    func decodesClubUserRoleAsEnum() throws {
        let json = """
        {
          "id": 1,
          "name": "Test Club",
          "logo": {
            "original": "https://example.com/logo_original.jpg",
            "preview": "https://example.com/logo_preview.jpg",
            "x96": "https://example.com/logo_96.jpg",
            "x48": "https://example.com/logo_48.jpg",
            "x73": "https://example.com/logo_73.jpg"
          },
          "is_censored": false,
          "join_policy": "free",
          "comment_policy": "free",
          "user_role": "admin"
        }
        """

        let club = try JSONDecoder().decode(SwikiClub.self, from: Data(json.utf8))
        #expect(club.userRole == .admin)
    }

    @Test
    func decodesFranchiseYearFromString() throws {
        let json = """
        {
          "links": [
            {
              "id": 10,
              "source_id": 1,
              "target_id": 2,
              "source": 0,
              "target": 1,
              "weight": 2,
              "relation": "sequel",
              "relation_russian": "Сиквел"
            }
          ],
          "nodes": [
            {
              "id": 1,
              "name": "Entry",
              "image_url": "https://example.com/image.jpg",
              "url": "https://example.com/anime/1",
              "year": "2003",
              "kind": "tv",
              "weight": 10,
              "date": 20031004
            }
          ],
          "current_id": 1
        }
        """

        let franchise = try JSONDecoder().decode(SwikiFranchise.self, from: Data(json.utf8))
        #expect(franchise.nodes.first?.year == 2003)
    }

    @Test
    func decodesUserHistoryTargetAsLinked() throws {
        let json = """
        {
          "id": 1,
          "created_at": "2026-03-03T00:00:00Z",
          "description": "updated list",
          "target": {
            "id": 121,
            "name": "Fullmetal Alchemist",
            "russian": "Стальной алхимик",
            "url": "https://example.com/animes/121",
            "kind": "tv"
          }
        }
        """

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let history = try decoder.decode(SwikiUserHistory.self, from: Data(json.utf8))
        #expect(history.target?.id == "121")
        #expect(history.target?.name == "Fullmetal Alchemist")
        #expect(history.target?.kind == "tv")
    }
}
