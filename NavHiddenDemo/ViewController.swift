//
//  ViewController.swift
//  NavHiddenDemo
//
//  Created by Dylan Chen on 2019/10/11.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var isNavigationBarBGViewHidden: Bool = false
    private let tableView = UITableView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        updateNavigationBarStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBarBGView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.backgroundColor = UIColor.white
        title = "网易云音乐"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: Constant.cellReusableString)
        tableView.backgroundColor = UIColor.gray
        
        let nibView = UINib(nibName: "TableHeaderView", bundle: Bundle.main)
        let headerView = nibView.instantiate(withOwner: self, options: nil).first as? TableHeaderView
        tableView.tableHeaderView = headerView
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        extendedLayoutIncludesOpaqueBars = true
    }

    private func updateNavigationBarStyle() {
        let anchor: CGFloat = Constant.navBarShowContentOffectY
        if tableView.contentOffset.y < anchor {
            hideNavigationBarBGView()
        } else {
            showNavigationBarBGView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        if #available(iOS 11.0, *) {
        } else {
            //兼容ios11以下的版本
            tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 234)
        }
    }
    
    private func hideNavigationBarBGView() {
        guard !isNavigationBarBGViewHidden, let navigationController = navigationController else {
            return
        }
        isNavigationBarBGViewHidden = true
        navigationController.hideNavigationBarBGView()
    }
    
    private func showNavigationBarBGView() {
        guard isNavigationBarBGViewHidden, let navigationController = navigationController else {
            return
        }
        isNavigationBarBGViewHidden = false
        navigationController.showNavigationBarBGView()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellReusableString) else { return UITableViewCell()
        }
        if indexPath.row == 0 {
            cell.textLabel?.text = "去透明nav"
        } else {
            cell.textLabel?.text = "第\(indexPath.row)行"
        }
        return cell
    }
}

extension ViewController: UIScrollViewDelegate, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateNavigationBarStyle()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(ViewController(), animated: true)
        } else {
            navigationController?.pushViewController(SubController(), animated: true)
        }
    }
}

extension ViewController {
    private enum Constant {
        static let navBarShowContentOffectY: CGFloat = 10
        static let scrollViewContentInsetTop: CGFloat = 64
        static let cellReusableString: String = "cell"
    }
}
