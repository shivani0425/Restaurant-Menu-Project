
import UIKit

class MenuListViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var menuListTableView: UITableView!
    
    // MARK: Variables
    var itemsData: RestaurantModel?
    private var commonArray = [MenuItemModel]()
    private var snacksArray = [MenuItemModel]()
    private var mainCourseArray = [MenuItemModel]()
    
    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        menuListTableView.dataSource = self
        menuListTableView.delegate = self
        self.title = "Menu List"
        
        menuListTableView.register(UINib(nibName: "CustomMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        guard let itemsData = itemsData else {
            print("ItemsData is Nil")
            return
        }
        let emptyArray = [MenuItemModel]()
        commonArray = itemsData.commonArray ?? emptyArray
        snacksArray = itemsData.snacks ?? emptyArray
        mainCourseArray = itemsData.mainCourse ?? emptyArray
        
        switch itemsData.menuType {
        case .plain:
            return self.title = "Plain Menu List"
        case .mixed:
            return self.title = "Mix Menu List"
        case .sectionWise:
            return self.title = "Menu List With Section"
        }
    }
    
    // MARK: Other methods
    private func fetchDummyModel() -> MenuItemModel {
        return MenuItemModel(itemName: "",
                             itemDescription: "",
                             itemPrice: 0)
    }
}

// MARK: UITableViewDataSource
extension MenuListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch itemsData?.menuType {
        case .mixed, .plain:
            return 1
        case .sectionWise:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemsData = itemsData else {
            print("Invaid data")
            return 0
        }
        switch itemsData.menuType {
        case .mixed, .plain:
            return commonArray.count
        case .sectionWise: do {
            if section == 0 {
                return snacksArray.count
            } else {
                return mainCourseArray.count
            }
        }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         guard let cell = self.menuListTableView.dequeueReusableCell(withIdentifier: "cell") as? CustomMenuTableViewCell else{
            return UITableViewCell()
        }
        let menuItem = fetchMenuItem(indexPath: indexPath)
//        cell.textLabel?.text = menuItem.itemName
//        cell.detailTextLabel?.text = "\(menuItem.itemPrice)"
        cell.menuNameLabel.text = menuItem.itemName
        cell.menuPriceLabel.text = "\(menuItem.itemPrice)"
        
        switch itemsData?.menuType {
        case .mixed:
            if (indexPath.row % 2 == 0 ) {
                cell.backgroundColor = UIColor.orange
            }else{
                cell.backgroundColor = UIColor.yellow
            }
            default:
               break
            }
        
        return cell
    }
    
    private func fetchMenuItem(indexPath: IndexPath) -> MenuItemModel {
        guard let itemsData = itemsData else {
            print("Invaid data")
            return fetchDummyModel()
        }
        
        switch itemsData.menuType {
        case .plain, .mixed: do {
            let item = commonArray[indexPath.row]
            return item
        }
        case .sectionWise: do {
            let item: MenuItemModel
            if indexPath.section == 0 {// Snacks
                item = snacksArray[indexPath.row]
            } else {// Maincourse
                item = mainCourseArray[indexPath.row]
            }
            return item
        }
        }
    }
}

// MARK: UITableViewDelegate
extension MenuListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch itemsData?.menuType {
        case .mixed, .plain:
            return ""
        case .sectionWise: do {
            if section == 0 {
                return "Snacks"
            } else {
                return "MainCourse"
            }
        }
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                

        switch itemsData?.menuType {
        case .mixed:
              warning()
        default:
               break
            }
        
        func warning() {
            
                let dialogMessage = UIAlertController(title: "Warning!", message: "Sorry,No Bargaing", preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                 })
                
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
                
                tableView.deselectRow(at: indexPath, animated: true)
        
            }

}


}
