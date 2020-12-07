//
//  CommentsViewController.swift
//  Steps
//
//  Created by Data Kondzhariia on 07.12.2020.
//  Copyright (c) 2020 Steps. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

protocol CommentsDisplayLogic: class {
    func displaySetupInfoSuccess(viewModel: Comments.SetupInfo.ViewModel)

    func displayFetchNextPageCommentsSuccess(viewModel: Comments.Fetch.ViewModel)
    func displayFetchNextPageCommentsError(viewModel: Comments.Fetch.ViewModel)
    func displayFetchEndOfComments(viewModel: Comments.Fetch.ViewModel)
}

class CommentsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!

    public var interactor: CommentsBusinessLogic?
    public var router: (NSObjectProtocol & CommentsRoutingLogic & CommentsDataPassing)?

    private var displayedComments = [Comments.DisplayedComment]()
 
    override func awakeFromNib() {
        super.awakeFromNib()

        CommentsConfigurator.shared.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Private Methods
extension CommentsViewController {

    // UI
    private func setupUI() {
        tableView.register(R.nib.commentsTableViewCell)
        tableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        setupInfiniteScroll()
    }

    private func setupInfiniteScroll() {
        tableView.addInfiniteScroll { [weak self] tableView in
            self?.fetchComments()
        }
    }

    // Requests
    private func setupInfo() {
        let request = Comments.SetupInfo.Request()
        interactor?.setupInfo(request: request)
    }

    private func fetchComments() {
        let request = Comments.Fetch.Request()
        interactor?.fetchNextPage(request: request)
    }
}

// MARK: - Table View Data Source
extension CommentsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        displayedComments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.commentsTableViewCell, for: indexPath)!
        let comment = displayedComments[indexPath.row]
        cell.configure(comment: comment)
        return cell
    }
}

// MARK: - Table View Delegate
extension CommentsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Comments Display Logic
extension CommentsViewController: CommentsDisplayLogic {

    func displaySetupInfoSuccess(viewModel: Comments.SetupInfo.ViewModel) {
        displayedComments = viewModel.displayedComments
        tableView.setShouldShowInfiniteScrollHandler { _ in return true }
        tableView.reloadData()
    }

    func displayFetchNextPageCommentsSuccess(viewModel: Comments.Fetch.ViewModel) {
        if viewModel.displayedComments.isEmpty {
            tableView.finishInfiniteScroll()
            return
        }

        // Detect new comments index
        let displayedCommentsCount = displayedComments.count
        displayedComments += viewModel.displayedComments

        var indexPaths = [IndexPath]()

        for row in displayedCommentsCount...displayedComments.count - 1  {
            indexPaths.append(IndexPath(row: row, section: 0))
        }

        // Insert cells to tableView
        UIView.performWithoutAnimation { [weak self] in
            self?.tableView.insertRows(at: indexPaths, with: .none)
        }

        tableView.finishInfiniteScroll()
    }

    func displayFetchNextPageCommentsError(viewModel: Comments.Fetch.ViewModel) {
        tableView.finishInfiniteScroll()
        let alert = UIAlertController(title: "Error", message: viewModel.error?.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func displayFetchEndOfComments(viewModel: Comments.Fetch.ViewModel) {
        tableView.finishInfiniteScroll()
        tableView.setShouldShowInfiniteScrollHandler { _ in return false }
    }
}
