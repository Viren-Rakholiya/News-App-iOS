//
//  TopNewsFeedVC.swift
//  ProjectPart-2
//

import UIKit
import FirebaseAuth

class TopNewsFeedVC: UIViewController {
    @IBOutlet weak var tblview: UITableView!
    
    let tableViewData = Array(repeating: "Item", count: 5)
    private var items: [ItemToDo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadDefaultItems()
        tblview.dataSource = self
        tblview.delegate = self
        
        tblview.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "Cell")

//        tblview.register(CellTableViewCell.self,
//                               forCellReuseIdentifier: "Cell")
//         Do any additional setup after loading the view.
        let url: URL? = getURL()
        let urlSession = URLSession(configuration: .default)
        if let url = url {
            let dataTask = urlSession.dataTask(with: url) { data, response, error in
                guard error == nil  else {
                    print(error ?? "")
                    return
                }
                guard let data = data else {
                    print("No data Received")
                    return
                }
                if let NewsModel = parseJson(data: data) {
                    print("Status: \(NewsModel.status)")
                    print("Results: \(NewsModel.totalResults)")

                    for article in NewsModel.articles{
                        self.items.append(ItemToDo(title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage ?? ""))
                        print(self.items.count)
                    }
                    DispatchQueue.main.async {
                        self.tblview.reloadData()
                    }
                }
            }

            dataTask.resume()
        }
//         func loadDefaultItems() {
//        items.append(ItemToDo (title: "Item 2", description: "Description 2", url: "sd", urlToImage: "sd"))
//        items.append(ItemToDo (title: "Item 2", description: "Description 2", url: "sd", urlToImage: "sd"))
//        items.append(ItemToDo (title: "Item 2", description: "Description 2", url: "sd", urlToImage: "sd"))
//        items.append(ItemToDo (title: "Item 2", description: "Description 2", url: "sd", urlToImage: "sd"))
//            }
    }
    
    @IBAction func onProfileClick(_ sender: UIButton) {
        navigateToProfileScreen()
    }
    private func navigateToProfileScreen() {
        performSegue(withIdentifier: "ToProfileScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToProfileScreen" {
            if let userEmailID = Auth.auth().currentUser?.email {
                let destination = segue.destination as! ProfileScreenVC
                destination.userEmailID = userEmailID
                
            }
        }
    }
}

struct ItemToDo {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
}

extension TopNewsFeedVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.tableViewData.count
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CellTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let item = items[indexPath.row]
        let data = try? Data(contentsOf: URL(string: item.urlToImage)!)

        cell.lblText.text = item.title
        cell.imgView.image = UIImage(data: data!)
//        cell.lbldesc.text = item.description
//        var content = cell.defaultContentConfiguration()
//        content.text = item.urlToImage
//        content.secondaryText = item.url
//        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewsDescriptionVC") as! NewsDescriptionVC
        nextViewController.txtTitleStr = items[indexPath.row].title
        nextViewController.txtDescriptionStr = items[indexPath.row].description
        nextViewController.imgNewsStr = items[indexPath.row].urlToImage
//        nextViewController.imgNews = items[indexPath.row].url
        
        present(nextViewController, animated: false)
//        self.navigationController?.pushViewController(nextViewController, animated: false)
//        navigateToHomecreen()
    }
    private func navigateToHomecreen() {
        performSegue(withIdentifier: "newsDescription", sender: self)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let cell = sender as? CellTableViewCell {
//            let i = tblview.indexPath(for: cell)!.row
//            if segue.identifier == "newsDescription" {
//                let destination = segue.destination as! NewsDescriptionVC
//                destination.txtTitleStr =  items[i].title
//               }
//           }
//
//    }
    
}

struct NewsModel: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String!
    let description: String!
    let url: String
    let urlToImage: String?
//    let publishedAt: Date
    let content: String
}

struct Source: Decodable {
    let id: String?
    let name: String
}

func getURL() -> URL? {
    let baseUrl = "https://newsapi.org/v2/everything?q=Apple&from=2022-08-12&sortBy=popularity&apiKey=925329d682844a20b467fc1d21f17cac"
    let endpoint = "\(baseUrl)"
    return  URL(string: endpoint)
}

func parseJson(data: Data)-> NewsModel?{
    let decoder = JSONDecoder()
    var wrapper: NewsModel?
    do{
        wrapper = try decoder.decode(NewsModel.self, from: data)
    }
    catch {
        print(error)
    }
    return wrapper
}
