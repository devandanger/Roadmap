//
//  FeatureVoter.swift
//  Roadmap
//
//  Created by James Sherlock on 23/02/2023.
//

import Foundation

public protocol FeatureVoter {
    func fetch() async -> Int
    func vote() async -> Int?
}
