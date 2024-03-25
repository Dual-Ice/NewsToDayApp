//
//  RecomendedView.swift
//  NewsToDayApp
//
//  Created by Polina on 22.03.2024.
//

import UIKit
import SnapKit

protocol RecomendedViewDelegate: AnyObject {
    func tappedBackButton()
}

class RecomendedView: CustomView {
    weak var delegate: RecomendedViewDelegate?
    
    private let title = LabelsFactory.makeHeaderLabel()
    private let subTitle = LabelsFactory.makeTextLabel()
    private let tableView = UITableView()
    private let backButton = ButtonsFactory.makeButton()
    
    override func setViews() {
        self.backgroundColor = .white
        setUpViews()
        configureTableView()
        [
            backButton,
            title,
            subTitle,
            tableView,
        ].forEach { addSubview($0) }
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("RecomendedViewTitle", comment: "")
        subTitle.text = NSLocalizedString("RecomendedViewSubTitle", comment: "")
        
        backButton.backgroundColor = .clear
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.tintColor = UIColor(named: ConstColors.greyPrimary)
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.rowHeight = 110
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookmarksCell.self, forCellReuseIdentifier: BookmarksCell.resuseID)
    }
    
    override func layoutViews() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(28)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
}

//MARK: - RecomendedVCDelegate
extension RecomendedView: RecomendedVCDelegate{
    func setTableDelegate(vc: RecomendedViewController) {
        tableView.delegate = vc
    }
    
    func setTableViewDataSource(vc: RecomendedViewController) {
        tableView.dataSource = vc
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
