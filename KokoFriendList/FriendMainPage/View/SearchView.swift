//
//  SearchView.swift
//  KokoFriendList
//
//  Created by 方芸萱 on 2024/7/11.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didTapSearchButton()
    func endSearching()
    func searchTextDidChange(_ searchText: String)
}

class SearchView: UIView {
    
    weak var delegate: SearchViewDelegate? = nil
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.image(for: .search, state: .normal)
        searchBar.delegate = self
        searchBar.autocorrectionType = .no
        searchBar.spellCheckingType = .no
        searchBar.backgroundImage = UIImage()
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.enablesReturnKeyAutomatically = false
        }
        return searchBar
    }()
    
    private lazy var searchImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icBtnAddFriends"), for: .normal)
        button.addTarget(self, action: #selector(didTapSearchImageButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SearchView {
    
    func setupUI() {
        addSubview(searchBar)
        addSubview(searchImageButton)
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(30)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        searchImageButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalTo(searchBar.snp.centerY)
            make.leading.equalTo(searchBar.snp.trailing).offset(15)
        }
    }
    
    @objc func didTapSearchImageButton() {
        searchBar.becomeFirstResponder()
        delegate?.didTapSearchButton()
    }
}

extension SearchView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchTextDidChange(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        delegate?.didTapSearchButton()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.endSearching()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.endSearching()
    }
}
