
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: Variables
    var mainCourseArray = [MenuItemModel]()
    var snacksArray = [MenuItemModel]()

    // MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Open Menu"
        mainCourseArray = fetchMainCourseArray()
        snacksArray = fetchSnacksArray()
    }
    
    // MARK: Array creation methods
    private func fetchMainCourseArray() -> [MenuItemModel] {
        let mainCourse1 = MenuItemModel(itemName: "Veg Biryani",
                                        itemDescription: "Contains capsicum and all veggies",
                                        itemPrice: 100)
        let mainCourse2 = MenuItemModel(itemName: "Mushrum Biryani",
                                        itemDescription: "Contains mushroom and all veggies",
                                        itemPrice: 150)
        let mainCourse3 = MenuItemModel(itemName: "Paneer Biryani",
                                        itemDescription: "Contains paneer, tofu and all veggies",
                                        itemPrice: 200)
        return [mainCourse1,
                mainCourse2,
                mainCourse3]
    }
    
    private func fetchSnacksArray() -> [MenuItemModel] {
        var snacksArray = [MenuItemModel]()
        let snack1 = MenuItemModel(itemName: "Wada-paav",
                                        itemDescription: nil,
                                        itemPrice: 10)
        snacksArray.append(snack1)
        
        let snack2 = MenuItemModel(itemName: "Samosa",
                                        itemDescription: nil,
                                        itemPrice: 20)
        snacksArray.append(snack2)
        
        let snack3 = MenuItemModel(itemName: "Kachori",
                                        itemDescription: nil,
                                        itemPrice: 30)
        snacksArray.append(snack3)
        
        let snack4 = MenuItemModel(itemName: "Daal-Pakwan",
                                        itemDescription: nil,
                                        itemPrice: 40)
        snacksArray.append(snack4)

        let snack5 = MenuItemModel(itemName: "Kachori",
                                        itemDescription: nil,
                                        itemPrice: 50)
        snacksArray.append(snack5)


        return snacksArray
    }
    
    // MARK: Button Actions
    @IBAction func plainButtonAction(_ sender: UIButton) {
        let dataToPass = RestaurantModel(menuType: .plain,
                                         snacks: nil,
                                         mainCourse: nil,
                                         commonArray: fetchPlainArray())
        navigateToMenuList(data: dataToPass)
    }
    
    @IBAction func mixedButtonAction(_ sender: UIButton) {
        let dataToPass = RestaurantModel(menuType: .mixed,
                                         snacks: nil,
                                         mainCourse: nil,
                                         commonArray: fetchMixedArray())
        navigateToMenuList(data: dataToPass)
    }
    
    @IBAction func sectionWiseButtonAction(_ sender: UIButton) {
        let dataToPass = RestaurantModel(menuType: .sectionWise,
                                         snacks: fetchSnacksArray(),
                                         mainCourse: fetchMainCourseArray(),
                                         commonArray: nil)
        navigateToMenuList(data: dataToPass)
    }
    
    private func navigateToMenuList(data: RestaurantModel) {
        guard let menuListVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuListViewController") as? MenuListViewController else {
            print("Cannot find VC with id MenuListViewController")
            return
        }
        menuListVC.itemsData = data
        self.navigationController?.pushViewController(menuListVC,
                                                      animated: true)
    }
    
    private func fetchPlainArray() -> [MenuItemModel] {
        var tempArray = [MenuItemModel]()
        tempArray.append(contentsOf: fetchSnacksArray())
        tempArray.append(contentsOf: fetchMainCourseArray())
        return tempArray
    }
    
    private func fetchMixedArray() -> [MenuItemModel] {
        let tempArray = createMixedArray(snacks: fetchSnacksArray(),
                                         mainCourse: fetchMainCourseArray())
        return tempArray
    }
    
    private func createMixedArray(snacks: [MenuItemModel], mainCourse: [MenuItemModel]) -> [MenuItemModel] {
        var mixedArray = [MenuItemModel]()
        for (index, item) in snacks.enumerated() {
            // Add snack to mixedArray
            mixedArray.append(item)
            
            // Add maincourse at same index to mixedArray
            if index < mainCourse.count {// This condition is added to avoid crash
                let mainCourseItemToAdd = mainCourse[index]
                mixedArray.append(mainCourseItemToAdd)
            }
        }
        return mixedArray
    }
}

