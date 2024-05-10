//
//  RequestAuthRefreshableProtocol.swift
//
//
//  Created by Thibaud Lambert on 15/04/2024.
//

import Foundation

/// Protocol defining the authentication refresh behavior for a request.
public protocol RequestAuthRefreshableProtocol: RequestAuthProtocol {
	
	/// Refreshes the authentication details based on the provided request.
	///
	/// - Parameter request: The URLRequest that triggered the authentication refresh.
	/// - Throws: An error if the authentication refresh fails.
	///
	/// This method asynchronously refreshes the authentication details based on the provided URLRequest. Implementations should perform the necessary actions to refresh the authentication, such as obtaining new tokens, and update the headers, body parameters, or other authentication properties accordingly. If the authentication refresh fails, an error should be thrown.
	///
	/// Example usage:
	/// ```swift
	/// do {
	///     try await auth.refresh(from: request)
	///     // Authentication refreshed successfully
	/// } catch {
	///     // Handle authentication refresh error
	/// }
	/// ```
	func refresh(from request: URLRequest) async throws
}
