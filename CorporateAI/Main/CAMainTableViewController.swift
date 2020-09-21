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

final class CAMainTableViewController: UIViewController, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!

    lazy var viewModel: CAMainViewModel = {
        return CAMainViewModel()
    }()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindTableView()
        viewModel.requestMain()
    }

    private func bindTableView() {
        viewModel.data
            .bind(to: tableView.rx.items) { tableView, row, element -> UITableViewCell in
                guard let type = TableRow(rawValue: row) else { return UITableViewCell() }
                switch type {
                case .head:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CAMainHeadTableViewCell.identifier) as? CAMainHeadTableViewCell else { return UITableViewCell() }
                    cell.didTouchInstruction = { [weak self] in
                        // 웹뷰 띄우기
                    }
                    return cell
                case .nation:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CAMainNationTableViewCell.identifier) as? CAMainNationTableViewCell else { return UITableViewCell() }
                    if let model = self.viewModel.mainModel {
                        cell.viewModel = model
                    }
                    return cell
                case .location:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: CAMainRankingTableViewCell.identifier) as? CAMainRankingTableViewCell else { return UITableViewCell() }
                    return cell
                }
        }
        .disposed(by: disposeBag)
    }

//    private func initViewModel() {
//        viewModel.didSuccessGetMainData = {
//            self.tableView.reloadData()
//        }
//
//        viewModel.requestMain()
//    }
}
