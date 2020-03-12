//
//  SettingsViewController.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {

    class func load(withViewModel viewModel: SettingsViewModelType, viewActions: SettingsViewActionsType) -> SettingsViewController {
        let result = loadFromStoryboard()
        result.viewModel = viewModel
        result.viewActions = viewActions
        return result
    }

    var viewModel: SettingsViewModelType? {
        didSet {
            bindViewModel()
        }
    }
    var viewActions: SettingsViewActionsType?

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    private func bindViewModel() {
        guard isViewLoaded, let viewModel = viewModel else { return }

        viewModelDisposeBag = DisposeBag()
    }

    // MARK: - private vars

    private var viewModelDisposeBag = DisposeBag()

    // MARK: - IBActions

    // MARK: - IBOutlets

}
