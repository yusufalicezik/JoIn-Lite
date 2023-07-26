//
//  ImageUploader.swift
//  JoIn-Lite
//
//  Created by Yusuf Ali Cezik on 26.07.2023.
//

import SwiftUI

public protocol ImageUploaderInterface {
    func uploadImage(baseUrl: String, _ paramName: String, fileName: String, image: UIImage, urlPath: String, completion: (() -> Void)?)
}

public struct ImageUploader: ImageUploaderInterface {
    public static let shared = ImageUploader()
    
    public func uploadImage(baseUrl: String, _ paramName: String, fileName: String, image: UIImage, urlPath: String, completion: (() -> Void)?) {
        guard let url = URL(string: baseUrl+urlPath) else { return }
        let boundary = UUID().uuidString
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        guard let token = KeychainService.shared.get(key: "UserAuthToken") else { return }
        print(token)
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        
        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
//                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                if let json = jsonData as? [String: Any] {
//                    print(json)
                    completion?()
//                }
            } else {
                print(error)
            }
        }).resume()
    }
}
