import Foundation
import SwikiModels
import Testing

@Suite("CharacterPersonPreviewDecoding")
struct CharacterPersonPreviewDecodingTests {
    @Test
    func decodesCharacterPreviewPayload() throws {
        let json = """
        {
          "id": 6,
          "name": "character_6",
          "russian": "персонаж_6",
          "image": {
            "original": "/assets/globals/missing_original.jpg",
            "preview": "/assets/globals/missing_preview.jpg",
            "x96": "/assets/globals/missing_x96.jpg",
            "x48": "/assets/globals/missing_x48.jpg"
          },
          "url": "/characters/6-character-6"
        }
        """

        let preview = try JSONDecoder().decode(SwikiCharacterPreview.self, from: Data(json.utf8))

        #expect(preview.id == "6")
        #expect(preview.name == "character_6")
        #expect(preview.russian == "персонаж_6")
        #expect(preview.url.path == "/characters/6-character-6")
    }

    @Test
    func decodesPersonPreviewPayload() throws {
        let json = """
        {
          "id": 10,
          "name": "person_8",
          "russian": "человек_10",
          "image": {
            "original": "/assets/globals/missing_original.jpg",
            "preview": "/assets/globals/missing_preview.jpg",
            "x96": "/assets/globals/missing_x96.jpg",
            "x48": "/assets/globals/missing_x48.jpg"
          },
          "url": "/people/10-person-8"
        }
        """

        let preview = try JSONDecoder().decode(SwikiPersonPreview.self, from: Data(json.utf8))

        #expect(preview.id == "10")
        #expect(preview.name == "person_8")
        #expect(preview.russian == "человек_10")
        #expect(preview.url.path == "/people/10-person-8")
    }

    @Test
    func decodesRoleWithCharacterAndPersonPreview() throws {
        let json = """
        {
          "roles": ["Main"],
          "roles_russian": ["Главная"],
          "character": {
            "id": 6,
            "name": "character_6",
            "russian": "персонаж_6",
            "image": {
              "original": "/assets/globals/missing_original.jpg",
              "preview": "/assets/globals/missing_preview.jpg",
              "x96": "/assets/globals/missing_x96.jpg",
              "x48": "/assets/globals/missing_x48.jpg"
            },
            "url": "/characters/6-character-6"
          },
          "person": {
            "id": 10,
            "name": "person_8",
            "russian": "человек_10",
            "image": {
              "original": "/assets/globals/missing_original.jpg",
              "preview": "/assets/globals/missing_preview.jpg",
              "x96": "/assets/globals/missing_x96.jpg",
              "x48": "/assets/globals/missing_x48.jpg"
            },
            "url": "/people/10-person-8"
          }
        }
        """

        let role = try JSONDecoder().decode(SwikiRole.self, from: Data(json.utf8))

        #expect(role.roles == ["Main"])
        #expect(role.rolesRu == ["Главная"])
        #expect(role.character?.id == "6")
        #expect(role.person?.id == "10")
    }
}
