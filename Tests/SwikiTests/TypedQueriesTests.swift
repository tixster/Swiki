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
            statusFilters: [.include(.released)],
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
    func v1AnimesQueryEncodesKindAndSeasonGroupedModes() throws {
        let season2016 = try #require(SwikiSeason(rawValue: "2016"))
        let summer2016 = try #require(SwikiSeason(rawValue: "summer_2016"))

        let query = SwikiV1AnimesQuery(
            season: season2016,
            kindFilters: [.include(.tv), .include(.movie), .exclude(.special)],
            seasonFilters: [.exclude(summer2016)]
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["kind"] == "tv,movie,!special")
        #expect(encoded["season"] == "2016,!summer_2016")
    }

    @Test
    func v1AnimesQueryEncodesStatusFiltersGroupedModes() {
        let query = SwikiV1AnimesQuery(
            statusFilters: [.include(.released), .exclude(.ongoing), .include(.anons)]
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["status"] == "released,!ongoing,anons")
    }

    @Test
    func v1AnimesQueryEncodesCombinedKindStatusAndSeasonFilters() throws {
        let y2016 = try #require(SwikiSeason(rawValue: "2016"))
        let y2015 = try #require(SwikiSeason(rawValue: "2015"))
        let summer2016 = try #require(SwikiSeason(rawValue: "summer_2016"))

        let query = SwikiV1AnimesQuery(
            season: y2016,
            kindFilters: [.include(.tv), .exclude(.movie), .include(.ova)],
            statusFilters: [.include(.released), .exclude(.ongoing)],
            seasonFilters: [.include(y2015), .exclude(summer2016)]
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["kind"] == "tv,!movie,ova")
        #expect(encoded["status"] == "released,!ongoing")
        #expect(encoded["season"] == "2016,2015,!summer_2016")
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

    @Test
    func v1MangasQueryEncodesKindAndSeasonGroupedModes() throws {
        let season2016 = try #require(SwikiSeason(rawValue: "2016"))
        let summer2016 = try #require(SwikiSeason(rawValue: "summer_2016"))

        let query = SwikiV1MangasQuery(
            kindFilters: [.include(.manga), .include(.oneShot), .exclude(.novel)],
            season: season2016,
            seasonFilters: [.exclude(summer2016)]
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["kind"] == "manga,one_shot,!novel")
        #expect(encoded["season"] == "2016,!summer_2016")
    }

    @Test
    func v1MangasQueryEncodesKindFiltersWithStatusAndSeasonFilters() throws {
        let y2016 = try #require(SwikiSeason(rawValue: "2016"))
        let y2015 = try #require(SwikiSeason(rawValue: "2015"))

        let query = SwikiV1MangasQuery(
            kindFilters: [.include(.manga), .exclude(.oneShot), .include(.manhwa)],
            status: .released,
            season: y2016,
            seasonFilters: [.include(y2015)]
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["kind"] == "manga,!one_shot,manhwa")
        #expect(encoded["status"] == "released")
        #expect(encoded["season"] == "2016,2015")
    }

    @Test
    func v1TopicsQueryEncodesTypedValues() throws {
        let page = try #require(SwikiV1TopicsQuery.Page(1))
        let limit = try #require(SwikiV1TopicsQuery.Limit(30))

        let query = SwikiV1TopicsQuery(
            forum: .myClubs,
            linkedID: 42,
            linkedType: .anime,
            type: .entryAnimeTopic,
            page: page,
            limit: limit
        )

        let encoded = query.asSwikiQuery

        #expect(encoded["forum"] == "my_clubs")
        #expect(encoded["linked_id"] == "42")
        #expect(encoded["linked_type"] == "Anime")
        #expect(encoded["type"] == "Topics::EntryTopics::AnimeTopic")
        #expect(encoded["page"] == "1")
        #expect(encoded["limit"] == "30")
    }
}
