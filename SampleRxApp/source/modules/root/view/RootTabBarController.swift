//
//  RootTabBarController.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RootTabBarController: UITabBarController {

    class func load(withViewModel viewModel: RootTabBarViewModelType) -> RootTabBarController {
        let result = RootTabBarController()
        result.viewModel = viewModel
        return result
    }

    var viewModel: RootTabBarViewModelType? {
        didSet {
            bindViewModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    private func bindViewModel() {
        guard isViewLoaded, let viewModel = viewModel else { return }

        viewModelDisposeBag = DisposeBag()
        viewModel.viewControllers.asObservable().subscribe(onNext: { [weak self] viewControllers in
            self?.setViewControllers(viewControllers, animated: true)
        }).disposed(by: viewModelDisposeBag)
    }

    // MARK: - private vars

    private var viewModelDisposeBag = DisposeBag()

}
