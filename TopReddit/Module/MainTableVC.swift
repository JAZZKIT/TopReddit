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
        featchPosts()
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
            
            if let url = URL(string: post.url_overridden_by_dest ?? "") {
                self.presentSafariVC(with: url )
            }
        }
    }
    
}

// MARK: -  Pagination
extension MainTableVC {
    
    private func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard !NetworkManager.shared.isPaginating else { return }
            self.tableView.tableFooterView = createSpinerFooter()
            featchPosts()
            print(posts.count)
        }
    }
}
 


// MARK: - Networking
extension MainTableVC {
    func featchPosts() {
        NetworkManager.shared.fetchPosts { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.tableView.tableFooterView = nil
                switch result {
                case .success(let posts):
                    self.posts.append(contentsOf: posts)
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    self.presentErrorToUser(message: error.rawValue)
                }
            }
        }
    }
}

