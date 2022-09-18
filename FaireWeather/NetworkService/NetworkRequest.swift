import Foundation

protocol NetworkRequest {
    var baseStringUrl: String { get }
    var path: String { get }
}
