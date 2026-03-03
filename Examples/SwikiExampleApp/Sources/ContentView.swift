import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ExampleAppViewModel

    var body: some View {
        Form {
            credentialsSection
            actionsSection
            resultsSection
            logsSection
        }
        .navigationTitle("Swiki Example")
        .alert("Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { shouldShow in
                if !shouldShow {
                    viewModel.errorMessage = nil
                }
            }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "Unknown error")
        }
    }

    private var credentialsSection: some View {
        Section("OAuth Credentials") {
            TextField("Client ID", text: $viewModel.clientID)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            SecureField("Client Secret", text: $viewModel.clientSecret)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            TextField("Redirect URI", text: $viewModel.redirectURI)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            TextField("User-Agent", text: $viewModel.userAgent)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)

            Button("Recreate Swiki Client") {
                viewModel.recreateClient()
            }
        }
    }

    private var actionsSection: some View {
        Section("Actions") {
            Button("OAuth Login (ASWebAuthenticationSession)") {
                Task { await viewModel.loginWithOAuth() }
            }
            .disabled(!viewModel.canStartOAuth || viewModel.isLoading)

            Button("Load v1/users/whoami") {
                Task { await viewModel.loadWhoami() }
            }
            .disabled(!viewModel.isClientReady || viewModel.isLoading)

            HStack {
                TextField("Anime search", text: $viewModel.animeSearch)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                Stepper(value: $viewModel.animeLimit, in: 1...20) {
                    Text("limit: \(viewModel.animeLimit)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .fixedSize()
            }

            Button("Search v1/animes") {
                Task { await viewModel.searchAnimes() }
            }
            .disabled(!viewModel.isClientReady || viewModel.isLoading)

            Button("Run GraphQL DefaultUserRatesOperation") {
                Task { await viewModel.loadGraphQLUserRates() }
            }
            .disabled(!viewModel.isClientReady || viewModel.isLoading)

            if viewModel.isLoading {
                ProgressView()
            }
        }
    }

    private var resultsSection: some View {
        Section("Results") {
            LabeledContent("Access Token", value: viewModel.accessTokenPreview)
            LabeledContent("Whoami", value: viewModel.whoamiName ?? "Not loaded")

            VStack(alignment: .leading, spacing: 8) {
                Text("Anime Search")
                    .font(.headline)
                if viewModel.animeNames.isEmpty {
                    Text("No results")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.animeNames, id: \.self) { name in
                        Text(name)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("GraphQL Animes IDs")
                    .font(.headline)
                if viewModel.graphQLAnimesIDs.isEmpty {
                    Text("No results")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.graphQLAnimesIDs, id: \.self) { identifier in
                        Text(identifier)
                    }
                }
            }
        }
    }

    private var logsSection: some View {
        Section("Logs") {
            if viewModel.logs.isEmpty {
                Text("No logs yet")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(Array(viewModel.logs.enumerated()), id: \.offset) { _, line in
                    Text(line)
                        .font(.caption)
                        .textSelection(.enabled)
                }
            }
        }
    }
}
