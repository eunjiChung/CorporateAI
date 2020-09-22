//
//  CAMainTableViewController.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/08/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CAMainTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let viewModel = CAMainViewModel()
    var disposeBag = DisposeBag()
    var didTouchWebView: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        bindTableView()
    }

    private func bindTableView() {
        viewModel.mainModel
            .bind(to: tableView.rx.items) { tableView, row, element -> UITableViewCell in
                switch element.type {
                case .head:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CAMainHeadTableViewCell.identifier) as? CAMainHeadTableViewCell else { return UITableViewCell() }
                    cell.didTouchInstruction = { [weak self] in
                        self?.didTouchWebView?()
                    }
                    return cell
                case .nation:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CAMainNationTableViewCell.identifier) as? CAMainNationTableViewCell else { return UITableViewCell() }
                    if let model = element.model as? CAMainModel {
                        cell.model = model
                    }
                    return cell
                case .rank:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CAMainRankingTableViewCell.identifier) as? CAMainRankingTableViewCell else { return UITableViewCell() }
                    if let rankModel = element.model as? [CALocalModel] {
                        cell.viewModel.rankModel = rankModel
                    }
                    return cell
                }
        }
        .disposed(by: disposeBag)
    }
}
