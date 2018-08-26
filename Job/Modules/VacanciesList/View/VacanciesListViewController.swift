//
//  VacanciesListViewController.swift
//  MyRide
//
//  Created by Oleg Shupulin on 21.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import UIKit

class VacanciesListViewController: UIViewController {

	// MARK: Private Data Structures
    
    private enum Constants {
        static let estimatedRowHeight: CGFloat = 51
    }
    
    private enum Localized {
        static let title = "vacancies_list_title".localized
        static let placeholderError = "vacancies_list_error_placeholder".localized
        static let placeholderNoData = "vacancies_list_no_data_placeholder".localized
    }


    // MARK: Outlets
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.registerCells(for: [VacanciesListTableViewCell.self,
                                 PlaceholderTableCell.self])
        
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didStartRefresh), for: .valueChanged)
        refreshControl.backgroundColor = .white
        return refreshControl
    }()
    
    private lazy var tableFooterLoaderView: LoaderFooterView = {
        let view = LoaderFooterView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var initialLoader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.hidesWhenStopped = true
        return view
    }()
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    
	// MARK: Public Properties
	
	var output: IVacanciesListViewOutput!




	// MARK: Lifecycle
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        output.viewDidLoadEvent()
        setupView()
	}

    
    // MARK: Actions
    
    @objc private func didStartRefresh() {
        output.userWanToStartRefresh()
    }

    
	// MARK: Private
    
    private func setupView() {
        setupTableView()
        setupNavigationBar()
        setupInitialLoader()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = [
            "tableView": tableView
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let tableViewVerticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[tableView]|",
            metrics: nil,
            views: views)
        allConstraints += tableViewVerticalConstraints
        
        
        let tableViewHorizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[tableView]|",
            metrics: nil,
            views: views)
        allConstraints += tableViewHorizontalConstraints
        
        NSLayoutConstraint.activate(allConstraints)

        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        title = Localized.title
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
    }
    
    private func setupInitialLoader() {
        view.addSubview(initialLoader)
        initialLoader.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: initialLoader,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        
        let centerY = NSLayoutConstraint(item: initialLoader,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: view,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        
        let constraints = [centerX, centerY]
        NSLayoutConstraint.activate(constraints)
    }
}




// MARK: - IVacanciesListViewInput

extension VacanciesListViewController: IVacanciesListViewInput {
    
    func showInitialLoading() {
        tableView.isHidden = true
        initialLoader.startAnimating()
    }
    
    func stopInitialLoading() {
        tableView.isHidden = false
        initialLoader.stopAnimating()
    }
    
    func reloadTable() {
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func insertRows(at indexPaths: [IndexPath]) {
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .automatic)
        tableView.endUpdates()
    }
    
    func showAdditionalLoading() {
        if tableView.tableFooterView != tableFooterLoaderView {
            tableView.tableFooterView = tableFooterLoaderView
        }
        
        tableFooterLoaderView.displayLoader(true)
    }
    
    func hideAdditionalLoading() {
        guard tableView.tableFooterView == tableFooterLoaderView else { return }
        tableFooterLoaderView.displayLoader(false)
        tableView.tableFooterView = UIView()
    }
    
    func stopRefreshing() {
        guard refreshControl.isRefreshing else { return }
        refreshControl.endRefreshing()
    }
}




// MARK: - IVacanciesListTransitionHandlerProtocol

extension VacanciesListViewController: IVacanciesListTransitionHandlerProtocol {

}




// MARK: - UITableViewDelegate

extension VacanciesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if output.viewState == .error || output.viewState == .noData {
            return 1
        }
        
        return output.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if output.viewState == .error {
            let cell = tableView.dequeueReusableCell(for: PlaceholderTableCell.self)
            cell.configure(withText: Localized.placeholderError)
            return cell
        } else if output.viewState == .noData {
            let cell = tableView.dequeueReusableCell(for: PlaceholderTableCell.self)
            cell.configure(withText: Localized.placeholderNoData)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: VacanciesListTableViewCell.self)
            let displayData = output.displayDataForRow(at: indexPath)
            cell.configure(with: displayData)
            
            return cell
        }
    }
}




// MARK: - UITableViewDelegate

extension VacanciesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard output.viewState != .error && output.viewState != .noData else { return }
        
        let isLastSection = indexPath.section == tableView.numberOfSections - 1
        let isLastRow = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        
        if isLastSection && isLastRow {
            output.tableApproachesEndEvent()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if output.viewState == .error || output.viewState == .noData {
            return tableView.bounds.height
        } else {
            return UITableViewAutomaticDimension
        }
    }
}
