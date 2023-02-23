//
//  RoadmapFeatureViewModel.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation
import SwiftUI

final class RoadmapFeatureViewModel: ObservableObject {
    let feature: RoadmapFeature
    let configuration: RoadmapConfiguration
    let featureVoter: FeatureVoter

    @Published var voteCount = 0

    init(feature: RoadmapFeature, configuration: RoadmapConfiguration) {
        self.feature = feature
        self.configuration = configuration
        self.featureVoter = FeatureVoterCountAPI(feature: feature, namespace: configuration.namespace)
    }
    
    @MainActor
    func getCurrentVotes() async {
        voteCount = await featureVoter.fetch()
    }

    @MainActor
    func vote() async {
        guard !feature.hasVoted else {
            print("already voted for this, can't vote again")
            return
        }
        
        let newCount = await featureVoter.vote()
        voteCount = newCount ?? (voteCount + 1)
    }
}
