import Swiki
import SwikiModels
import Testing

@Suite("TypedQueries")
struct TypedQueriesTests {
    @Test
    func v1AnimesQueryEncodesExpectedKeys() {
        let query = SwikiV1AnimesQuery(
            page: 2,
            limit: 10,
            order: .ranked,
            status: .released,
            duration: .lessThan10Minutes,
            genre: [1, 2],
            censored: true,
            search: "monogatari"
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["page"] == "2")
        #expect(encoded["limit"] == "10")
        #expect(encoded["order"] == "ranked")
        #expect(encoded["status"] == "released")
        #expect(encoded["duration"] == "S")
        #expect(encoded["genre"] == "1,2")
        #expect(encoded["censored"] == "true")
        #expect(encoded["search"] == "monogatari")
    }

    @Test
    func v1UserRatesQueryEncodesExpectedKeys() {
        let query = SwikiV1UserRatesQuery(
            page: 1,
            limit: 50,
            userID: "99",
            targetID: "123",
            targetType: .anime,
            status: .watching
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["page"] == "1")
        #expect(encoded["limit"] == "50")
        #expect(encoded["user_id"] == "99")
        #expect(encoded["target_id"] == "123")
        #expect(encoded["target_type"] == "Anime")
        #expect(encoded["status"] == "watching")
    }

    @Test
    func v2UserRatesQueryEncodesExpectedKeys() {
        let query = SwikiV2UserRatesQuery(
            page: 3,
            limit: 15,
            userID: "77",
            status: .completed
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["page"] == "3")
        #expect(encoded["limit"] == "15")
        #expect(encoded["user_id"] == "77")
        #expect(encoded["status"] == "completed")
    }
}
