//
//  MagicColorsScreenViewModel.swift
//  Core
//
//  Created by Author on 19.10.22.
//

public enum MagicColorsMode: Equatable {
    case base
    case color
    case tutorial(message: String)
}

public protocol MagicColorsScreenViewModel {
    var mode: ValuePublisher<MagicColorsMode> { get }

    func onTutorialTapped()
    func onResetBGColorTapped()
    func onChangeBGColorTapped()
}
