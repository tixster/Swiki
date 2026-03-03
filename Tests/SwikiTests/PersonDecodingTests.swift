import Foundation
import SwikiModels
import Testing

@Suite("PersonDecoding")
struct PersonDecodingTests {
    @Test
    func decodesPersonPayload() throws {
        let json = """
        {
          "id": 3,
          "name": "Satsuki Yukino",
          "russian": "Сацуки Юкино",
          "image": {
            "original": "/system/people/original/3.jpg?1712003412",
            "preview": "/system/people/preview/3.jpg?1712003412",
            "x96": "/system/people/x96/3.jpg?1712003412",
            "x48": "/system/people/x48/3.jpg?1712003412"
          },
          "url": "/people/3-satsuki-yukino",
          "japanese": "ゆきの さつき",
          "job_title": "Сэйю",
          "birth_on": { "day": 25, "year": 1970, "month": 5 },
          "deceased_on": {},
          "website": "https://ameblo.jp/yukino-hime/",
          "groupped_roles": [
            ["Сэйю", 177],
            ["Исполнение гл. муз. темы", 5]
          ],
          "roles": [
            {
              "characters": [
                {
                  "id": 5988,
                  "name": "Rosé Tomas",
                  "russian": "Роза Томас",
                  "image": {
                    "original": "/system/characters/original/5988.jpg?1712018704",
                    "preview": "/system/characters/preview/5988.jpg?1712018704",
                    "x96": "/system/characters/x96/5988.jpg?1712018704",
                    "x48": "/system/characters/x48/5988.jpg?1712018704"
                  },
                  "url": "/characters/5988-ros-tomas"
                }
              ],
              "animes": [
                {
                  "id": 121,
                  "name": "Fullmetal Alchemist",
                  "russian": "Стальной алхимик",
                  "image": {
                    "original": "/system/animes/original/121.jpg?1711949852",
                    "preview": "/system/animes/preview/121.jpg?1711949852",
                    "x96": "/system/animes/x96/121.jpg?1711949852",
                    "x48": "/system/animes/x48/121.jpg?1711949852"
                  },
                  "url": "/animes/z121-fullmetal-alchemist",
                  "kind": "tv",
                  "score": "8.11",
                  "status": "released",
                  "episodes": 51,
                  "episodes_aired": 0,
                  "aired_on": "2003-10-04",
                  "released_on": "2004-10-02"
                }
              ]
            }
          ],
          "works": [
            {
              "anime": {
                "id": 191,
                "name": "Love Hina Christmas Special: Silent Eve",
                "russian": "Любовь и Хина: Новогодний спецвыпуск",
                "image": {
                  "original": "/system/animes/original/191.jpg?1711961184",
                  "preview": "/system/animes/preview/191.jpg?1711961184",
                  "x96": "/system/animes/x96/191.jpg?1711961184",
                  "x48": "/system/animes/x48/191.jpg?1711961184"
                },
                "url": "/animes/191-love-hina-christmas-special-silent-eve",
                "kind": "tv_special",
                "score": "7.3",
                "status": "released",
                "episodes": 1,
                "episodes_aired": 0,
                "aired_on": "2000-12-25",
                "released_on": null
              },
              "manga": null,
              "role": "Исполнение гл. муз. темы"
            }
          ],
          "topic_id": 209435,
          "person_favoured": false,
          "producer": false,
          "producer_favoured": false,
          "mangaka": false,
          "mangaka_favoured": false,
          "seyu": true,
          "seyu_favoured": false,
          "updated_at": "2026-03-03T02:04:36.252+03:00",
          "thread_id": 209435,
          "birthday": { "day": 25, "year": 1970, "month": 5 }
        }
        """

        let decoder = JSONDecoder()
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

            let yyyyMMdd = DateFormatter()
            yyyyMMdd.dateFormat = "yyyy-MM-dd"
            yyyyMMdd.locale = Locale(identifier: "en_US_POSIX")
            yyyyMMdd.timeZone = TimeZone(secondsFromGMT: 0)
            if let parsed = yyyyMMdd.date(from: rawValue) {
                return parsed
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Unsupported date format: \\(rawValue)"
            )
        }

        let person = try decoder.decode(SwikiPerson.self, from: Data(json.utf8))

        #expect(person.id == "3")
        #expect(person.jobTitle == "Сэйю")
        #expect(person.birthOn?.year == 1970)
        #expect(person.deceasedOn?.year == nil)
        #expect(person.birthday?.month == 5)
        #expect(person.grouppedRoles?.first?.role == "Сэйю")
        #expect(person.grouppedRoles?.first?.count == 177)
        #expect(person.roles?.first?.characters?.first?.id == "5988")
        #expect(person.roles?.first?.animes?.first?.kind == .tv)
        #expect(person.works?.first?.role == "Исполнение гл. муз. темы")
        #expect(person.works?.first?.roleRussian == nil)
        #expect(person.topicId == "209435")
        #expect(person.threadId == "209435")
        #expect(person.seyu == true)
    }
}
