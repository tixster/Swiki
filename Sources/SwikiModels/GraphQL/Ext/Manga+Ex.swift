import Foundation
import GraphQLGeneratorMacros

extension SwikiManga: GraphQLGenerated.Manga {

    func airedOn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.IncompleteDate)? {
        airedOn
    }

    func chapters(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        chapters
    }

    func characterRoles(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.CharacterRole]? {
        characterRoles?.map { $0 as any GraphQLGenerated.CharacterRole }
    }

    func chronology(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.Manga]? {
        chronology?.map { $0 as any GraphQLGenerated.Manga }
    }

    func createdAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: createdAt, key: .createdAt)
    }

    func description(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        description
    }

    func descriptionHtml(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        descriptionHtml
    }

    func descriptionSource(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        descriptionSource
    }

    func english(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        english
    }

    func externalLinks(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.ExternalLink]? {
        externalLinks?.map { $0 as any GraphQLGenerated.ExternalLink }
    }

    func franchise(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        franchise
    }

    func genres(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.Genre]? {
        genres?.map { $0 as any GraphQLGenerated.Genre }
    }

    func id(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        id
    }

    func isCensored(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Bool? {
        isCensored
    }

    func japanese(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        japanese
    }

    func kind(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.MangaKindEnum? {
        GraphQLGenerated.MangaKindEnum(rawValue: kind.rawValue)
    }

    func licenseNameRu(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        licenseNameRu
    }

    func licensors(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String]? {
        licensors
    }

    func malId(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        malId
    }

    func name(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        name
    }

    func opengraphImageUrl(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        opengraphImageUrl?.absoluteString
    }

    func personRoles(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.PersonRole]? {
        personRoles?.map { $0 as any GraphQLGenerated.PersonRole }
    }

    func poster(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Poster)? {
        poster
    }

    func publishers(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.Publisher] {
        []
    }

    func related(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.Related]? {
        related?.map { $0 as any GraphQLGenerated.Related }
    }

    func releasedOn(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.IncompleteDate)? {
        releasedOn
    }

    func russian(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String? {
        russian
    }

    func score(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Double? {
        score.map(Double.init)
    }

    func scoresStats(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.ScoreStat]? {
        scoresStats?.map { $0 as any GraphQLGenerated.ScoreStat }
    }

    func status(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLGenerated.MangaStatusEnum? {
        GraphQLGenerated.MangaStatusEnum(rawValue: status.rawValue)
    }

    func statusesStats(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [any GraphQLGenerated.StatusStat]? {
        nil
    }

    func synonyms(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> [String] {
        synonims
    }

    func topic(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.Topic)? {
        topic
    }

    func updatedAt(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> GraphQLScalars.ISO8601DateTime {
        GraphQLScalars.ISO8601DateTime(date: updatedAt, key: .updatedAt)
    }

    func url(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> String {
        url.absoluteString
    }

    func userRate(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> (any GraphQLGenerated.UserRate)? {
        userRate
    }

    func volumes(context: GraphQLContext, info: GraphQL.GraphQLResolveInfo) async throws -> Int {
        volumes
    }

}

