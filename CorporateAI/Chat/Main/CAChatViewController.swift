//
//  CAChatViewController.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/09/21.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CAChatViewController: UIViewController {

    // MARK: - Properties
    let viewModel = CAChatViewModel()
    var disposeBag = DisposeBag()

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var voiceMessageButton: UIButton!

    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        bind()
    }

    // MARK: - Private Methods
    private func initView() {
        voiceMessageButton.layer.cornerRadius = voiceMessageButton.bounds.width / 2
        performSegue(withIdentifier: "showVoice", sender: nil)
    }

    private func bind() {
        viewModel.chatObservable
            .bind(to: tableView.rx.items) { _,_,_ in
                return UITableViewCell()
        }
        .disposed(by: disposeBag)
    }

    // MARK: - IBActions
    @IBAction func startVoidMessage(_ sender: Any) {
    }

    @IBAction func showKeyboard(_ sender: Any) {
    }

    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
