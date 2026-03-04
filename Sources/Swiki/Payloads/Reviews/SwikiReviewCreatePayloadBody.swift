import Foundation

struct SwikiReviewUpdatePayloadBody: Encodable, Sendable {
    let review: SwikiReviewUpdatePayload
}

public struct SwikiReviewUpdatePayload: Encodable, Sendable {

    public let body: String
    public let opinion: SwikiReviewOpinion?

    enum CodingKeys: String, CodingKey {
        case body
        case opinion
    }

    public init(
        body: String,
        opinion: SwikiReviewOpinion?
    ) {
        self.body = body
        self.opinion = opinion
    }

}
