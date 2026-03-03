import Foundation
import GraphQLGeneratorRuntime

actor GraphQLContext {
}

extension GraphQLScalars {

    struct ISO8601DateTime: GraphQLScalar {

        let date: String
        let key: CodingKeys

        init(date: Date, key: CodingKeys) {
            self.date = ISO8601DateFormatter().string(from: date)
            self.key = key
        }

        enum CodingKeys: CodingKey {
            case createdAt
            case updatedAt
            case lastOnlineAt
        }

        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(date, forKey: key)
        }

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: GraphQLScalars.ISO8601DateTime.CodingKeys.self)

            if let createdAt = try? container.decode(String.self, forKey: .createdAt) {
                self.date = createdAt
            } else if let updatedAt = try? container.decode(String.self, forKey: .updatedAt) {
                self.date = updatedAt
            }

            throw DecodingError.dataCorruptedError(forKey: CodingKeys.createdAt, in: container, debugDescription: "Could not decode ISO8601DateTime")

        }

        static func serialize(this: GraphQLScalars.ISO8601DateTime) throws -> GraphQL.Map {
            .string(this.date)
        }
        
        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "ISO8601DateTime cannot represent non-string value: \(map)")
            }
        }
        
        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "Date cannot represent non-string value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }

    }

    struct ISO8601Date: GraphQLScalar {

        let date: String
        let key: CodingKeys

        init(date: Date, key: CodingKeys) {
            self.date = ISO8601DateFormatter().string(from: date)
            self.key = key
        }

        enum CodingKeys: CodingKey {
            case createdAt
            case updatedAt
        }

        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(date, forKey: key)
        }

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: GraphQLScalars.ISO8601Date.CodingKeys.self)

            if let createdAt = try? container.decode(String.self, forKey: .createdAt) {
                self.date = createdAt
            } else if let updatedAt = try? container.decode(String.self, forKey: .updatedAt) {
                self.date = updatedAt
            }

            throw DecodingError.dataCorruptedError(forKey: CodingKeys.createdAt, in: container, debugDescription: "Could not decode ISO8601DateTime")

        }

        static func serialize(this: GraphQLScalars.ISO8601Date) throws -> GraphQL.Map {
            .string(this.date)
        }

        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "ISO8601Date cannot represent non-string value: \(map)")
            }
        }

        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "Date cannot represent non-string value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }

    }

    struct PositiveInt: GraphQLScalar {

        let value: Int

        init(value: Int) {
            self.value = value
        }

        init(from decoder: any Decoder) throws {
            self.value = try decoder.singleValueContainer().decode(Int.self)
        }

        func encode(to encoder: any Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }

        static func serialize(this: GraphQLScalars.PositiveInt) throws -> GraphQL.Map {
            .int(this.value)
        }
        
        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .number:
                return map
            default:
                throw GraphQLError(message: "PositiveInt cannot represent non-int value: \(map)")
            }
        }
        
        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? IntValue, let int = Int(ast.value) else {
                throw GraphQLError(
                    message: "PositiveInt cannot represent non-int value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .int(int)
        }

    }

    struct AnimeKindString: GraphQLScalar {

        let kind: GraphQLGenerated.AnimeKindEnum

        init(kind: GraphQLGenerated.AnimeKindEnum) {
            self.kind = kind
        }

        init(from decoder: any Decoder) throws {
            self.kind = try decoder.singleValueContainer().decode(GraphQLGenerated.AnimeKindEnum.self)
        }

        func encode(to encoder: any Encoder) throws {
            try kind.encode(to: encoder)
        }

        static func serialize(this: GraphQLScalars.AnimeKindString) throws -> GraphQL.Map {
            .string(this.kind.rawValue)
        }

        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "PositiveInt cannot represent non-int value: \(map)")
            }
        }

        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "PositiveInt cannot represent non-int value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }

    }

    struct AnimeStatusString: GraphQLScalar {

        let status: GraphQLGenerated.AnimeStatusEnum

        init(status: GraphQLGenerated.AnimeStatusEnum) {
            self.status = status
        }

        init(from decoder: any Decoder) throws {
            self.status = try decoder.singleValueContainer().decode(GraphQLGenerated.AnimeStatusEnum.self)
        }

        func encode(to encoder: any Encoder) throws {
            try status.encode(to: encoder)
        }

        static func serialize(this: GraphQLScalars.AnimeStatusString) throws -> GraphQL.Map {
            .string(this.status.rawValue)
        }

        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "AnimeStatusString cannot represent non-string value: \(map)")
            }
        }

        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "AnimeStatusString cannot represent non-string value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }
    }

    struct MangaKindString: GraphQLScalar {

        let kind: GraphQLGenerated.MangaKindEnum

        init(kind: GraphQLGenerated.MangaKindEnum) {
            self.kind = kind
        }

        init(from decoder: any Decoder) throws {
            self.kind = try decoder.singleValueContainer().decode(GraphQLGenerated.MangaKindEnum.self)
        }

        func encode(to encoder: any Encoder) throws {
            try kind.encode(to: encoder)
        }

        static func serialize(this: GraphQLScalars.MangaKindString) throws -> GraphQL.Map {
            .string(this.kind.rawValue)
        }

        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "MangaKindString cannot represent non-string value: \(map)")
            }
        }

        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "MangaKindString cannot represent non-string value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }

    }

    struct MangaStatusString: GraphQLScalar {

        let status: GraphQLGenerated.MangaStatusEnum

        init(status: GraphQLGenerated.MangaStatusEnum) {
            self.status = status
        }

        init(from decoder: any Decoder) throws {
            self.status = try decoder.singleValueContainer().decode(GraphQLGenerated.MangaStatusEnum.self)
        }

        func encode(to encoder: any Encoder) throws {
            try status.encode(to: encoder)
        }

        static func serialize(this: GraphQLScalars.MangaStatusString) throws -> GraphQL.Map {
            .string(this.status.rawValue)
        }

        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "MangaStatusString cannot represent non-string value: \(map)")
            }
        }

        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "MangaStatusString cannot represent non-string value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }
    }

    struct SeasonString: GraphQLScalar {
        let value: String
        init(value: String) { self.value = value }
        init(from decoder: any Decoder) throws { self.value = try decoder.singleValueContainer().decode(String.self) }
        func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
        static func serialize(this: GraphQLScalars.SeasonString) throws -> GraphQL.Map { .string(this.value) }
        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map { case .string: return map; default: throw GraphQLError(message: "SeasonString cannot represent non-string value: \(map)") }
        }
        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(message: "SeasonString cannot represent non-string value: \(print(ast: value))", nodes: [value])
            }
            return .string(ast.value)
        }
    }

    struct DurationString: GraphQLScalar {
        let value: String
        init(value: String) { self.value = value }
        init(from decoder: any Decoder) throws { self.value = try decoder.singleValueContainer().decode(String.self) }
        func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
        static func serialize(this: GraphQLScalars.DurationString) throws -> GraphQL.Map { .string(this.value) }
        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map { case .string: return map; default: throw GraphQLError(message: "DurationString cannot represent non-string value: \(map)") }
        }
        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(message: "DurationString cannot represent non-string value: \(print(ast: value))", nodes: [value])
            }
            return .string(ast.value)
        }
    }

    struct RatingString: GraphQLScalar {

        let rating: GraphQLGenerated.AnimeRatingEnum

        init(rating: GraphQLGenerated.AnimeRatingEnum) {
            self.rating = rating
        }

        init(from decoder: any Decoder) throws {
            self.rating = try decoder.singleValueContainer().decode(GraphQLGenerated.AnimeRatingEnum.self)
        }

        func encode(to encoder: any Encoder) throws {
            try rating.encode(to: encoder)
        }

        static func serialize(this: GraphQLScalars.RatingString) throws -> GraphQL.Map {
            .string(this.rating.rawValue)
        }

        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "RatingString cannot represent non-string value: \(map)")
            }
        }

        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "RatingString cannot represent non-string value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }
    }

    struct OriginString: GraphQLScalar {

        let origin: GraphQLGenerated.AnimeOriginEnum

        init(origin: GraphQLGenerated.AnimeOriginEnum) {
            self.origin = origin
        }

        init(from decoder: any Decoder) throws {
            self.origin = try decoder.singleValueContainer().decode(GraphQLGenerated.AnimeOriginEnum.self)
        }

        func encode(to encoder: any Encoder) throws {
            try origin.encode(to: encoder)
        }

        static func serialize(this: GraphQLScalars.OriginString) throws -> GraphQL.Map {
            .string(this.origin.rawValue)
        }

        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map {
            case .string:
                return map
            default:
                throw GraphQLError(message: "OriginString cannot represent non-string value: \(map)")
            }
        }

        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(
                    message: "OriginString cannot represent non-string value: \(print(ast: value))",
                    nodes: [value]
                )
            }
            return .string(ast.value)
        }
    }

    struct MylistString: GraphQLScalar {
        let value: String
        init(value: String) { self.value = value }
        init(from decoder: any Decoder) throws { self.value = try decoder.singleValueContainer().decode(String.self) }
        func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
        static func serialize(this: GraphQLScalars.MylistString) throws -> GraphQL.Map { .string(this.value) }
        static func parseValue(map: GraphQL.Map) throws -> GraphQL.Map {
            switch map { case .string: return map; default: throw GraphQLError(message: "MylistString cannot represent non-string value: \(map)") }
        }
        static func parseLiteral(value: any GraphQL.Value) throws -> GraphQL.Map {
            guard let ast = value as? StringValue else {
                throw GraphQLError(message: "MylistString cannot represent non-string value: \(print(ast: value))", nodes: [value])
            }
            return .string(ast.value)
        }
    }

}
