//
//  CAChatMainViewController.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/20.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct CAChatVoicViewInfo {

    static let beforeInput = #colorLiteral(red: 0.2401806712, green: 0.6746707559, blue: 0.9541376233, alpha: 1)
    static let whileInput = #colorLiteral(red: 0.09411764706, green: 0.3921568627, blue: 0.6705882353, alpha: 1)
}

final class CAChatVoiceViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var titleDescLabel: UILabel!
    @IBOutlet weak var subDescLabel: UILabel!

    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var micSurroundView: UIView!
    @IBOutlet weak var searchLabel: UILabel!

    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    let viewModel = CAChatVoiceViewModel()
    var disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        bind()
    }

    private func initView() {
        micButton.layer.cornerRadius = micButton.bounds.width/2
        micSurroundView.layer.cornerRadius = micSurroundView.bounds.width/2
        micSurroundView.layer.borderColor = CAChatVoicViewInfo.beforeInput.cgColor
        micSurroundView.layer.borderWidth = 4
    }

    private func bind() {

        viewModel.isVoiceOn
            .subscribe(onNext: { isOn in
                self.setBackgroundView(isOn: true)
            })
            .disposed(by: disposeBag)

        viewModel.firstDesc
            .observeOn(MainScheduler.instance)
            .bind(to: titleDescLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.secondDesc
            .observeOn(MainScheduler.instance)
            .bind(to: subDescLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.searchDesc
            .observeOn(MainScheduler.instance)
            .bind(to: searchLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func setBackgroundView(isOn: Bool) {
        backgroundView.backgroundColor = .white

        guard isOn else { return }
        let layer0 = CAGradientLayer()
        layer0.colors = [
            UIColor(red: 0.945, green: 0.953, blue: 0.961, alpha: 1).cgColor,
            UIColor(red: 0.973, green: 0.976, blue: 0.98, alpha: 0).cgColor
        ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 0.22, c: -0.22, d: 0, tx: 0.61, ty: 0))
        layer0.frame = backgroundView.frame
        backgroundView.layer.addSublayer(layer0)
    }

    // MARK: - IBAction
    @IBAction func didTouchType(_ sender: Any) {
    }

    @IBAction func didTouchClose(_ sender: Any) {
    }
}

extension CAChatVoiceViewController {

    enum SegueIdentifier: String {
        case showResult
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let id = SegueIdentifier(rawValue: identifier) else { return }

        switch id {
        case .showResult:
            print("show result view")
        }
    }
}
