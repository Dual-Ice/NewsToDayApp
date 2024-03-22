//
//  BookmarksView.swift
//  NewsToDayApp
//
//  Created by Polina on 21.03.2024.
//

import UIKit
import SnapKit

protocol BookmarksViewDelegate: AnyObject {
}

class BookmarksView: CustomView {
    weak var delegate: BookmarksViewDelegate?
    
    private let title = LabelsFactory.makeHeaderLabel()
    private let subTitle = LabelsFactory.makeTextLabel()
    private let tableView = UITableView()
    private let circleView = ImageViewFactory.makeCornerRadiusImage()
    private let bookImage = UIImageView(image: UIImage(named: "book-alt"))
    private let emptyBookmarksLabel = LabelsFactory.makeTextLabel()
    
    override func setViews() {
        self.backgroundColor = .white
        setUpViews()
        configureTableView()
        circleView.addSubview(bookImage)
        [
            emptyBookmarksLabel,
            title,
            subTitle,
            tableView,
            circleView,
        ].forEach { addSubview($0) }
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("BookmarksViewTitle", comment: "")
        subTitle.text = NSLocalizedString("BookmarksViewSubTitle", comment: "")
        
        circleView.layer.cornerRadius = 36
        circleView.backgroundColor = UIColor(named: ConstColors.greyLighter)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        emptyBookmarksLabel.textAlignment = .center
        emptyBookmarksLabel.textColor = UIColor(named: ConstColors.blackPrimary)
        emptyBookmarksLabel.font = UIFont.TextFont.Bookmarks.emptyText
        emptyBookmarksLabel.text = NSLocalizedString("BookmarksViewEmptyText", comment: "")
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
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(24)
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
        
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(72)
            make.centerX.centerY.equalToSuperview()
        }
        
        bookImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerX.centerY.equalTo(circleView)
        }
        
        emptyBookmarksLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
}

//MARK: - BookmarksVCDelegate
extension BookmarksView: BookmarksVCDelegate{
    func setTableDelegate(vc: BookmarksViewController) {
        tableView.delegate = vc
    }
    
    func setTableViewDataSource(vc: BookmarksViewController) {
        tableView.dataSource = vc
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func emptyBookmarsTrue() {
        tableView.isHidden = true
        circleView.isHidden = false
        emptyBookmarksLabel.isHidden = false
    }
    
    func emptyBookmarsFalse() {
        tableView.isHidden = false
        circleView.isHidden = true
        emptyBookmarksLabel.isHidden = true
    }
}
