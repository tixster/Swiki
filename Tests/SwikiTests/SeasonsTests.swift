import Testing
@testable import SwikiModels
import Foundation

@Suite("SeasonsTests")
struct SeasonsTests {

    // MARK: - Тест Ancient
    @Test
    func initAncient() throws {
        // Проверяем создание "ancient" через .init(rawValue:)
        let s1 = try  #require(SwikiSeason(rawValue: "ancient"), "Инициализация с 'ancient' должна быть успешной")
        #expect(s1.ancient, "Поле ancient должно быть true")
        #expect(s1.year == nil)
        #expect(s1.ofYear == nil)
        #expect(s1.yearX == nil)
        #expect(s1.rawValue == "ancient")

        // Проверяем создание через .ancient()
        let s2 = SwikiSeason.ancient()
        #expect(s2.ancient)
        #expect(s2.rawValue == "ancient")
    }

    // MARK: - Тест Year (например, 2011)
    @Test
    func initYear() throws {
        // Попробуем инициализировать 2011
        let sRaw = try #require(SwikiSeason(rawValue: "2011"), "Год '2011' должен быть корректным")
        try testYearSession(sRaw)
        let s = SwikiSeason.year(SwikiSeason.Year(century: .c21, decade: .d10, yearOfDecade: .y1))
        try testYearSession(s)

        func testYearSession(_ s: SwikiSeason) throws {
            #expect(s.ancient == false, "Для 2011 ancient = false")
            #expect(s.year != nil, "year не должен быть nil")
            #expect(s.yearX == nil, "yearX должен быть nil (так как 2011 — не ровное десятилетие)")
            #expect(s.ofYear == nil, "ofYear должен быть nil, так как нет сезона")
            #expect(s.rawValue == "2011")

            // Проверим детали year
            let y = try #require(s.year, "Ожидаем, что year != nil")
            #expect(y.full == 2011)
            #expect(y.century == .c21)
            #expect(y.decade == .d10)
            #expect(y.yearOfDecade == .y1)
        }

    }

    // MARK: - Тест Decade (например, 2010)

    @Test
    func testDecadeSuffixX() throws {
        // Пример: "201X" (т. е. десятилетие 2010–2019)
        let sRaw = try #require(SwikiSeason(rawValue: "201X"), "Строка '201X' должна парситься как десятилетие (2010)")
        try textSuffixXSession(sRaw)
        let s = SwikiSeason.decade(.d10, century: .c21)
        try textSuffixXSession(s)

        func textSuffixXSession(_ s: SwikiSeason) throws {
            #expect(s.ancient == false)
            #expect(s.year == nil)
            #expect(s.yearX != nil)
            #expect(s.ofYear == nil)
            #expect(s.rawValue == "201X")

            let yx = try #require(s.yearX)
            #expect(yx.century == .c21)
            #expect(yx.decade == .d10)
            #expect(yx.year == 2010)
        }

    }

    // MARK: - Тест OfYear (например, "spring_2011")

    @Test
    func initSeasonOfYear() throws {
        let sRaw = try #require(SwikiSeason(rawValue: "spring_2011"), "'spring_2011' должен корректно парситься")
        try testSeasonOfYearSession(sRaw)
        let s = SwikiSeason.seasonOfYear(
            SwikiSeason.OfYear(
                season: .spring,
                year: SwikiSeason.Year(century: .c21, decade: .d10, yearOfDecade: .y1)
            )
        )
        try testSeasonOfYearSession(s)

        func testSeasonOfYearSession(_ s: SwikiSeason) throws {
            #expect(s.ancient == false)
            #expect(s.year == nil)
            #expect(s.yearX == nil)
            #expect(s.rawValue == "spring_2011")
            
            let ofYear = try #require(s.ofYear)
            #expect(ofYear.season == .spring)
            #expect(ofYear.year.full == 2011)
        }

    }

    // MARK: - Тест неправильных входных значений

    @Test
    func initFailure() throws {
        // Неизвестный формат
        #expect(SwikiSeason(rawValue: "unknown_string") == nil)
        // Сезон, которого нет в enum
        #expect(SwikiSeason(rawValue: "autumn_2011") == nil) // нет "autumn", только .fall
        // Год, выходящий за диапазон ( <1900 )
        #expect(SwikiSeason(rawValue: "1899") == nil)
        // Год, выходящий за диапазон ( >=2100 )
        #expect(SwikiSeason(rawValue: "2100") == nil)
        // С неправильным форматом (два нижних подчёркивания)
        #expect(SwikiSeason(rawValue: "spring__2011") == nil)
    }

    // MARK: - Тест граничных случаев: 1900, 2099, "winter_1900", "winter_2099"

    @Test
    func edgeYears() throws {
        // 1900 → это ровное десятилетие c20 + d0 + y0
        let s1900 = try #require(SwikiSeason(rawValue: "1900"))
        let year1900 = try #require(s1900.year)
        #expect(year1900.full == 1900)
        #expect(year1900.century == .c20)
        #expect(year1900.decade == .d00)

        // 2099 → c21 d90 y9
        let s2099 = try #require(SwikiSeason(rawValue: "2099"))
        let year2099 = try #require(s2099.year)
        #expect(year2099.full == 2099)
        #expect(year2099.century == .c21)
        #expect(year2099.decade == .d90)
        #expect(year2099.yearOfDecade == .y9)

        // winter_1900
        let w1900 = try #require(SwikiSeason(rawValue: "winter_1900"))
        let ofYear1900 = try #require(w1900.ofYear)
        #expect(ofYear1900.season == .winter)
        #expect(ofYear1900.year.full == 1900)

        // winter_2099
        let w2099 = try #require(SwikiSeason(rawValue: "winter_2099"))
        let ofYear2099 = try #require(w2099.ofYear)
        #expect(ofYear2099.season == .winter)
        #expect(ofYear2099.year.full == 2099)
    }

}
