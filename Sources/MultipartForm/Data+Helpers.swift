import Foundation


extension Data {
	mutating func append(_ string: String) {
		append(string.data(using: .utf8, allowLossyConversion: true)!)
	}
}
