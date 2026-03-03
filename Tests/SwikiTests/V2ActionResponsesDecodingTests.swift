import Foundation
import SwikiModels
import Testing

@Suite("V2ActionResponsesDecoding")
struct V2ActionResponsesDecodingTests {
    @Test
    func decodesAbuseOfftopicResponse() throws {
        let json = """
        {
          "kind": "offtopic",
          "value": true,
          "affected_ids": [123, 456]
        }
        """

        let response = try JSONDecoder().decode(SwikiAbuseOfftopicResponse.self, from: Data(json.utf8))
        #expect(response.kind == "offtopic")
        #expect(response.value == true)
        #expect(response.affectedIds == ["123", "456"])
    }

    @Test
    func decodesTopicIgnoreResponse() throws {
        let json = """
        {
          "topic_id": 209435,
          "is_ignored": true
        }
        """

        let response = try JSONDecoder().decode(SwikiTopicIgnore.self, from: Data(json.utf8))
        #expect(response.topicId == "209435")
        #expect(response.isIgnored == true)
    }

    @Test
    func decodesUserIgnoreResponse() throws {
        let json = """
        {
          "user_id": 3,
          "is_ignored": false
        }
        """

        let response = try JSONDecoder().decode(SwikiUserIgnore.self, from: Data(json.utf8))
        #expect(response.userId == "3")
        #expect(response.isIgnored == false)
    }

    @Test
    func decodesEpisodeNotificationCreateResponse() throws {
        let json = """
        {
          "id": 11,
          "anime_id": 121,
          "episode": 52,
          "is_raw": true,
          "is_subtitles": false,
          "is_fandub": false,
          "is_anime365": true,
          "topic_id": 777
        }
        """

        let response = try JSONDecoder().decode(SwikiEpisodeNotification.self, from: Data(json.utf8))
        #expect(response.id == "11")
        #expect(response.animeId == "121")
        #expect(response.episode == 52)
        #expect(response.isRaw == true)
        #expect(response.isSubtitles == false)
        #expect(response.isFandub == false)
        #expect(response.isAnime365 == true)
        #expect(response.topicId == "777")
    }

    @Test
    func decodesEmptyResponse() throws {
        let json = "{}"
        _ = try JSONDecoder().decode(SwikiEmptyResponse.self, from: Data(json.utf8))
    }
}
