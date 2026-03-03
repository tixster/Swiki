//
//  SwikiActor.swift
//  Swiki
//
//  Created by Кирилл Тила on 21.12.2024.
//

import Foundation

@globalActor
struct SwikiActor {
    static let shared = SwikiLimiterActor()
}

actor SwikiLimiterActor {

    // Ограничения согласно API: https://shikimori.io/api/doc
    // API access is limited by 5rps and 90rpm
    private let rpsLimit: Int
    private let rpmLimit: Int
    private let rpsWindow: Duration
    private let rpmWindow: Duration
    private let clock: ContinuousClock

    // Временные метки старта запросов в монотонном времени.
    private var requestTimestamps: [ContinuousClock.Instant] = []

    // MARK: - Инициализация

    init(
        rpsLimit: Int = 5,
        rpmLimit: Int = 90,
        rpsWindow: Duration = .seconds(1),
        rpmWindow: Duration = .seconds(60),
        clock: ContinuousClock = ContinuousClock()
    ) {
        precondition(rpsLimit > 0, "rpsLimit must be > 0")
        precondition(rpmLimit > 0, "rpmLimit must be > 0")
        precondition(rpsWindow > .zero, "rpsWindow must be > 0")
        precondition(rpmWindow > .zero, "rpmWindow must be > 0")

        self.rpsLimit = rpsLimit
        self.rpmLimit = rpmLimit
        self.rpsWindow = rpsWindow
        self.rpmWindow = rpmWindow
        self.clock = clock
    }

    // MARK: - Публичный метод submit<T>

    /// Добавление задачи на выполнение.
    func submit<T: Sendable>(
        _ work: @Sendable @escaping () async throws -> T
    ) async throws -> T {
        // Перед выполнением — ждём, если лимиты превышены.
        try await waitIfNeeded()
        requestTimestamps.append(clock.now)
        return try await work()
    }


    // MARK: - Логика ожидания при превышении лимитов

    private func waitIfNeeded() async throws {
        while true {
            let now = clock.now
            pruneOldTimestamps(relativeTo: now)

            let waitForRpm = rpmDelay(relativeTo: now)
            let waitForRps = rpsDelay(relativeTo: now)
            let waitDuration = max(waitForRpm, waitForRps)

            if waitDuration <= .zero {
                return
            }

            try Task.checkCancellation()
            try await clock.sleep(for: waitDuration)
        }
    }

    private func pruneOldTimestamps(relativeTo now: ContinuousClock.Instant) {
        let oldestAllowed = now.advanced(by: .zero - rpmWindow)
        requestTimestamps.removeAll { $0 <= oldestAllowed }
    }

    private func rpmDelay(relativeTo now: ContinuousClock.Instant) -> Duration {
        guard requestTimestamps.count >= rpmLimit, let oldest = requestTimestamps.first else {
            return .zero
        }

        let availableAt = oldest.advanced(by: rpmWindow)
        return max(.zero, now.duration(to: availableAt))
    }

    private func rpsDelay(relativeTo now: ContinuousClock.Instant) -> Duration {
        let oldestAllowed = now.advanced(by: .zero - rpsWindow)
        let recentRequests = requestTimestamps.filter { $0 > oldestAllowed }

        guard recentRequests.count >= rpsLimit, let oldestInWindow = recentRequests.first else {
            return .zero
        }

        let availableAt = oldestInWindow.advanced(by: rpsWindow)
        return max(.zero, now.duration(to: availableAt))
    }
}
