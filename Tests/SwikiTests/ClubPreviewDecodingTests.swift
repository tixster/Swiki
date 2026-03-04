import Foundation
import SwikiModels
import Testing

@Suite("ClubPreviewDecoding")
struct ClubPreviewDecodingTests {
    @Test
    func decodesClubPreviewPayload() throws {
        let json = """
        {
          "id": 2,
          "name": "club_4",
          "logo": {
            "original": "/assets/globals/missing_original_original.png",
            "main": "/assets/globals/missing_main_main.png",
            "x96": "/assets/globals/missing_x96_x96.png",
            "x73": "/assets/globals/missing_x73_x73.png",
            "x48": "/assets/globals/missing_x48_x48.png"
          },
          "is_censored": false,
          "join_policy": "free",
          "comment_policy": "free"
        }
        """

        let club = try JSONDecoder().decode(SwikiClubPreview.self, from: Data(json.utf8))

        #expect(club.id == "2")
        #expect(club.name == "club_4")
        #expect(club.isCensored == false)
        #expect(club.joinPolicy == .free)
        #expect(club.commentPolicy == .free)
        #expect(club.logo.main.path == "/assets/globals/missing_main_main.png")
    }
}
