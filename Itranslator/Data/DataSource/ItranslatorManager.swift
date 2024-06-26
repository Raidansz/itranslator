//
//  AzureManager.swift
//  Itranslator
//
//  Created by Raidan on 12/04/2024.
//

import Foundation

class ItranslatorManager: ItranslatorManagerProtocol {

    let apiKey = getAPIKey() ?? ""
    let endpoint = "https://api.cognitive.microsofttranslator.com"
    let location = "northeurope"

    func translate(text: String, from sourceLanguage: String, to targetLanguage: String, completion: @escaping (Result<String, Error>) -> Void) {
        var urlComponents = URLComponents(string: endpoint + "/translate")!
        urlComponents.queryItems = [
            URLQueryItem(name: "api-version", value: "3.0"),
            URLQueryItem(name: "from", value: sourceLanguage)
        ]
        urlComponents.queryItems?.append(URLQueryItem(name: "to", value: targetLanguage))

        guard let url = urlComponents.url else {
            completion(.failure(NSError(domain: "AzureManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.addValue(location, forHTTPHeaderField: "Ocp-Apim-Subscription-Region")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(UUID().uuidString, forHTTPHeaderField: "X-ClientTraceId")

        let body = ["Text": text]
        do {
            let requestBody = try JSONSerialization.data(withJSONObject: [body], options: [])
            request.httpBody = requestBody

        } catch {
            print(error)
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "AzureManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    completion(.success(jsonString))
                } else {
                    completion(.failure(NSError(domain: "AzureManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to decode response"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
   private static func getAPIKey() -> String? {
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            print("Plist file not found")
            return nil
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "APIKey") as? String else {
            print("API Key not found in plist")
            return nil
        }

        return value
    }
}
private struct ItranslatorManagerKey: InjectionKey {
    static var currentValue: ItranslatorManagerProtocol = ItranslatorManager()
}

extension InjectedValues {
    var itranslatorManager: ItranslatorManagerProtocol {
        get { Self[ItranslatorManagerKey.self]}
        set { Self[ItranslatorManagerKey.self] = newValue }
}
}
