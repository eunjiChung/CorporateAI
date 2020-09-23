//
//  CAMainNationTableViewCell.swift
//  CorporateAI
//
//  Created by chungeunji on 2020/08/22.
//  Copyright © 2020 chungeunji. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Charts

final class CAMainNationTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var chartView: BarChartView!

    @IBOutlet weak var increaseLabel: UILabel!
    @IBOutlet weak var totalCount: UILabel!

    // MARK: - Properties
    static let identifier = "CAMainNationTableViewCell"

    var model: CAMainModel! {
        didSet {
            total.onNext(model.defCnt)
            increase.onNext(Int(model.incDec)!)
            chartModel.onNext(model.nations)
        }
    }

    var total = PublishSubject<Int>()
    var increase = PublishSubject<Int>()
    var chartModel = PublishSubject<CAAbroadModel>()

    var xString = [String]()

    var disposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initView()
        bindViewModel()
    }
    
    private func initView() {
        views.forEach({ $0.layer.cornerRadius = 5 })
    }

    private func bindViewModel() {
        increase
            .map { "+\($0)" }
            .asObservable()
            .bind(to: increaseLabel.rx.text)
            .disposed(by: disposeBag)

        total.map { "\($0)" }
            .asObservable()
            .bind(to: totalCount.rx.text)
            .disposed(by: disposeBag)

        chartModel.map { model -> [BarChartDataEntry] in
            var chartEntry = [BarChartDataEntry]()
            for (index, nation) in model.nationList.enumerated() {
                chartEntry.append(BarChartDataEntry(x: Double(index), yValues: [Double(nation.localOccCnt), Double(nation.overFlowCnt)], data: nil))
                self.xString.append(nation.createDt)
            }
            return chartEntry
        }
        .map {
            let bar = BarChartDataSet(entries: $0)
            bar.colors = [#colorLiteral(red: 0.4549019608, green: 0.7529411765, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.1098039216, green: 0.4941176471, blue: 0.8392156863, alpha: 1)]
            bar.stackLabels = ["국내발생", "해외유입"]
            let data = BarChartData()
            data.addDataSet(bar)
            return data
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
        .subscribe(onNext: { data in
            self.setValue(data)
        })
            .disposed(by: disposeBag)

        hideGrids()
    }

    private func setValue(_ data: BarChartData) {
        self.chartView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: {(index, _) in
            return self.xString[Int(index)]
        })
        self.chartView.xAxis.setLabelCount(self.xString.count, force: true)
        self.chartView.data = data
    }

    private func hideGrids() {
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.leftAxis.gridColor = .clear
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Action
    @IBAction func didSelectType(_ sender: Any) {
        
    }
}
