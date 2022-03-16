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
    private var viewWillAppearTrigger = Trigger()
    private var cancellables = CancellableBag()

    private var bgColor: UIColor?
    private var navBarTitle: String?
    private var tableViewStyle: UITableView.Style = .plain

    private var timer: Timer?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupbackgroundColor(with: bgColor)
        setupNavBarTitle(with: navBarTitle)
        setupTableView(with: tableViewStyle)
        configDataProvider()
        bindViewModel()
        viewDidLoadTrigger.trigger()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearTrigger.trigger()
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

    private func setupTableView(with style: UITableView.Style = .plain) {
        tableView = UITableView(frame: .zero, style: style)
        view.addSubview(tableView)
        tableView.snp.removeConstraints()
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configDataProvider() {
        dataProvider.tableView = tableView
    }

    // MARK: - Bind

    private func bindViewModel() {
        let output = viewModel.transform(input: TableViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger.asDriver(),
                                                                     viewWillAppearTrigger: viewWillAppearTrigger.asDriver(),
                                                                     selectedElement: dataProvider.selectedElement.asDriver()),
                                         disposeBag: cancellables)

        output.reloadDataTrigger.sink { [weak self] (dataSourceData, reloadInfo) in
            guard let self = self else { return }
            self.updateDataSourceContent(with: dataSourceData)
            self.reloadTable(with: reloadInfo)
        }.store(in: cancellables)

        output.updateTimer.sink { [weak self] isActive in
            guard let self = self else { return }
//            print(">>> Timer is \(isActive ? "Active" : "Inactive")")
            isActive ? self.enableTimer() : self.disableTimer()
        }.store(in: cancellables)
    }

    private func reloadTable(with reloadInfo: ReloadInfo? = nil) {
        executeInMainThread {
            guard let reloadInfo = reloadInfo else { self.tableView.reloadData() ; return }
            self.dataProvider.reloadCell(for: reloadInfo)
        }
    }

    // MARK: - Update Methods

    private func updateDataSourceContent(with data: [ViewModelSection]?) {
        dataProvider.dataSource.updateDataSource(with: data)
    }

    // MARK: - Timer Methods
    private func disableTimer() {
        if let timer = timer { timer.invalidate() }
    }

    private func enableTimer() {
        disableTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimeInformation),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc private func updateTimeInformation() {
        NotificationCenter.default.post(name: .updateTimer,
                                        object: nil)
    }
}
