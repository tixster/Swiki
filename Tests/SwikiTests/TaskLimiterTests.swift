import Testing
@testable import Swiki
import Foundation

@Suite("TaskLimiter")
struct TaskLimiterTests {

    actor TimesStorage {
        var times: [Date] = []

        func append(_ time: Date) {
            times.append(time)
        }
    }

    /// Проверяет, что 5 задач в секунду проходят без заметной задержки,
    /// а 6-я задача (при rpsLimit = 5) будет «дожидаться» освобождения слота.
    ///
    /// Зависит от реального времени и может флапать.
    @Test
    func oneSecondRateLimit() async throws {
        let limiter = SwikiLimiterActor()

        // Список времени завершения каждого таска.
        let timesStorage = TimesStorage()

        // Запустим 6 задач почти одновременно.
        // Первая пятёрка должна начаться почти сразу,
        // а 6-я — слегка задержаться (из-за лимита в 5 rps).
        try await withThrowingTaskGroup(of: Void.self) { group in
            for i in 1...6 {
                group.addTask { @Sendable in
                    let startTime = Date()
                    _ = try await limiter.submit {
                        return i
                    }

                    let endTime = Date()

                    // Сохраним время завершения
                    await timesStorage.append(endTime)

                    // Выведем, сколько времени заняло
                    let delta = endTime.timeIntervalSince(startTime)
                    print("Task \(i) done, took ~\(String(format: "%.2f", delta))s")
                }
            }

            // Дождёмся завершения всех шести
            try await group.waitForAll()
        }

        var completionTimes = await timesStorage.times
        // Сортируем массив по возрастанию времени, чтобы сравнить интервалы
        completionTimes.sort()

        // Проверим, что у нас действительно 6 отметок.
        #expect(completionTimes.count == 6, "Should have 6 completion timestamps")

        // Проверим примерную разницу между 5-м и 6-м.
        // Ожидаем, что при rpsLimit=5, шестая задача подождёт до ~1 секунды.
        // (В реальном окружении могут быть задержки, поэтому даём небольшую погрешность)
        let fifth = completionTimes[4]
        let sixth = completionTimes[5]
        let delta = sixth.timeIntervalSince(fifth)

        // Если всё сработало, delta должна быть >= 0.9 (или около того),
        // учитывая, что реализация ждёт оставшееся время до «окна» в 1 сек.
        // Для надёжности здесь возьмём ~0.7 чтобы компенсировать неточности среды.
        #expect(delta >= 0.7,  "The 6th task should be delayed by about 1 second due to the rps limit (delta = \(delta))")
    }

    /// Тест, что можно отработать «ошибку» в submitted job.
    /// Показывает, как при броске ошибки внутри `work` всё корректно резюмируется.
    @Test
    func throwingJob() async {
        let limiter = SwikiLimiterActor()
        struct TestError: Error {}
        await #expect(throws: TestError.self, performing: {
            _ = try await limiter.submit {
                throw TestError()
            }
        })
    }

    /// Тест, что даже при большом количестве задач (например, 10),
    /// мы не превышаем 5 rps.
    /// Тут можно измерять общее время, чтобы убедиться, что операции
    /// распределяются как минимум примерно на 1 секунду, если мы запустим 10 шт. подряд.
    @Test
    func multipleTasksOverRpsLimit() async throws {
        let limiter = SwikiLimiterActor()

        let totalTasks = 10
        let timesStorage = TimesStorage()

        let startAll = Date()
        try await withThrowingTaskGroup(of: Void.self) { group in
            for i in 1...totalTasks {
                group.addTask { @Sendable in
                    _ = try await limiter.submit {
                        return i
                    }
                    let startTime = Date()
                    await timesStorage.append(startTime)
                }
            }
            try await group.waitForAll()
        }
        let endAll = Date()
        let totalDelta = endAll.timeIntervalSince(startAll)

        // Если rpsLimit = 5, значит 10 задач не смогут завершиться быстрее, чем за ~1 сек:
        // 5 задач в первой секунде и ещё 5 после открытия окна.
        #expect(totalDelta >= 0.9, "10 tasks with rps=5 should take at least ~1s in total (took \(totalDelta))")
        #expect(totalDelta <= 2.5, "10 tasks with rps=5 should not be delayed excessively (took \(totalDelta))")
    }

    /// Тест, что минутный лимит также соблюдается.
    /// Для скорости теста используем укороченное «минутное» окно = 2 секунды.
    @Test
    func minuteWindowRateLimit() async throws {
        let limiter = SwikiLimiterActor(
            rpsLimit: 10,
            rpmLimit: 3,
            rpsWindow: .seconds(1),
            rpmWindow: .seconds(2)
        )

        let timesStorage = TimesStorage()

        try await withThrowingTaskGroup(of: Void.self) { group in
            for i in 1...4 {
                group.addTask { @Sendable in
                    _ = try await limiter.submit {
                        return i
                    }
                    await timesStorage.append(Date())
                }
            }
            try await group.waitForAll()
        }

        var completionTimes = await timesStorage.times
        completionTimes.sort()

        #expect(completionTimes.count == 4, "Should have 4 completion timestamps")

        let third = completionTimes[2]
        let fourth = completionTimes[3]
        let delta = fourth.timeIntervalSince(third)

        #expect(delta >= 1.8, "4th task should be delayed by ~2s due to rpm window (delta = \(delta))")
    }

}
