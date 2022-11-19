//
//  GoodByeViewModelImpl.swift
//  Core
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Foundation
import Combine

public class GoodByeViewModelImpl {
    public init(appCoordinator: AppCoordination, notificationAppHideService: NotificationAppHideServiceProtocol) {
        self.appCoordinator = appCoordinator
        self.notificationAppHideService = notificationAppHideService
    }

    private let notificationAppHideService: NotificationAppHideServiceProtocol
    private let appCoordinator: AppCoordination
    private let stateSubject = ValueSubject<GoodByeViewScreenState>(.initial)
    private var hideAppSubscription: Cancellable?
}

extension GoodByeViewModelImpl: GoodByeScreenViewModel {
    public var state: ValuePublisher<GoodByeViewScreenState> {
        stateSubject.eraseToAnyPublisher()
    }

    public func onGoodByeTapped() {
        appCoordinator.switchToSoundScreen()
        stateSubject.value = .goodBye
    }

    public func onSeeYouTapped() {
        appCoordinator.switchToSoundScreen()
        stateSubject.value = .seeYou
    }

    public func onHideApp() {
        stateSubject.value = .somewhereHere
    }

    public func onTabChanged() {
        stateSubject.value = .leaveInEnglish
    }

    public func onModuleActivated() {
        self.hideAppSubscription = notificationAppHideService.subscribe().sink { [weak self] _ in
            guard let self = self else { return }
            self.onHideApp()
        }
    }

    public func onModuleDeactivated() {
        self.hideAppSubscription = nil
    }
}
