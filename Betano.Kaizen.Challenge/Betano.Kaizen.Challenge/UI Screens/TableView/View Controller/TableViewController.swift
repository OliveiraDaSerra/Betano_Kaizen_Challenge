//
//  TableViewController.swift
//  Betano.Kaizen.Challenge
//
//  Created by Nuno Oliveira on 27/02/2022.
//

import Foundation
import UIKit
import SnapKit

protocol TableViewControllerType: UIViewController {
    var viewModel: TableViewModel! { get set }
    var dataProvider: TableViewDataProvider! { get set }
}

class TableViewController: UIViewController, TableViewControllerType {

    // MARK: - Properties
    internal var viewModel: TableViewModel!
    internal var dataProvider: TableViewDataProvider!
    private var tableView: UITableView!
    private var viewDidLoadTrigger = Trigger()
    private var cancellables = CancellableBag()

    private var bgColor: UIColor?
    private var navBarTitle: String?
    private var tableViewStyle: UITableView.Style = .plain
    

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupbackgroundColor(with: bgColor)
        setupNavBarTitle(with: navBarTitle)
//        setupViewModel(with: viewModel)
//        setupDataProvider(with: dataProvider)
        setupTableView(with: tableViewStyle)
        bindViewModel()
        viewDidLoadTrigger.trigger()
    }

    // MARK: - Initialization Methods
    init(bgColor: UIColor? = nil,
         title: String? = nil,
         viewModel: TableViewModel,
         dataProvider: TableViewDataProvider,
         style: UITableView.Style) {
        super.init(nibName: nil, bundle: nil)
        self.bgColor = bgColor
        self.navBarTitle = title
        self.viewModel = viewModel
        self.dataProvider = dataProvider
        self.tableViewStyle = style
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup Methods

    private func setupbackgroundColor(with color: UIColor? = nil) {
        view.backgroundColor = color
    }

    private func setupNavBarTitle(with navBarTitle: String? = nil) {
        title = navBarTitle
    }

    private func setupViewModel(with viewModel: TableViewModel) {
        self.viewModel = viewModel
    }

    private func setupDataProvider(with dataProvider: TableViewDataProvider) {
        self.dataProvider = dataProvider
    }

    private func setupTableView(with style: UITableView.Style = .plain) {
        tableView = UITableView(frame: .zero, style: style)
        view.addSubview(tableView)
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { make in
            make.margins.equalToSuperview()
        }
    }

    private func bindViewModel() {
        let output = viewModel.transform(input: TableViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger.asDriver(),
                                                                     selectedIndexPath: dataProvider.selectedIndexPath),
                                         disposeBag: cancellables)

        output.reloadDataTrigger.sink { [weak self] _ in
            guard let self = self else { return }
        }.store(in: cancellables)
    }
}
