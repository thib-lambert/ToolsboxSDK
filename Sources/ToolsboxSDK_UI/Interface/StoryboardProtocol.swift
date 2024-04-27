//
//  StoryboardProtocol.swift
//
//
//  Created by Thibaud Lambert on 20/04/2024.
//

import Foundation
import UIKit

public protocol StoryboardProtocol: AnyObject {
	
	static var storyboardName: String { get }
	static var identifier: String { get }
}

public extension StoryboardProtocol {
	
	static func fromStoryboard(_ infos: ((Self) -> Void)? = nil) -> Self {
		guard let controller = UIStoryboard(name: Self.storyboardName, bundle: nil)
			.instantiateViewController(withIdentifier: Self.identifier) as? Self
		else {
			fatalError("Cannot instantiate view controller \(String(describing: Self.self)) with indentifier \(Self.identifier) from storyboard \(Self.storyboardName)")
		}
		
		infos?(controller)
		return controller
	}
}
