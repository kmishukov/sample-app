//
//  AdsScreenViewModelImpl.swift
//  Core
//
//  Created by Oleg Pustoshkin on 20.11.2022.
//

import Foundation
import Combine

public class AdsScreenViewModelImpl {
    public init(
        rewardCompletion: @escaping (() -> Void),
        closeCompletion: @escaping (() -> Void)
    ) {
        self.rewardCompletion = rewardCompletion
        self.closeCompletion = closeCompletion
    }

    //private let adsShowPublisher = PassthroughSubject<Void, Never>()
    private var adsShowSubscription: Cancellable?
    private let rewardCompletion: (() -> Void)
    private let closeCompletion: (() -> Void)
    private let stateSubject = ValueSubject<AdsScreenState>(.rewardShowingProposal)
}

extension AdsScreenViewModelImpl: AdsScreenViewModel {
    public var state: ValuePublisher<AdsScreenState> {
        stateSubject.eraseToAnyPublisher()
    }
    
    public func onCloseTapped() {
        adsShowSubscription = nil
        closeCompletion()
    }
    
    public func onGetRewardTapped() {
        stateSubject.value = .showAds
        
        let adsShowPublisher = PassthroughSubject<Void, Never>()
        adsShowSubscription = adsShowPublisher.delay(for: 8, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.activateReward()
            })
        adsShowPublisher.send(Void())
    }
    
    public func activateReward() {
        rewardCompletion()
        closeCompletion()
    }
}
