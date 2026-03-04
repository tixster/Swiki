import Foundation

public enum SwikiClubJoinPolicy: String, Codable, Sendable {
    case free
    case memberInvite = "member_invite"
    case adminInvite = "admin_invite"
    case ownerInvite = "owner_invite"
}

public enum SwikiClubCommentPolicy: String, Codable, Sendable {
    case free
    case members
    case admins
}

public enum SwikiClubImageUploadPolicy: String, Codable, Sendable {
    case members
    case admins
}

public enum SwikiClubTopicPolicy: String, Codable, Sendable {
    case members
    case admins
}

public enum SwikiClubUserRole: String, Codable, Sendable {
    case member
    case admin
}
