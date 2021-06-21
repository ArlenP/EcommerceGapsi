//
//  ViewController.swift
//  EcommerceGapsi
//
//  Created by Arlen Peña on 21/06/21.
//

import UIKit
import CoreData

class ViewController: BaseViewController{
   
    var products : [ProductDetail] = []
    var itemsInicio : [ProductDetail] = []
    var listHistory : [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        
        searchBar.delegate = self
        searchBar.setShowsCancelButton(false, animated: false)
        
        
        readData(inicio: true)
    }

    
    func readData(inicio : Bool = false){
        let data = self.getDataFromREST()
        do{
            let str = try data.get()
            let json = try JSONDecoder().decode(Product.self, from: Data(str!.utf8))
            if let productos = json.productDetails {
                self.products = productos
                if inicio {
                    self.itemsInicio = productos
                }
                self.tableView.reloadData()
            }
        }catch{
            print(error)
        }
    }
    
    func clearData(){
        self.products  = self.itemsInicio
        //self.readData()
        tableView.reloadData()
    }
    
    func search(searchBar : UISearchBar, texto : String){
        if let param = searchBar.text {
            path = "\(Constants.URL_RESOURCES_APP2)&query=\(param)&page=1"
            self.products = []
            readData()
        }
       
        //&query=nintendo&page=1
        if let texto = searchBar.text {
            createData(historyText: texto)
        }
        self.historyTableView.isHidden = true
        self.searchBar.endEditing(true)
//        self.clearData()
//        self.readData()
//        var newData:[ProductDetail] = []
//        if(!searchBar.text!.isEmpty){
//            self.products.forEach { (producto) in
//
//            if((producto.title!.range(of:texto)) != nil){
//                newData.append(producto)
//            }
//
//        }
//            self.products = []
//            self.products = newData
//            self.tableView.reloadData()
//        }
    }
    
    
}





extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === historyTableView {
            return self.listHistory.count
        } else {
            return self.products.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === historyTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell",  for: indexPath)
            cell.textLabel?.text = self.listHistory[indexPath.row]
            return cell
            
        }else {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellList",  for: indexPath) as! TableViewCellProducts
            
            if let titulo = self.products[indexPath.row].title{
                cell.lblProduct.text = titulo
            }
        
            if let desc = self.products[indexPath.row].description{
                cell.lblPrice.text = desc
            }
            if let img = self.products[indexPath.row].imageUrl{
                cell.ImgProducts.downloaded(from: img, contentMode: .scaleAspectFill)
            }
            return cell
            
        }
       
    }
    

    
    
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView === historyTableView {
            print(self.listHistory[indexPath.row])
            searchBar.text = self.listHistory[indexPath.row]
            search(searchBar: self.searchBar, texto: self.listHistory[indexPath.row])
            
            
            searchBar.setShowsCancelButton(false, animated: true)
            //searchBar.text = ""
            searchBar.endEditing(true)
            self.tableView.scrollsToTop = true
            self.historyTableView.isHidden = true
            
        }
        
    }
    
}
extension ViewController : UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        retrieveData()
        self.historyTableView.isHidden = false
        self.historyTableView.reloadData()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        //searchBar.text = ""
        searchBar.endEditing(true)
        self.clearData()
        self.tableView.scrollsToTop = true
        self.historyTableView.isHidden = true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //self.search(searchBar: searchBar, texto: searchText)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search(searchBar: searchBar, texto: searchBar.text!)
    }
    
}




extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}


//CoreData
extension ViewController{
    func createData(historyText : String){
            // 1.- Refer to persistentContainer from appdelegate
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            // 2.- Create the context from persistentContainer
            let manageContext = appDelegate.persistentContainer.viewContext
            
            // 3.- Create an entity with
            let historyEntity = NSEntityDescription.entity(forEntityName: "Historia", in: manageContext)!
            
            // 4.- Create new record with User entity

                let history = NSManagedObject(entity: historyEntity, insertInto: manageContext)
                history.setValue(historyText, forKey: "texto")
          
            // 5.- Save context
            do{
                try manageContext.save()
                print("saved correctly")
            }catch{
                print("Error: \(error)")
            }
        }
    func retrieveData(){
        
           // 1.- Refer to persistentContainer from appdelegate
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           
           // 2.- Create the context from persistentContainer
           let manageContext = appDelegate.persistentContainer.viewContext
           
           // 3.- Prepare the request of type NSFetchRequest for the entity
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Historia")
           
           do{
               //4.- Fetch the result from context
               let result = try manageContext.fetch(fetchRequest)
               
               //5.- Iterate through an array to get value for the specific key
            self.listHistory = []
               for data in result as! [NSManagedObject] {
                   print(data.value(forKey: "texto") as! String)
                listHistory.append(data.value(forKey: "texto") as! String)
               }
               
           }catch{
               print("Error")
           }
           
       }


}




