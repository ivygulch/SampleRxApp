//
//  HomeViewController.swift
//  SampleRxApp
//
//  Created by Douglas Sjoquist on 3/11/20.
//  Copyright © 2020 Ivy Gulch. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    class func load(withViewModel viewModel: HomeViewModelType, viewActions: HomeViewActionsType) -> HomeViewController {
        let result = loadFromStoryboard()
        result.viewModel = viewModel
        result.viewActions = viewActions
        return result
    }

    var viewModel: HomeViewModelType? {
        didSet {
            bindViewModel()
        }
    }
    var viewActions: HomeViewActionsType?

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    private func bindViewModel() {
        guard isViewLoaded, let viewModel = viewModel else { return }

        viewModelDisposeBag = DisposeBag()
        viewModel.viewState.asObservable().subscribe(onNext: { [weak self] _ in
            self?.resetForms()
        }).disposed(by: viewModelDisposeBag)
        viewModel.viewState.map { $0 != .showSignInForm }.drive(signInFormView.rx.isHidden).disposed(by: viewModelDisposeBag)

        viewModel.signInErrorMessage.map { $0 == nil }.drive(signInErrorMessageLabel.rx.isHidden).disposed(by: viewModelDisposeBag)
        viewModel.signInErrorMessage.drive(signInErrorMessageLabel.rx.text).disposed(by: viewModelDisposeBag)

        Observable.combineLatest(
            usernameTextField.rx.text.startWith(nil),
            passwordTextField.rx.text.startWith(nil)) { username,password -> Bool in
                return username.isNotNilOrEmpty && password.isNotNilOrEmpty
        }
        .bind(to: signInButton.rx.isEnabled)
        .disposed(by: viewModelDisposeBag)

        viewModel.viewState.map { $0 != .showUserForm }.drive(userFormView.rx.isHidden).disposed(by: viewModelDisposeBag)
        viewModel.username.drive(usernameLabel.rx.text).disposed(by: viewModelDisposeBag)
        viewModel.displayName.drive(displayNameLabel.rx.text).disposed(by: viewModelDisposeBag)
    }

    private func resetForms() {
        usernameTextField.text = nil
        passwordTextField.text = nil
    }

    // MARK: - private vars

    private var viewModelDisposeBag = DisposeBag()

    // MARK: - IBActions

    @IBAction private func signInButtonAction(_ sender: UIButton) {
        viewActions?.signIn(username: usernameTextField.text, password: passwordTextField.text)
    }

    @IBAction private func signOutButtonAction(_ sender: UIButton) {
        viewActions?.signOut()
    }

    // MARK: - IBOutlets

    @IBOutlet private var userFormView: UIView!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var displayNameLabel: UILabel!
    @IBOutlet private var signOutButton: UIButton!

    @IBOutlet private var signInFormView: UIView!
    @IBOutlet private var signInErrorMessageLabel: UILabel!
    @IBOutlet private var usernameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var signInButton: UIButton!
}
