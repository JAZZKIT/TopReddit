//
//  ViewController.swift
//  TopReddit
//
//  Created by Denny on 03.05.2022.
//

import UIKit

class MainTableVC: UITableViewController {
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
// MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell else { return UITableViewCell() }
        
        let post = self.posts[indexPath.row]
        
        cell.titleLabel.text = post.title
        cell.authorLabel.text = "Created by \(post.author)"
        cell.commentsLabel.text = "Comments: \(post.num_comments)"
        cell.pictureView.image = nil
        cell.dateLabel.text = "\(post.created_utc.getHour())h Ago"
        
        NetworkManager.shared.fetchThumbnail(post: post) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail):
                    cell.pictureView.image = thumbnail
                    print("got image")
                case .failure(_):
                    cell.pictureView.image = UIImage(named: "noImage")
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (self.tableView.cellForRow(at: indexPath) as? PostCell) != nil {
            let post = posts[indexPath.row]
            
            if let url = URL(string: post.url_overridden_by_dest) {
                self.presentSafariVC(with: url )
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard !NetworkManager.shared.isPaginating else { return }
            fetchData()
        }
    }
    
    
}

extension MainTableVC {
    func fetchData() {
        NetworkManager.shared.fetchPosts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(message: error.rawValue)
                }
            }
        }
    }
}

