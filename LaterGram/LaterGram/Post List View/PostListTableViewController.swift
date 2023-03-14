//
//  PostListTableViewController.swift
//  LaterGram
//
//  Created by Jake Gloschat on 3/14/23.
//

import UIKit

class PostListTableViewController: UITableViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Telling the tableview to scale its cell height to its content
        tableView.rowHeight = UITableView.automaticDimension
        /// Giving the TableView an estimated height to start calculating from
        tableView.estimatedRowHeight = 70
        viewModel = PostListViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }

    // MARK: - Properties
    var viewModel: PostListViewModel!
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostListTableViewCell else { return UITableViewCell() }

        let post = viewModel.posts[indexPath.row]
        cell.configureCell(with: post)
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? PostDetailViewController else { return }
       
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let post = viewModel.posts[indexPath.row]
            destination.viewModel = PostDetailViewModel(post: post)
        } else {
            destination.viewModel = PostDetailViewModel()
        }
    }
}

extension PostListTableViewController: PostListViewModelDelegate {
    func postsLoadedSuccessfully() {
        tableView.reloadData()
    }
}
