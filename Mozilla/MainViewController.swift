//
//  ViewController.swift
//  Mozilla
//
//  Created by Konstantin Klyatskin on 2019-10-04.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var browserView: UIView!
    @IBOutlet weak var webLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    let model = SuggestionModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUIFor(searchStr: String) {
        if (searchStr == searchbar.text) {
            self.tableView.reloadData()
        }
    }
}



extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard (model.suggestionsToShow != nil) else {
            return 0
        }
        return model.suggestionsToShow!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SomeCellId", for: indexPath)
        cell.textLabel!.text = model.suggestionsToShow![indexPath.row]
        return cell
    }
}


extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openWebWith(searchStr: model.suggestionsToShow![indexPath.row])
    }
}


extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.updateFor(searchStr: searchBar.text!, controller:self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if ((searchBar.text?.count) != nil) {
            openWebWith(searchStr: searchBar.text!)
        }
    }
}

// MARK: - Actions/animations

extension MainViewController {
    @IBAction func btnTapped(_ sender: UIButton) {
        animate(toWeb: false)
    }
    
    func openWebWith(searchStr: String) {
        searchbar.resignFirstResponder()
        self.webLabel.text = searchStr
        let bingPoint = "https://www.bing.com/search?q="
        let urlStr =  bingPoint + searchStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let request = URLRequest(url: URL(string: urlStr)!)
        self.webView.load(request)
        animate(toWeb: true)
    }
    
    func animate(toWeb: Bool) {
        let animation = CATransition()
        animation.duration = 1.0
        animation.type = .fade
        self.browserView.isHidden = !toWeb
        self.searchView.isHidden = toWeb
        self.view.layer.add(animation, forKey: "animation")
    }
}
