//
//  AdsScreenViewModel.swift
//  Core
//
//  Created by Author on 19.10.22.
//

public enum AdsScreenState {
    case initState
    case showAds
    case showReward
}

public protocol AdsScreenViewModel {
    var state: ValuePublisher<AdsScreenState> { get }

    func onCloseTapped()
    func onGetRewardTapped()
    func onModuleActivated()
}
