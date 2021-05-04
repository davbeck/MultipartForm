import Foundation

public struct MultipartForm: Hashable, Equatable {
    public struct Part: Hashable, Equatable {
        public var name: String
        public var data: Data
        public var filename: String?
        public var contentType: String?
        
        public var value: String? {
            get {
                return String(bytes: self.data, encoding: .utf8)
            }
            set {
                guard let value = newValue else {
                    self.data = Data()
                    return
                }
                
                self.data = value.data(using: .utf8, allowLossyConversion: true)!
            }
        }
        
        public init(name: String, data: Data, filename: String? = nil, contentType: String? = nil) {
            self.name = name
            self.data = data
            self.filename = filename
            self.contentType = contentType
        }
        
        public init(name: String, value: String) {
            let data = value.data(using: .utf8, allowLossyConversion: true)!
            self.init(name: name, data: data, filename: nil, contentType: nil)
        }
    }
    
    public var boundary: String
    public var parts: [Part]
    
    public var contentType: String {
        return "multipart/form-data; boundary=\(self.boundary)"
    }
    
    public var bodyData: Data {
        var body = Data()
        for part in self.parts {
            body.append("--\(self.boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(part.name)\"")
            if let filename = part.filename?.replacingOccurrences(of: "\"", with: "_") {
                body.append("; filename=\"\(filename)\"")
            }
            body.append("\r\n")
            if let contentType = part.contentType {
                body.append("Content-Type: \(contentType)\r\n")
            }
            body.append("\r\n")
            body.append(part.data)
            body.append("\r\n")
        }
        body.append("--\(self.boundary)--\r\n")
        
        return body
    }
    
    public init(parts: [Part] = [], boundary: String = UUID().uuidString) {
        self.parts = parts
        self.boundary = boundary
    }
    
    public subscript(name: String) -> Part? {
        get {
            return self.parts.first(where: { $0.name == name })
        }
        set {
            precondition(newValue == nil || newValue?.name == name)
            
            var parts = self.parts
            parts = parts.filter { $0.name != name }
            if let newValue = newValue {
                parts.append(newValue)
            }
            self.parts = parts
        }
    }
}
