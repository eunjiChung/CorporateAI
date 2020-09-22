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
    var chartModel = PublishSubject<CANationsModel>()

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

        chartModel.map { model in
            model.nationList.map({ BarChartDataEntry(x: Double($0.createDt)!, yValues: [100, 200], data: nil) })
        }
        .map {
            let bar = BarChartDataSet(entries: $0)
            bar.colors = [#colorLiteral(red: 0.4549019608, green: 0.7529411765, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.1098039216, green: 0.4941176471, blue: 0.8392156863, alpha: 1)]
            bar.stackLabels = ["111", "222"]
            let data = BarChartData()
            data.addDataSet(bar)
            return data
        }
        .asObservable()
        .subscribe(onNext: {
            self.chartView.data = $0
        })
            .disposed(by: disposeBag)
    }

    private func setChartModel() {
        var chartEntry = [BarChartDataEntry]()
        var numbers = 0...12

        for i in numbers {
            let value = BarChartDataEntry(x: Double(i), yValues: [2.0, 4.0], data: "groupChart")
            chartEntry.append(value)
        }

        let bar1 = BarChartDataSet(entries: chartEntry, label: "Number")
        bar1.colors = [#colorLiteral(red: 0.4549019608, green: 0.7529411765, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.1098039216, green: 0.4941176471, blue: 0.8392156863, alpha: 1)]
        bar1.stackLabels = ["111", "222"]

        let data = BarChartData()
        data.addDataSet(bar1)

        chartView.data = data
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
