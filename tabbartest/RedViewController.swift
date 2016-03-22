import UIKit

class RedViewController: UITableViewController, UISearchResultsUpdating {

    var items: [String] = ["some", "list", "items"]
    var filteredItems = [String]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var vanillaSearchBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        self.edgesForExtendedLayout = .None
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.autocapitalizationType = .None
        searchController.searchBar.barTintColor = UIColor.whiteColor()
        searchController.searchBar.backgroundColor = UIColor.clearColor()
        
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
        
        tableView.delegate = self
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredItems.count
        }
        
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        var selectedItem : String
        if searchController.active && searchController.searchBar.text != "" {
            selectedItem = filteredItems[indexPath.row]
        } else {
            selectedItem = items[indexPath.row]
        }
    
        cell.textLabel?.text = selectedItem
        
        return cell
    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredItems = []
        items.forEach { item in
            if (item.hasPrefix(searchText)) {
                filteredItems.append(item)
            }
        }
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
