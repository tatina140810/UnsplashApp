import Foundation
import UIKit
import SDWebImage

class NetworkServiceMain {
    
    func request(completion: @escaping (Data?, Error?) -> Void)  {
        let parameters = self.prepareParametrs()
        guard let url = self.url(params: parameters) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = createDataTask(from: request, completion: completion)
        print("Ссылка \(request)")
        task.resume()
    }
    
    private func prepareParametrs() -> [String: String] {
        var parameters = [String: String]()
        parameters["count"] = String(20)
        parameters["client_id"] = String("GUTEvKoHCAVO8H1I1Wao3Y92EH2gant6fxx19O-lulQ")
        return parameters
    }
    
    private func url(params: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos/random"
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value)}
        return components.url
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data? , Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}

