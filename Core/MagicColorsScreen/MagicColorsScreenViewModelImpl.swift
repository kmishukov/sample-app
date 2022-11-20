//
//  MagicColorsScreenViewModelImpl.swift
//  Core
//
//  Created by Author on 19.10.22.
//

import Combine

public class MagicColorsScreenViewModelImpl {
    public init() { }

    private let modeSubject = ValueSubject<MagicColorsMode>(.base)
    private var previousMode: MagicColorsMode = .base
    private var challengeSubscription: Cancellable?
}

extension MagicColorsScreenViewModelImpl: MagicColorsScreenViewModel {
    public var mode: ValuePublisher<MagicColorsMode> {
        modeSubject.eraseToAnyPublisher()
    }

    public func onTutorialTapped() {
        if case .tutorial = modeSubject.value {
            modeSubject.value = previousMode
        } else {
            previousMode = modeSubject.value
            modeSubject.value = .tutorial(message: "Tutorial mode!")
        }
    }

    public func onResetBGColorTapped() {
        if case .tutorial = modeSubject.value {
            modeSubject.value = .tutorial(message: "Will change colors back")
        } else {
            modeSubject.value = .base
        }
    }

    public func onChangeBGColorTapped() {
        if case .tutorial = modeSubject.value {
            modeSubject.value = .tutorial(message: "Will change background color to self color")
        } else {
            modeSubject.value = .color
        }
    }

    public func onChallengeTapped() {
        modeSubject.value = .challenge

        challengeSubscription = nil

        let challengePublisher = PassthroughSubject<Void, Never>()
        challengeSubscription = challengePublisher.delay(for: 0.1, scheduler: RunLoop.main)
            .first()
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.modeSubject.value = .base
            })
        challengePublisher.send(Void())
    }
}
