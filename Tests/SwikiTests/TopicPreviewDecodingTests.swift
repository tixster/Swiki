import Foundation
import SwikiModels
import Testing

@Suite("TopicUpdatesDecoding")
struct TopicUpdatesDecodingTests {
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
    func decodesTopicUpdatesPayload() throws {
        let json = """
        {
          "id": 270122,
          "topic_title": "topic_12",
          "body": "blablalbla",
          "html_body": "blablalbla",
          "html_footer": "",
          "created_at": "2022-11-26T17:19:32.012+03:00",
          "comments_count": 0,
          "forum": {
            "id": 8,
            "position": 0,
            "name": "Оффтопик",
            "permalink": "offtopic",
            "url": "/forum/offtopic"
          },
          "user": {
            "id": 23456791,
            "nickname": "week_registered",
            "avatar": "/assets/globals/missing_avatar/x48.png",
            "image": {
              "x160": "/assets/globals/missing_avatar/x160.png",
              "x148": "/assets/globals/missing_avatar/x148.png",
              "x80": "/assets/globals/missing_avatar/x80.png",
              "x64": "/assets/globals/missing_avatar/x64.png",
              "x48": "/assets/globals/missing_avatar/x48.png",
              "x32": "/assets/globals/missing_avatar/x32.png",
              "x16": "/assets/globals/missing_avatar/x16.png"
            },
            "last_online_at": "2022-11-26T17:19:26.907+03:00",
            "url": "http://test.host/week_registered"
          },
          "type": "Topic",
          "linked_id": null,
          "linked_type": null,
          "linked": null,
          "viewed": true,
          "last_comment_viewed": null,
          "event": null,
          "episode": null
        }
        """

        let topic = try makeRESTDecoder().decode(SwikiTopic.self, from: Data(json.utf8))

        #expect(topic.id == "270122")
        #expect(topic.topicTitle == "topic_12")
        #expect(topic.body == "blablalbla")
        #expect(topic.htmlBody == "blablalbla")
        #expect(topic.htmlFooter == "")
        #expect(topic.commentsCount == 0)
        #expect(topic.forum?.id == "8")
        #expect(topic.user?.id == "23456791")
        #expect(topic.type == "Topic")
        #expect(topic.linkedId == nil)
        #expect(topic.linkedType == nil)
        #expect(topic.linked == nil)
        #expect(topic.viewed == true)
        #expect(topic.lastCommentViewed == nil)
        #expect(topic.event == nil)
        #expect(topic.episode == nil)
    }
}
