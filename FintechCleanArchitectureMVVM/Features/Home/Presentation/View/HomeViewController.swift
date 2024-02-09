//
//  HomeViewController.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import UIKit
import DGCharts
import Combine

class HomeViewController: UIViewController {
    enum HomeChart: Int {
        case donutSpending = 1
        case lineProgress = 2
    }
    private var viewModel: HomeViewModel
    private var bindings = Set<AnyCancellable>()

    @IBOutlet weak var donutChartView: PieChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDonutChart()
        setupLineChart()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchChartData()
    }
    
    private func setupUI() {
        title = "BIJI"
    }
    
    private func setupBindings() {
        viewModel.$spendingChartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.setDonutChartView(data: data)
            }
            .store(in: &bindings)
        
        viewModel.$progressChartData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.setLineChartView(progressChartData: data)
            }
            .store(in: &bindings)
    }
}

// MARK: Donut Chart functions
extension HomeViewController: ChartViewDelegate {
    func setupDonutChart() {
        donutChartView.tag = HomeChart.donutSpending.rawValue
        donutChartView.usePercentValuesEnabled = true
        donutChartView.drawSlicesUnderHoleEnabled = false
        donutChartView.holeRadiusPercent = 0.4
        donutChartView.transparentCircleRadiusPercent = 0.61
        donutChartView.chartDescription.enabled = false
        donutChartView.drawHoleEnabled = true
        donutChartView.rotationAngle = 0
        donutChartView.rotationEnabled = true
        donutChartView.highlightPerTapEnabled = true
        
        let l = donutChartView.legend
        l.drawInside = false
        l.horizontalAlignment = .center
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        l.textColor = .black
        l.font = .systemFont(ofSize: 15, weight: .medium)
        
        donutChartView.delegate = self
        
        // entry label styling
        donutChartView.entryLabelColor = .black
        donutChartView.entryLabelFont = .systemFont(ofSize: 15, weight: .medium)
        
        donutChartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    
    func setDonutChartView(data: SpendingChartData?) {
        guard let spendingChartData = data else {
            return
        }
        let entries = spendingChartData.data.map { (item) -> PieChartDataEntry in
            return PieChartDataEntry(value: Double(item.percentage),
                                     label: item.label,
                                     icon: nil)
        }

        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 2

        set.colors = ChartColorTemplates.vordiplom()
            + ChartColorTemplates.joyful()
            + ChartColorTemplates.colorful()
            + ChartColorTemplates.liberty()
            + ChartColorTemplates.pastel()
            + [UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)]

        let data = PieChartData(dataSet: set)

        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 9, weight: .medium))
        data.setValueTextColor(.black)

        donutChartView.data = data
        donutChartView.highlightValues(nil)
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard chartView.tag == HomeChart.donutSpending.rawValue,
              let donutEntry = entry as? PieChartDataEntry,
              let spendingName = donutEntry.label else {
            return
        }
        viewModel.navigateToTransactionDetail(spendingName)
    }
}

// MARK: Line Chart Functions

extension HomeViewController {
    private func setupLineChart() {
        lineChartView.tag = HomeChart.lineProgress.rawValue
        lineChartView.dragEnabled = false
        lineChartView.setScaleEnabled(false)
        lineChartView.pinchZoomEnabled = false
        
        lineChartView.xAxis.gridLineDashLengths = [10, 10]
        lineChartView.xAxis.gridLineDashPhase = 0
        lineChartView.xAxis.axisMinimum = 1
        lineChartView.xAxis.axisMaximum = 12
        lineChartView.xAxis.labelPosition = .bottom
    

        let leftAxis = lineChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 15
        leftAxis.axisMinimum = 0
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true

        lineChartView.rightAxis.enabled = false
        lineChartView.legend.form = .line
        lineChartView.animate(xAxisDuration: 2.5)
    }
    
    func setLineChartView(progressChartData: ProgressChartData?) {
        guard let progressData = progressChartData?.data else {
            return
        }
        
        let values = (0..<progressData.month.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i+1), y: Double(progressData.month[i]), icon: nil)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "Profit in %")
        set1.drawIconsEnabled = false
        setupLineChartDataSet(set1)
        let gradientColors = [ChartColorTemplates.colorFromString("#b2ffb2").cgColor,
                              ChartColorTemplates.colorFromString("#00FF00").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 1
        set1.fill = LinearGradientFill(gradient: gradient, angle: 90)
        set1.drawFilledEnabled = true

        let data = LineChartData(dataSet: set1)
        lineChartView.data = data
    }
    
    private func setupLineChartDataSet(_ dataSet: LineChartDataSet) {
        if dataSet.isDrawLineWithGradientEnabled {
            dataSet.lineDashLengths = nil
            dataSet.highlightLineDashLengths = nil
            dataSet.setColors(.black, .red, .white)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = [0, 40, 100]
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = nil
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        } else {
            dataSet.lineDashLengths = [5, 2.5]
            dataSet.highlightLineDashLengths = [5, 2.5]
            dataSet.setColor(.black)
            dataSet.setCircleColor(.black)
            dataSet.gradientPositions = nil
            dataSet.lineWidth = 1
            dataSet.circleRadius = 3
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
        }
    }
}
