//
//  TermsAndConditionsView.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 22.03.2024.
//

import UIKit

protocol TermsAndConditionsViewDelegate: AnyObject {
    func tappedBackButton()
}

final class TermsAndConditionsView: CustomView {
    
    weak var delegate: TermsAndConditionsViewDelegate?
    
    private let title = LabelsFactory.makeHeaderLabel()
    private lazy var termsText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.text = ""
        textView.textColor = UIColor(named: ConstColors.greyPrimary)
        textView.font = UIFont.TextFont.TermsAndConditions.text
        textView.textAlignment = .left
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    private let backButton = ButtonsFactory.makeButton()
    
    override func setViews() {
        setUpViews()
        backgroundColor = .white
        [
            title,
            termsText,
            backButton,
        ].forEach { addSubview($0) }
    }
    
    override func layoutViews() {
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(title)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        
        termsText.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setUpViews(){
        title.text = NSLocalizedString("TermsAndConditionsViewTitle", comment: "")
        termsText.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum pellentesque lectus enim, ut tristique orci eleifend vitae. Ut sed urna dolor. Maecenas nunc nisi, tristique cursus facilisis eget, ultrices et felis. Nam auctor felis nunc, luctus egestas magna finibus at. Mauris eu laoreet risus, et scelerisque ex. Vivamus pulvinar eros eget posuere eleifend. Cras velit mi, tristique ut nisl ut, suscipit pulvinar ipsum. Nulla porta, tellus et venenatis porta, quam ligula malesuada erat, a viverra nulla neque ornare nunc. Nulla at felis semper, rutrum ipsum quis, egestas leo. Integer mi risus, lacinia id lorem in, gravida luctus sem. Fusce at metus ut odio tristique vulputate eu maximus mi.

        Sed quis lorem at leo pretium maximus sit amet vitae velit. Nullam maximus lectus eu ligula egestas, quis congue dolor dictum. Sed vitae mollis ipsum. Phasellus convallis nisi vitae tincidunt hendrerit. Vestibulum ut lorem nec libero tempor pretium. Curabitur venenatis dui nec nisl aliquam, eget volutpat nisi luctus. Proin accumsan dolor ex, a pellentesque lacus pellentesque sed. Mauris suscipit dapibus sagittis. Nam finibus mauris posuere tortor sollicitudin aliquam. Etiam vel quam nunc.

        Mauris dignissim ultrices velit id vestibulum. Etiam hendrerit lectus id lorem scelerisque dictum vel eu velit. Praesent quis quam elit. Nulla facilisi. Pellentesque et erat a mi rhoncus consectetur eget eget arcu. Integer ultricies, orci nec tempor commodo, leo risus hendrerit orci, vitae gravida lectus eros ut sapien. Vestibulum pulvinar dolor vitae erat pretium, vel efficitur nunc ultrices. Duis cursus felis vel est auctor iaculis. Duis lorem lorem, faucibus eu ornare quis, pulvinar sit amet odio.

        Pellentesque bibendum nunc ut tincidunt vestibulum. Ut nec augue vel tellus sagittis convallis. Fusce congue nisi rutrum purus porttitor eleifend. Suspendisse aliquam, libero in placerat accumsan, nisl tellus mollis tortor, vel auctor dolor urna in risus. Nulla fringilla mollis feugiat. Cras est enim, eleifend vitae posuere nec, vulputate ac magna. Sed faucibus ante eget nibh tincidunt iaculis.

        Nullam eget nunc pharetra, malesuada augue nec, rutrum est. Nam condimentum, libero id interdum convallis, libero sem vestibulum risus, id sodales arcu lorem ac nulla. Nulla molestie, ante eu tristique placerat, mauris risus efficitur justo, eget fringilla enim urna blandit lorem. Phasellus ipsum diam, molestie a risus facilisis, ullamcorper convallis nunc. Quisque varius, justo nec interdum aliquet, nisi nunc tincidunt sem, at laoreet sapien neque ac diam. Sed sagittis eleifend eros, vel elementum felis lacinia id. Fusce vel tincidunt nulla, quis suscipit nisi. Suspendisse vitae cursus mauris. Morbi id ullamcorper mauris. Maecenas blandit aliquet mauris. Nunc semper tempor nunc, id dictum quam bibendum eu. Vestibulum laoreet, mauris sed tristique malesuada, urna nulla convallis lectus, ut interdum ligula ex in turpis. Praesent sit amet varius nisi. Etiam sagittis vel neque a bibendum. Sed malesuada nisl sed semper auctor. Nullam rhoncus sollicitudin elit non convallis.
"""
        
        backButton.backgroundColor = .clear
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
        backButton.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        backButton.tintColor = UIColor(named: ConstColors.greyPrimary)
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
}
