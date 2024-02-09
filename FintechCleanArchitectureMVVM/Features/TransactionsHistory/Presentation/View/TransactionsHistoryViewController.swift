//
//  TransactionsHistoryViewController.swift
//  FintechCleanArchitectureMVVM
//
//  Created by Jehnsen Hirena Kane on 03/12/23.
//

import UIKit
import Combine

//class TransactionsHistoryTableViewDiffableDataSource: UITableViewDiffableDataSource<String?, SpendingHistory> {}

class TransactionsHistoryViewController: UIViewController {
    private var viewModel: TransactionsHistoryViewModel
    private var bindings = Set<AnyCancellable>()
    
    @IBOutlet weak var transactionsTableView: UITableView!
    
    init(viewModel: TransactionsHistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        transactionsTableView.backgroundColor = .white
        transactionsTableView.backgroundView?.backgroundColor = .white
    }
    
    private func updateUI(_ spending: Spending?) {
        title = spending?.label ?? "Transaction History"
    }
    
    private func setupBindings() {
        viewModel.$spendingData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] spending in
                self?.updateUI(spending)
                self?.transactionsTableView.reloadData()
            }
            .store(in: &bindings)
    }
}

// MARK: TableView functions
extension TransactionsHistoryViewController: UITableViewDataSource {
    private func setupTableView() {
        transactionsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.spendingData?.data.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "transactionTableViewCell")
        cell.backgroundColor = .white
        cell.isUserInteractionEnabled = false
        let transaction = viewModel.spendingData?.data[indexPath.row]
        var contentCell = cell.defaultContentConfiguration()
        contentCell.text = (transaction?.nominal ?? .zero).currencyString()
        contentCell.textProperties.color = .black
        contentCell.secondaryText = transaction?.transactionDate ?? .zeroString
        contentCell.secondaryTextProperties.color = .gray
        cell.contentConfiguration = contentCell
        return cell
    }
}
