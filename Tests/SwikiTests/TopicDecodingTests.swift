import Foundation
import SwikiModels
import Testing

@Suite("TopicDecoding")
struct TopicDecodingTests {
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
    func decodesTopicPayload() throws {
        let json = """
        {
          "id": 611205,
          "topic_title": "Вышел 117 эпизод",
          "body": "",
          "html_body": "",
          "html_footer": "",
          "created_at": "2025-11-14T21:40:07.000+03:00",
          "comments_count": 0,
          "forum": {
            "id": 1,
            "position": 1,
            "name": "Аниме и манга",
            "permalink": "animanga",
            "url": "/forum/animanga"
          },
          "user": {
            "id": 16,
            "nickname": "Ака-тян",
            "avatar": "https://shikimori.io/system/users/x48/16.png?1447460712",
            "image": {
              "x160": "https://shikimori.io/system/users/x160/16.png?1447460712",
              "x148": "https://shikimori.io/system/users/x148/16.png?1447460712",
              "x80": "https://shikimori.io/system/users/x80/16.png?1447460712",
              "x64": "https://shikimori.io/system/users/x64/16.png?1447460712",
              "x48": "https://shikimori.io/system/users/x48/16.png?1447460712",
              "x32": "https://shikimori.io/system/users/x32/16.png?1447460712",
              "x16": "https://shikimori.io/system/users/x16/16.png?1447460712"
            },
            "last_online_at": "2014-05-25T23:56:07.000+04:00",
            "url": "https://shikimori.io/%D0%90%D0%BA%D0%B0-%D1%82%D1%8F%D0%BD"
          },
          "type": "Topics::NewsTopic",
          "linked_id": 53876,
          "linked_type": "Anime",
          "linked": {
            "id": 53876,
            "name": "Pokemon (2023)",
            "russian": "Покемон (2023)",
            "image": {
              "original": "/system/animes/original/53876.jpg?1718402214",
              "preview": "/system/animes/preview/53876.jpg?1718402214",
              "x96": "/system/animes/x96/53876.jpg?1718402214",
              "x48": "/system/animes/x48/53876.jpg?1718402214"
            },
            "url": "/animes/53876-pokemon-2023",
            "kind": "tv",
            "score": "7.41",
            "status": "ongoing",
            "episodes": 0,
            "episodes_aired": 129,
            "aired_on": "2023-04-14",
            "released_on": null
          },
          "viewed": true,
          "last_comment_viewed": null,
          "event": "episode",
          "episode": 117
        }
        """

        let topic = try makeRESTDecoder().decode(SwikiTopic.self, from: Data(json.utf8))

        #expect(topic.id == "611205")
        #expect(topic.topicTitle == "Вышел 117 эпизод")
        #expect(topic.commentsCount == 0)
        #expect(topic.forum?.id == "1")
        #expect(topic.user?.id == "16")
        #expect(topic.type == "Topics::NewsTopic")
        #expect(topic.linkedId == "53876")
        #expect(topic.linkedType == .anime)
        #expect(topic.linked?.id == "53876")
        #expect(topic.linked?.episodesAired == 129)
        #expect(topic.viewed == true)
        #expect(topic.lastCommentViewed == nil)
        #expect(topic.event == "episode")
        #expect(topic.episode == 117)
    }
}
