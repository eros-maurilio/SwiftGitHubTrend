import Foundation

final class DataLoader {
    private var sharedSession: URLSession { URLSession.shared }
    
    func request<T: Decodable>(_ endPoint: EndPoint, completion: @escaping (Result<[T], NSError>) -> Void) {
        guard let url = endPoint.url else {
            return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Invalid URL"])))
        }
        
        let task = sharedSession.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": error.localizedDescription])))
                return
            }
            
            guard let data = data else {
                return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Can't get data"])))
            }
            
            guard let parsedData = try? JSONDecoder().decode([T].self, from: data) else {
                return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "Cant't parse JSON"])))
            }
            
            completion(.success(parsedData))
        }
        task.resume()
    }
}
