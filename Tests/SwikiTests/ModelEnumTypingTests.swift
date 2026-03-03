import Foundation
import SwikiModels
import Testing

@Suite("ModelEnumTyping")
struct ModelEnumTypingTests {
    @Test
    func decodesClubPoliciesAsEnums() throws {
        let json = """
        {
          "id": 1,
          "name": "Club",
          "logo": {
            "original": "https://shikimori.one/original.jpg",
            "preview": "https://shikimori.one/preview.jpg"
          },
          "is_censored": false,
          "join_policy": "member_invite",
          "comment_policy": "admins"
        }
        """

        let club = try JSONDecoder().decode(SwikiClub.self, from: Data(json.utf8))

        #expect(club.joinPolicy == .memberInvite)
        #expect(club.commentPolicy == .admins)
    }

    @Test
    func decodesUserRateTargetTypeAsEnum() throws {
        let json = """
        {
          "id": 15,
          "episodes": 3,
          "volumes": 0,
          "chapters": 0,
          "rewatches": 0,
          "status": "watching",
          "score": 8,
          "user_id": 99,
          "target_id": 5114,
          "target_type": "Anime"
        }
        """

        let decoder = JSONDecoder()
        decoder.set(apiType: .rest)
        let rate = try decoder.decode(SwikiUserRate.self, from: Data(json.utf8))

        #expect(rate.targetType == .anime)
    }

    @Test
    func decodesRelatedRelationAsEnumWithFallback() throws {
        let knownJson = """
        {
          "id": 1,
          "relation": "adaptation",
          "relation_russian": "адаптация"
        }
        """
        let unknownJson = """
        {
          "id": 1,
          "relation": "unknown_relation",
          "relation_russian": "неизвестно"
        }
        """

        let known = try JSONDecoder().decode(SwikiRelated.self, from: Data(knownJson.utf8))
        let unknown = try JSONDecoder().decode(SwikiRelated.self, from: Data(unknownJson.utf8))

        #expect(known.relation == .adaptation)
        #expect(unknown.relation == .other)
    }
}
