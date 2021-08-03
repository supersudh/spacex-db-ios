//
//  MainPageViewController.swift
//  SpaceX-Dashboard
//
//  Created by Sudharsan Ravikumar on 02/08/21.
//

import UIKit

class MainPageViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieViewModel()
    override func viewDidLoad() {
        print("MainPageViewController")
        // Do any additional setup after loading the view.
        loadPopularMoviesData()
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func menuTapped(_ sender: UIButton) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
}
// MARK: - TableView
extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
}
