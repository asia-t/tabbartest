
import UIKit

class BlueViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet var tableView: UITableView!
    
    var items: [String] = ["red", "blue", "green"]

    var filteredItems = [String]()
    
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var vanillaSearchBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        navigationController?.navigationBar.translucent = false
        navigationController?.extendedLayoutIncludesOpaqueBars = true;
        self.extendedLayoutIncludesOpaqueBars = true;
        automaticallyAdjustsScrollViewInsets = false
        //self.edgesForExtendedLayout = .None
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.hidesNavigationBarDuringPresentation = false

        searchController.searchBar.autocapitalizationType = .None
        vanillaSearchBar.addSubview(searchController.searchBar)
        
        self.definesPresentationContext = true

//        searchController.searchBar.sizeToFit()
        
        print("search bar bounds, frame: ", searchController.searchBar.bounds, searchController.searchBar.frame)
        print("bar bounds, frame: ", vanillaSearchBar.bounds, vanillaSearchBar.frame)
        print("self bounds: ", self.view.bounds)

        
        tableView.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredItems.count
        }
        
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
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
        print("search bar bounds, frame: ", searchController.searchBar.bounds, searchController.searchBar.frame)

        filterContentForSearchText(searchController.searchBar.text!)
    }
}
