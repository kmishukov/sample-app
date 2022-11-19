//
//  GoodByeViewModel.swift
//  Core
//
//  Created by Oleg Pustoshkin on 19.11.2022.
//

import Foundation

public enum GoodByeViewScreenState {
    case initial
    case goodBye
    case seeYou
    case leaveInEnglish
    case somewhereHere

}

public protocol GoodByeScreenViewModel {
    var state: ValuePublisher<GoodByeViewScreenState> { get }

    func onGoodByeTapped()
    func onSeeYouTapped()
    func onHideApp()
    func onTabChanged()
    func onModuleActivated()
    func onModuleDeactivated()
}
