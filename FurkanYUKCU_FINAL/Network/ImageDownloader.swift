import Foundation

enum ImageDownloaderError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

class ImageDownloader {
    
    static var shared = ImageDownloader()
    
    private var images = NSCache<NSString, NSData>()
    
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> Void) {
        if let imageData = images.object(forKey: imageURL.absoluteString as NSString) {
            completion(imageData as Data, nil)
            return
        }
        
        let task = session.downloadTask(with: imageURL) { localUrl, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, ImageDownloaderError.badResponse(response))
                return
            }
            
            guard let localUrl = localUrl else {
                completion(nil, ImageDownloaderError.badLocalUrl)
                return
            }
            
            do {
                let data = try Data(contentsOf: localUrl)
                self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    func image(music: MusicData, imageURL: URL, completion: @escaping (Data?, Error?) -> Void) {
        download(imageURL: imageURL, completion: completion)
    }

}
