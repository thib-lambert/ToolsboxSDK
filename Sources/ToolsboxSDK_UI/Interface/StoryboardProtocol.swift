//
//  StoryboardProtocol.swift
//
//
//  Created by Thibaud Lambert on 20/04/2024.
//

import Foundation
import UIKit

public protocol StoryboardProtocol: AnyObject {
	
	/// The name of the storyboard containing the view controller.
	static var storyboardName: String { get }
	
	/// The identifier of the view controller in the storyboard.
	static var identifier: String { get }
}

public extension StoryboardProtocol {
	
	/// Instantiates and returns a view controller from the specified storyboard.
	///
	/// - Parameter infos: An optional closure that can be used to pass additional information to the instantiated view controller.
	/// - Returns: The instantiated view controller.
	///
	/// This function instantiates a view controller from the storyboard specified by `storyboardName` and `identifier`. It returns the instantiated view controller if successful. If instantiation fails, a fatalError is triggered.
	///
	/// Example usage:
	/// ```swift
	/// let viewController = MyViewController.fromStoryboard { vc in
	///     vc.configure(with: someData)
	/// }
	/// ```
	static func fromStoryboard(_ infos: ((Self) -> Void)? = nil) -> Self {
		guard let controller = UIStoryboard(name: Self.storyboardName, bundle: nil)
			.instantiateViewController(withIdentifier: Self.identifier) as? Self
		else {
			fatalError("Cannot instantiate view controller \(String(describing: Self.self)) with identifier \(Self.identifier) from storyboard \(Self.storyboardName)")
		}
		
		infos?(controller)
		
		return controller
	}
}
