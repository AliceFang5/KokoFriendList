//
//  FriendListViewController.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/7.
//

import UIKit
import SnapKit

class FriendListViewController: UIViewController {
    
    private let viewModel = FriendListViewModel()
    
    private lazy var searchView: SearchView = {
        let searchView = SearchView()
        searchView.delegate = self
        return searchView
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.delegate = self
        return view
    }()
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    func updateFriendList(list: [FriendInfo]) {
        viewModel.updateFriendList(list: list)
        emptyView.isHidden = !list.isEmpty
        tableView.reloadData()
    }
}

private extension FriendListViewController {
    
    func setupUI() {
        view.addSubview(searchView)
        view.addSubview(tableView)
        view.addSubview(emptyView)
        
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        tableView.register(FriendListTableViewCell.self, forCellReuseIdentifier: "FriendListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
}

extension FriendListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFriendListCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListTableViewCell", for: indexPath) as? FriendListTableViewCell else{
            return UITableViewCell()
        }
        
        guard let info = viewModel.getFriendInfo(index: indexPath.row) else { return UITableViewCell() }
        cell.updateFriendInfo(info: info)
        return cell
    }
}

extension FriendListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension FriendListViewController: SearchViewDelegate {
    
    func didTapSearchButton() {
        searchView.snp.updateConstraints { make in
            make.top.equalToSuperview().offset(100)
        }
    }
    
    func endSearching() {
        searchView.snp.updateConstraints { make in
            make.top.equalToSuperview()
        }
    }
    
    func searchTextDidChange(_ searchText: String) {
        viewModel.updateSearchText(searchText)
        tableView.reloadData()
    }
}

extension FriendListViewController: EmptyViewDelegate {
    
    func onAddFriendButtonTapped() {
        
    }
}
