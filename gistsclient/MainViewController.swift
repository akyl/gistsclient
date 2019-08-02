//
//  ViewController.swift
//  gistsclient
//

import UIKit

class MainViewController: UITableViewController {
    
    var gists: [Gist] = [Gist]()
    
    let token = "your_token"
    let username = "your_user_name"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My gists"
        tableView.register(GistCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView  = UIView()
        load(username: username, token: token)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(handleUpdate))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gists.count
    }
    
    @objc func handleUpdate() {
        load(username: username, token: token)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! GistCell
    
        let gist = gists[indexPath.row]
        
        
        cell.textLabel?.text = "created date: \(gist.created_at) comments=\(gist.comments)"
        cell.detailTextLabel?.text = "url: \(gist.html_url)"
        if gist.public {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 204/255, alpha: 1.0)
        }
        
        return cell
    }
    
    private func load(username: String, token: String) {
        
        let stringUrl = "https://api.github.com/users/\(username)/gists"
        guard let url = URL(string: stringUrl) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "noDesc")
                return
            }
            
            guard let data = data else { return }
            
            guard let gists = try? JSONDecoder().decode([Gist].self, from: data) else {
                print("Error: can't parse gists")
                return
            }
            
            self.gists = gists
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        task.resume()
        
    }
}

