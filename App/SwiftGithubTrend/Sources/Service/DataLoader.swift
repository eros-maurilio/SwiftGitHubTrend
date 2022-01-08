import Foundation

final class DataLoader {
    
    var isLoading = false
    
    // MARK: - Private atribute
    
    private var sharedSession: URLSession { URLSession.shared }
    
    // MARK: - API Resquest Method
    
    func request<T: Decodable>(_ endPoint: EndPoint, completion: @escaping (Result<T, NSError>) -> Void) {
        
        isLoading = true
        
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
            
            do {
                let parsedData = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(parsedData))
                
                self.isLoading = false
                
                return
                
            } catch {
                return completion(.failure(NSError(domain: "", code: 000, userInfo: ["Message": "There's no information avaliable or could not be found"])))
            }
        }
        task.resume()
    }
}
