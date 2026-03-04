import Foundation

struct SwikiReviewCreatePayloadBody: Encodable, Sendable {
    let review: SwikiReviewCreatePayload
}

public struct SwikiReviewCreatePayload: Encodable, Sendable {

    public let animeId: String
    public let body: String
    public let opinion: SwikiReviewOpinion

    enum CodingKeys: String, CodingKey {
        case animeId = "anime_id"
        case body
        case opinion
    }

    public init(
        animeId: String,
        body: String,
        opinion: SwikiReviewOpinion
    ) {
        self.animeId = animeId
        self.body = body
        self.opinion = opinion
    }

}
