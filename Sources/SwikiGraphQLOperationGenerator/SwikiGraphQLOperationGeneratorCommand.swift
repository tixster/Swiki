import Foundation
import GraphQL
import ArgumentParser

private enum GeneratorError: Error, LocalizedError {
    case invalidArguments(String)
    case missingOperationName(file: String)
    case rootTypeMissing(OperationType)
    case unknownParentType(String)
    case unknownField(parent: String, field: String)
    case missingSelectionSet(field: String, type: String)

    var errorDescription: String? {
        switch self {
        case let .invalidArguments(message):
            return message
        case let .missingOperationName(file):
            return "Operation in \(file) must have a name"
        case let .rootTypeMissing(operation):
            return "Root type for operation \(operation.rawValue) was not found in schema"
        case let .unknownParentType(parent):
            return "Unknown parent GraphQL type: \(parent)"
        case let .unknownField(parent, field):
            return "Unknown field \(field) on type \(parent)"
        case let .missingSelectionSet(field, type):
            return "Field \(field) of composite type \(type) requires a selection set"
        }
    }
}

private struct SchemaIndex {
    var queryTypeName: String = "Query"
    var mutationTypeName: String?
    var subscriptionTypeName: String?

    var objectFields: [String: [String: FieldDefinition]] = [:]
    var interfaceFields: [String: [String: FieldDefinition]] = [:]
    var enumTypes: Set<String> = []
    var scalarTypes: Set<String> = []
    var inputObjectFields: [String: [String: InputValueDefinition]] = [:]

    mutating func absorb(document: Document) {
        for definition in document.definitions {
            if let schemaDefinition = definition as? SchemaDefinition {
                for operationType in schemaDefinition.operationTypes {
                    switch operationType.operation {
                    case .query:
                        queryTypeName = operationType.type.name.value
                    case .mutation:
                        mutationTypeName = operationType.type.name.value
                    case .subscription:
                        subscriptionTypeName = operationType.type.name.value
                    }
                }
                continue
            }

            if let objectDefinition = definition as? ObjectTypeDefinition {
                mergeObject(typeName: objectDefinition.name.value, fields: objectDefinition.fields)
                continue
            }

            if let interfaceDefinition = definition as? InterfaceTypeDefinition {
                mergeInterface(typeName: interfaceDefinition.name.value, fields: interfaceDefinition.fields)
                continue
            }

            if let enumDefinition = definition as? EnumTypeDefinition {
                enumTypes.insert(enumDefinition.name.value)
                continue
            }

            if let scalarDefinition = definition as? ScalarTypeDefinition {
                scalarTypes.insert(scalarDefinition.name.value)
                continue
            }

            if let inputObjectDefinition = definition as? InputObjectTypeDefinition {
                mergeInputObject(typeName: inputObjectDefinition.name.value, fields: inputObjectDefinition.fields)
                continue
            }

            if let objectExtension = definition as? TypeExtensionDefinition {
                mergeObject(typeName: objectExtension.definition.name.value, fields: objectExtension.definition.fields)
                continue
            }

            if let interfaceExtension = definition as? InterfaceExtensionDefinition {
                mergeInterface(typeName: interfaceExtension.definition.name.value, fields: interfaceExtension.definition.fields)
                continue
            }

            if let inputExtension = definition as? InputObjectExtensionDefinition {
                mergeInputObject(typeName: inputExtension.definition.name.value, fields: inputExtension.definition.fields)
                continue
            }
        }

        if mutationTypeName == nil, objectFields["Mutation"] != nil {
            mutationTypeName = "Mutation"
        }
        if subscriptionTypeName == nil, objectFields["Subscription"] != nil {
            subscriptionTypeName = "Subscription"
        }
    }

    private mutating func mergeObject(typeName: String, fields: [FieldDefinition]) {
        var current = objectFields[typeName] ?? [:]
        for field in fields {
            current[field.name.value] = field
        }
        objectFields[typeName] = current
    }

    private mutating func mergeInterface(typeName: String, fields: [FieldDefinition]) {
        var current = interfaceFields[typeName] ?? [:]
        for field in fields {
            current[field.name.value] = field
        }
        interfaceFields[typeName] = current
    }

    private mutating func mergeInputObject(typeName: String, fields: [InputValueDefinition]) {
        var current = inputObjectFields[typeName] ?? [:]
        for field in fields {
            current[field.name.value] = field
        }
        inputObjectFields[typeName] = current
    }

    func rootTypeName(for operation: OperationType) -> String? {
        switch operation {
        case .query:
            return queryTypeName
        case .mutation:
            return mutationTypeName
        case .subscription:
            return subscriptionTypeName
        }
    }

    func field(parentTypeName: String, fieldName: String) -> FieldDefinition? {
        if let objectField = objectFields[parentTypeName]?[fieldName] {
            return objectField
        }
        if let interfaceField = interfaceFields[parentTypeName]?[fieldName] {
            return interfaceField
        }
        return nil
    }

    func isComposite(typeName: String) -> Bool {
        objectFields[typeName] != nil || interfaceFields[typeName] != nil
    }

    func isEnum(typeName: String) -> Bool {
        enumTypes.contains(typeName)
    }

    func isInputObject(typeName: String) -> Bool {
        inputObjectFields[typeName] != nil
    }
}

private struct PropertyDefinition {
    let jsonName: String
    let swiftName: String
    let swiftType: String
}

private struct StructDefinition {
    let name: String
    var properties: [PropertyDefinition]
    var nestedStructs: [StructDefinition]
}

private struct RenderedType {
    let swiftType: String
    let nestedStructs: [StructDefinition]
}

private struct ReusableOutputObjectType {
    let swiftType: String
    let requiredFields: Set<String>
}

private struct RenderedOperation {
    let typeName: String
    let body: String
}

private let swikiOutputEnumTypeMap: [String: String] = [
    "AnimeKindEnum": "SwikiAnimeKind",
    "AnimeRatingEnum": "SwikiAnimeRating",
    "AnimeStatusEnum": "SwikiAnimeStatus",
    "ContestMatchStateEnum": "SwikiContestMatchState",
    "ContestMemberTypeEnum": "SwikiContestMemberType",
    "ContestRoundStateEnum": "SwikiContestRoundState",
    "ContestStateEnum": "SwikiContestState",
    "ContestStrategyTypeEnum": "SwikiContestStrategyType",
    "ExternalLinkKindEnum": "SwikiExternalLinkKind",
    "GenreEntryTypeEnum": "SwikiGenreEntryType",
    "GenreKindEnum": "SwikiGenreKind",
    "MangaKindEnum": "SwikiMangaKind",
    "MangaStatusEnum": "SwikiMangaStatus",
    "OrderEnum": "SwikiOrder",
    "RelationKindEnum": "SwikiRelationKind",
    "SortOrderEnum": "SwikiSortOrderType",
    "UserRateOrderFieldEnum": "SwikiUserRateOrderField",
    "UserRateStatusEnum": "SwikiUserRateStatus",
    "UserRateTargetTypeEnum": "SwikiUserRateTargetType",
    "VideoKindEnum": "SwikiVideoKind"
]

private let swikiInputEnumTypeMap: [String: String] = [
    "AnimeKindEnum": "SwikiAnimeKind",
    "AnimeRatingEnum": "SwikiAnimeRating",
    "AnimeStatusEnum": "SwikiAnimeStatus",
    "OrderEnum": "SwikiOrder",
    "SortOrderEnum": "SwikiSortOrderType",
    "UserRateOrderFieldEnum": "SwikiUserRateOrderField",
    "UserRateStatusEnum": "SwikiUserRateStatus",
    "UserRateTargetTypeEnum": "SwikiUserRateTargetType",
    "VideoKindEnum": "SwikiVideoKind"
]

private let swikiReusableOutputObjectTypeMap: [String: ReusableOutputObjectType] = [
    "IncompleteDate": ReusableOutputObjectType(swiftType: "SwikiIncompleteDate", requiredFields: [])
]

private struct OperationFile {
    let path: String
    let document: Document
    let source: String
}

private struct Generator {
    let schema: SchemaIndex

    func render(operationFile: OperationFile) throws -> [RenderedOperation] {
        let fragments = operationFile.document.definitions.reduce(into: [String: FragmentDefinition]()) { result, definition in
            if let fragment = definition as? FragmentDefinition {
                result[fragment.name.value] = fragment
            }
        }

        let operations = operationFile.document.definitions.compactMap { $0 as? OperationDefinition }
        return try operations.map { operation in
            try renderOperation(
                operation,
                source: operationFile.source,
                fragments: fragments,
                filePath: operationFile.path
            )
        }
    }

    private func renderOperation(
        _ operation: OperationDefinition,
        source: String,
        fragments: [String: FragmentDefinition],
        filePath: String
    ) throws -> RenderedOperation {
        guard let operationName = operation.name?.value else {
            throw GeneratorError.missingOperationName(file: filePath)
        }

        guard let rootTypeName = schema.rootTypeName(for: operation.operation) else {
            throw GeneratorError.rootTypeMissing(operation.operation)
        }

        let operationTypeName = swiftTypeName(operationName + "Operation")
        let dataStruct = try renderSelectionSetStruct(
            structName: "Data",
            parentTypeName: rootTypeName,
            selectionSet: operation.selectionSet,
            fragments: fragments
        )

        var lines: [String] = []
        lines.append("    struct \(operationTypeName): SwikiGraphQLOperation {")
        lines.append("        public static let operationName: String? = \(swiftStringLiteral(operationName))")
        lines.append("        public static let operationDocument: String = \"\"\"")
        lines.append(contentsOf: swiftMultilineStringBodyLines(source, indent: "        "))
        lines.append("        \"\"\"")
        lines.append("")

        if operation.variableDefinitions.isEmpty {
            lines.append("        public typealias Variables = SwikiGraphQLEmptyVariables")
            lines.append("        public let variables: Variables")
            lines.append("        public init(variables: Variables = Variables()) {")
            lines.append("            self.variables = variables")
            lines.append("        }")
        } else {
            lines.append("        public struct Variables: Encodable, Sendable {")
            for variable in operation.variableDefinitions {
                let variableName = variable.variable.name.value
                let swiftName = escapedSwiftIdentifier(variableName)
                let baseSwiftType = try swiftInputType(from: variable.type)
                let swiftType: String
                if variable.defaultValue != nil, !baseSwiftType.hasSuffix("?") {
                    swiftType = "\(baseSwiftType)?"
                } else {
                    swiftType = baseSwiftType
                }
                lines.append("            public let \(swiftName): \(swiftType)")
            }
            lines.append("")

            let requiredVariables = operation.variableDefinitions.filter {
                $0.defaultValue == nil && isNonNullType($0.type)
            }
            let optionalVariables = operation.variableDefinitions.filter { variable in
                !requiredVariables.contains(where: { required in
                    required.variable.name.value == variable.variable.name.value
                })
            }

            let orderedVariables = requiredVariables + optionalVariables
            let parameterList = orderedVariables.map { variable -> String in
                let variableName = variable.variable.name.value
                let swiftName = escapedSwiftIdentifier(variableName)
                let baseSwiftType = (try? swiftInputType(from: variable.type)) ?? "String"
                let finalType: String
                if variable.defaultValue != nil, !baseSwiftType.hasSuffix("?") {
                    finalType = "\(baseSwiftType)?"
                } else {
                    finalType = baseSwiftType
                }

                if requiredVariables.contains(where: { $0.variable.name.value == variableName }) {
                    return "\(swiftName): \(finalType)"
                }
                return "\(swiftName): \(finalType) = nil"
            }.joined(separator: ", ")

            lines.append("            public init(\(parameterList)) {")
            for variable in orderedVariables {
                let swiftName = escapedSwiftIdentifier(variable.variable.name.value)
                lines.append("                self.\(swiftName) = \(swiftName)")
            }
            lines.append("            }")
            lines.append("        }")
            lines.append("")
            lines.append("        public let variables: Variables")
            lines.append("        public init(variables: Variables) {")
            lines.append("            self.variables = variables")
            lines.append("        }")
        }

        lines.append("")
        lines.append(contentsOf: renderStruct(dataStruct, indentLevel: 2))
        lines.append("    }")

        return RenderedOperation(
            typeName: operationTypeName,
            body: lines.joined(separator: "\n")
        )
    }

    private func renderSelectionSetStruct(
        structName: String,
        parentTypeName: String,
        selectionSet: SelectionSet,
        fragments: [String: FragmentDefinition]
    ) throws -> StructDefinition {
        guard schema.objectFields[parentTypeName] != nil || schema.interfaceFields[parentTypeName] != nil else {
            throw GeneratorError.unknownParentType(parentTypeName)
        }

        let selections = expandSelections(
            selectionSet: selectionSet,
            parentTypeName: parentTypeName,
            fragments: fragments
        )

        var properties: [PropertyDefinition] = []
        var nestedStructs: [StructDefinition] = []
        var consumedNames: Set<String> = []

        for field in selections {
            let responseName = field.alias?.value ?? field.name.value
            guard consumedNames.insert(responseName).inserted else {
                continue
            }

            let swiftName = escapedSwiftIdentifier(responseName)

            if field.name.value == "__typename" {
                properties.append(
                    PropertyDefinition(
                        jsonName: responseName,
                        swiftName: swiftName,
                        swiftType: "String"
                    )
                )
                continue
            }

            guard let fieldDefinition = schema.field(parentTypeName: parentTypeName, fieldName: field.name.value) else {
                throw GeneratorError.unknownField(parent: parentTypeName, field: field.name.value)
            }

            let renderedType = try swiftOutputType(
                from: fieldDefinition.type,
                selectionSet: field.selectionSet,
                nestedTypeName: swiftTypeName(responseName),
                fragments: fragments,
                fieldName: responseName
            )

            properties.append(
                PropertyDefinition(
                    jsonName: responseName,
                    swiftName: swiftName,
                    swiftType: renderedType.swiftType
                )
            )
            nestedStructs.append(contentsOf: renderedType.nestedStructs)
        }

        return StructDefinition(name: structName, properties: properties, nestedStructs: nestedStructs)
    }

    private func swiftOutputType(
        from graphQLType: Type,
        selectionSet: SelectionSet?,
        nestedTypeName: String,
        fragments: [String: FragmentDefinition],
        fieldName: String
    ) throws -> RenderedType {
        if let nonNullType = graphQLType as? NonNullType {
            return try swiftOutputTypeNonNull(
                from: nonNullType.type,
                selectionSet: selectionSet,
                nestedTypeName: nestedTypeName,
                fragments: fragments,
                fieldName: fieldName
            )
        }

        let nonNullRendered = try swiftOutputTypeNonNull(
            from: graphQLType,
            selectionSet: selectionSet,
            nestedTypeName: nestedTypeName,
            fragments: fragments,
            fieldName: fieldName
        )
        return RenderedType(
            swiftType: "\(nonNullRendered.swiftType)?",
            nestedStructs: nonNullRendered.nestedStructs
        )
    }

    private func swiftOutputTypeNonNull(
        from graphQLType: Type,
        selectionSet: SelectionSet?,
        nestedTypeName: String,
        fragments: [String: FragmentDefinition],
        fieldName: String
    ) throws -> RenderedType {
        if let listType = graphQLType as? ListType {
            let inner = try swiftOutputType(
                from: listType.type,
                selectionSet: selectionSet,
                nestedTypeName: nestedTypeName + "Item",
                fragments: fragments,
                fieldName: fieldName
            )
            return RenderedType(
                swiftType: "[\(inner.swiftType)]",
                nestedStructs: inner.nestedStructs
            )
        }

        guard let namedType = graphQLType as? NamedType else {
            throw GeneratorError.invalidArguments("Unsupported output GraphQL type")
        }

        let namedTypeName = namedType.name.value

        if schema.isComposite(typeName: namedTypeName) {
            guard let selectionSet else {
                throw GeneratorError.missingSelectionSet(field: fieldName, type: namedTypeName)
            }

            if let reusedTypeName = reusableOutputObjectTypeNameIfPossible(
                graphQLTypeName: namedTypeName,
                selectionSet: selectionSet,
                fragments: fragments
            ) {
                return RenderedType(swiftType: reusedTypeName, nestedStructs: [])
            }

            let childStructName = swiftTypeName(nestedTypeName)
            let childStruct = try renderSelectionSetStruct(
                structName: childStructName,
                parentTypeName: namedTypeName,
                selectionSet: selectionSet,
                fragments: fragments
            )
            return RenderedType(swiftType: childStructName, nestedStructs: [childStruct])
        }

        if schema.isEnum(typeName: namedTypeName) {
            return RenderedType(swiftType: outputEnumSwiftType(namedTypeName), nestedStructs: [])
        }

        return RenderedType(swiftType: scalarSwiftType(namedTypeName), nestedStructs: [])
    }

    private func swiftInputType(from graphQLType: Type) throws -> String {
        if let nonNullType = graphQLType as? NonNullType {
            return try swiftInputTypeNonNull(from: nonNullType.type)
        }

        let value = try swiftInputTypeNonNull(from: graphQLType)
        return "\(value)?"
    }

    private func swiftInputTypeNonNull(from graphQLType: Type) throws -> String {
        if let listType = graphQLType as? ListType {
            let inner = try swiftInputType(from: listType.type)
            return "[\(inner)]"
        }

        guard let namedType = graphQLType as? NamedType else {
            throw GeneratorError.invalidArguments("Unsupported input GraphQL type")
        }

        let name = namedType.name.value
        if schema.isEnum(typeName: name) {
            return inputEnumSwiftType(name)
        }
        if schema.isInputObject(typeName: name) {
            return "[String: Map]"
        }

        return scalarSwiftType(name)
    }

    private func expandSelections(
        selectionSet: SelectionSet,
        parentTypeName: String,
        fragments: [String: FragmentDefinition]
    ) -> [Field] {
        var output: [Field] = []

        for selection in selectionSet.selections {
            if let field = selection as? Field {
                output.append(field)
                continue
            }

            if let fragmentSpread = selection as? FragmentSpread {
                guard let fragment = fragments[fragmentSpread.name.value] else {
                    continue
                }
                if fragment.typeCondition.name.value != parentTypeName {
                    continue
                }
                output.append(
                    contentsOf: expandSelections(
                        selectionSet: fragment.selectionSet,
                        parentTypeName: parentTypeName,
                        fragments: fragments
                    )
                )
                continue
            }

            if let inlineFragment = selection as? InlineFragment {
                if let typeCondition = inlineFragment.typeCondition,
                   typeCondition.name.value != parentTypeName {
                    continue
                }

                output.append(
                    contentsOf: expandSelections(
                        selectionSet: inlineFragment.selectionSet,
                        parentTypeName: parentTypeName,
                        fragments: fragments
                    )
                )
            }
        }

        return output
    }

    private func reusableOutputObjectTypeNameIfPossible(
        graphQLTypeName: String,
        selectionSet: SelectionSet,
        fragments: [String: FragmentDefinition]
    ) -> String? {
        guard let reusableType = swikiReusableOutputObjectTypeMap[graphQLTypeName] else {
            return nil
        }

        guard !reusableType.requiredFields.isEmpty else {
            return reusableType.swiftType
        }

        let fields = expandSelections(
            selectionSet: selectionSet,
            parentTypeName: graphQLTypeName,
            fragments: fragments
        )

        let presentRequiredFields = Set(fields.compactMap { field -> String? in
            guard reusableType.requiredFields.contains(field.name.value) else {
                return nil
            }
            // Aliased fields decode under alias key, so they cannot satisfy model-required field names.
            guard field.alias == nil else {
                return nil
            }
            return field.name.value
        })

        guard presentRequiredFields == reusableType.requiredFields else {
            return nil
        }

        return reusableType.swiftType
    }
}

private func isNonNullType(_ type: Type) -> Bool {
    type is NonNullType
}

private func scalarSwiftType(_ graphQLTypeName: String) -> String {
    switch graphQLTypeName {
    case "Int", "PositiveInt":
        return "Int"
    case "Float":
        return "Double"
    case "Boolean":
        return "Bool"
    case "ISO8601Date", "ISO8601DateTime":
        return "Date"
    default:
        return "String"
    }
}

private func outputEnumSwiftType(_ graphQLTypeName: String) -> String {
    swikiOutputEnumTypeMap[graphQLTypeName] ?? "String"
}

private func inputEnumSwiftType(_ graphQLTypeName: String) -> String {
    swikiInputEnumTypeMap[graphQLTypeName] ?? "String"
}

private func renderStruct(_ structure: StructDefinition, indentLevel: Int) -> [String] {
    let indent = String(repeating: "    ", count: indentLevel)
    var lines: [String] = []

    lines.append("\(indent)public struct \(structure.name): Decodable, Sendable {")

    if structure.properties.isEmpty {
        lines.append("\(indent)    public init() {}")
    } else {
        for property in structure.properties {
            lines.append("\(indent)    public let \(property.swiftName): \(property.swiftType)")
        }
    }

    for nested in structure.nestedStructs {
        lines.append("")
        lines.append(contentsOf: renderStruct(nested, indentLevel: indentLevel + 1))
    }

    lines.append("\(indent)}")
    return lines
}

private func escapedSwiftIdentifier(_ raw: String) -> String {
    if swiftKeywords.contains(raw) {
        return "`\(raw)`"
    }
    return raw
}

private func swiftTypeName(_ raw: String) -> String {
    let separators = CharacterSet.alphanumerics.inverted
    let chunks = raw
        .components(separatedBy: separators)
        .filter { !$0.isEmpty }

    if chunks.isEmpty {
        return "Selection"
    }

    let joined = chunks
        .map { chunk in
            guard let first = chunk.first else { return chunk }
            return String(first).uppercased() + chunk.dropFirst()
        }
        .joined()

    guard let first = joined.first else {
        return "Selection"
    }

    if first.isNumber {
        return "_\(joined)"
    }

    return joined
}

private func swiftStringLiteral(_ value: String) -> String {
    let escaped = value
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "\"", with: "\\\"")
        .replacingOccurrences(of: "\n", with: "\\n")
        .replacingOccurrences(of: "\r", with: "")
    return "\"\(escaped)\""
}

private func swiftMultilineStringBodyLines(_ value: String, indent: String) -> [String] {
    let normalized = value
        .replacingOccurrences(of: "\r\n", with: "\n")
        .replacingOccurrences(of: "\r", with: "\n")

    return normalized
        .split(separator: "\n", omittingEmptySubsequences: false)
        .map { line in
            "\(indent)\(line)"
        }
}

private let swiftKeywords: Set<String> = [
    "associatedtype", "class", "deinit", "enum", "extension", "fileprivate", "func", "import",
    "init", "inout", "internal", "let", "open", "operator", "private", "protocol", "public",
    "rethrows", "static", "struct", "subscript", "typealias", "var", "break", "case", "continue",
    "default", "defer", "do", "else", "fallthrough", "for", "guard", "if", "in", "repeat",
    "return", "switch", "where", "while", "as", "false", "is", "nil", "self", "super", "throws",
    "throw", "true", "try", "_", "Type", "Protocol"
]

private func readOperationFiles(from directory: String) throws -> [OperationFile] {
    let manager = FileManager.default
    let rootURL = URL(fileURLWithPath: directory)

    guard let enumerator = manager.enumerator(
        at: rootURL,
        includingPropertiesForKeys: [.isRegularFileKey],
        options: [.skipsHiddenFiles]
    ) else {
        return []
    }

    var files: [OperationFile] = []

    for case let url as URL in enumerator {
        guard url.pathExtension == "graphql" || url.pathExtension == "gql" else {
            continue
        }

        let source = try String(contentsOf: url, encoding: .utf8)
        let document = try parse(source: source)
        files.append(
            OperationFile(
                path: url.path,
                document: document,
                source: source.trimmingCharacters(in: .whitespacesAndNewlines)
            )
        )
    }

    return files.sorted { $0.path < $1.path }
}

private func writeGeneratedFile(_ content: String, to outputPath: String) throws {
    let outputURL = URL(fileURLWithPath: outputPath)
    let outputDirectory = outputURL.deletingLastPathComponent()
    try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true)
    try content.write(to: outputURL, atomically: true, encoding: .utf8)
}

private func writeGeneratedOperations(
    _ operations: [RenderedOperation],
    to outputDirectoryPath: String
) throws {
    let fileManager = FileManager.default
    let outputDirectoryURL = URL(fileURLWithPath: outputDirectoryPath, isDirectory: true)
    try fileManager.createDirectory(at: outputDirectoryURL, withIntermediateDirectories: true)

    let existingFiles = try fileManager.contentsOfDirectory(
        at: outputDirectoryURL,
        includingPropertiesForKeys: nil,
        options: [.skipsHiddenFiles]
    )

    for fileURL in existingFiles {
        let name = fileURL.lastPathComponent
        if name.hasPrefix("SwikiGraphQLOperations+"), name.hasSuffix(".generated.swift") {
            try fileManager.removeItem(at: fileURL)
        }
    }

    var namespaceLines: [String] = []
    namespaceLines.append("// Generated by SwikiGraphQLOperationGenerator")
    namespaceLines.append("// DO NOT EDIT - regenerate from GraphQLOperations/*.graphql")
    namespaceLines.append("")
    namespaceLines.append("public enum SwikiGraphQLOperations {}")
    namespaceLines.append("")

    let namespacePath = outputDirectoryURL
        .appendingPathComponent("SwikiGraphQLOperations.generated.swift")
        .path
    try writeGeneratedFile(namespaceLines.joined(separator: "\n"), to: namespacePath)

    for operation in operations.sorted(by: { $0.typeName < $1.typeName }) {
        var operationLines: [String] = []
        operationLines.append("// Generated by SwikiGraphQLOperationGenerator")
        operationLines.append("// DO NOT EDIT - regenerate from GraphQLOperations/*.graphql")
        operationLines.append("")
        operationLines.append("import Foundation")
        operationLines.append("import GraphQL")
        operationLines.append("")
        operationLines.append("public extension SwikiGraphQLOperations {")
        operationLines.append(operation.body)
        operationLines.append("}")
        operationLines.append("")

        let operationPath = outputDirectoryURL
            .appendingPathComponent("SwikiGraphQLOperations+\(operation.typeName).generated.swift")
            .path
        try writeGeneratedFile(operationLines.joined(separator: "\n"), to: operationPath)
    }
}

@main
private struct SwikiGraphQLOperationGeneratorCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "swiki-graphql-operation-generator",
        abstract: "Generate typed GraphQL operation models for SwikiModels."
    )

    @Option(name: .long, help: "Path to schema.graphql")
    var schema: String

    @Option(name: .long, help: "Path to directory containing .graphql operations")
    var operations: String

    @Option(name: .long, help: "Path to output directory or output Swift file parent directory")
    var output: String

    mutating func run() throws {
        let schemaSource = try String(contentsOfFile: schema, encoding: .utf8)
        let schemaDocument = try GraphQL.parse(source: schemaSource)

        var schemaIndex = SchemaIndex()
        schemaIndex.absorb(document: schemaDocument)

        let operationFiles = try readOperationFiles(from: operations)

        let generator = Generator(schema: schemaIndex)
        let renderedOperations = try operationFiles.flatMap { operationFile in
            try generator.render(operationFile: operationFile)
        }

        let outputURL = URL(fileURLWithPath: output)
        let outputDirectory = if outputURL.pathExtension == "swift" {
            outputURL.deletingLastPathComponent().path
        } else {
            outputURL.path
        }

        try writeGeneratedOperations(renderedOperations, to: outputDirectory)
    }
}
