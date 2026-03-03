import Foundation
import SwikiModels
import Testing

@Suite("ConstantsDecoding")
struct ConstantsDecodingTests {
    @Test
    func decodesAnimeConstants() throws {
        let json = """
        {
          "kind": ["tv", "movie", "ova", "ona", "special", "music"],
          "status": ["anons", "ongoing", "released"]
        }
        """

        let constants = try JSONDecoder().decode(SwikiAnimeConstants.self, from: Data(json.utf8))

        #expect(constants.kind == [.tv, .movie, .ova, .ona, .special, .music])
        #expect(constants.status == [.anons, .ongoing, .released])
    }

    @Test
    func decodesMangaConstants() throws {
        let json = """
        {
          "kind": ["manga", "manhwa", "manhua", "light_novel", "novel", "one_shot", "doujin"],
          "status": ["anons", "ongoing", "released", "paused", "discontinued"]
        }
        """

        let constants = try JSONDecoder().decode(SwikiMangaConstants.self, from: Data(json.utf8))

        #expect(constants.kind == [.manga, .manhwa, .manhua, .lightNovel, .novel, .oneShot, .doujin])
        #expect(constants.status == [.anons, .ongoing, .released, .paused, .discontinued])
    }

    @Test
    func decodesUserRateConstants() throws {
        let json = """
        {
          "status": ["planned", "watching", "rewatching", "completed", "on_hold", "dropped"]
        }
        """

        let constants = try JSONDecoder().decode(SwikiUserRateConstants.self, from: Data(json.utf8))

        #expect(constants.status == [.planned, .watching, .rewatching, .completed, .onHold, .dropped])
    }

    @Test
    func decodesClubConstants() throws {
        let json = """
        {
          "join_policy": ["free", "member_invite", "admin_invite", "owner_invite"],
          "comment_policy": ["free", "members", "admins"],
          "image_upload_policy": ["members", "admins"]
        }
        """

        let constants = try JSONDecoder().decode(SwikiClubConstants.self, from: Data(json.utf8))

        #expect(constants.joinPolicy == [.free, .memberInvite, .adminInvite, .ownerInvite])
        #expect(constants.commentPolicy == [.free, .members, .admins])
        #expect(constants.imageUploadPolicy == [.members, .admins])
    }
}
