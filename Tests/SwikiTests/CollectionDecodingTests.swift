import Foundation
import SwikiModels
import Testing

@Suite("CollectionDecoding")
struct CollectionDecodingTests {
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
    func decodesCollectionTopicPayload() throws {
        let json = """
        {
          "id": 270106,
          "topic_title": "Collection 1",
          "body": "Топик обсуждения [collection=1]коллекции[/collection].",
          "html_body": "<div class=\\"collection-groups\\" data-texts=\\"[]\\"></div>",
          "html_footer": "",
          "created_at": "2022-11-26T17:19:29.053+03:00",
          "comments_count": 0,
          "forum": {
            "id": 14,
            "position": 0,
            "name": "Коллекции",
            "permalink": "collections",
            "url": "/forum/collections"
          },
          "user": {
            "id": 23456789,
            "nickname": "user_user",
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
            "last_online_at": "2022-11-26T17:19:26.755+03:00",
            "url": "http://test.host/user_user"
          },
          "type": "Topics::EntryTopics::CollectionTopic",
          "linked_id": 1,
          "linked_type": "Collection",
          "linked": null,
          "viewed": true,
          "last_comment_viewed": null,
          "event": null,
          "episode": null
        }
        """

        let collection = try makeRESTDecoder().decode(SwikiCollection.self, from: Data(json.utf8))

        #expect(collection.id == "270106")
        #expect(collection.topicTitle == "Collection 1")
        #expect(collection.commentsCount == 0)
        #expect(collection.forum?.id == "14")
        #expect(collection.user?.id == "23456789")
        #expect(collection.type == "Topics::EntryTopics::CollectionTopic")
        #expect(collection.linkedId == "1")
        #expect(collection.linkedType == "Collection")
        #expect(collection.viewed == true)
        #expect(collection.lastCommentViewed == nil)
        #expect(collection.event == nil)
        #expect(collection.episode == nil)
    }
}
