//
//  ViewController.swift
//  lesson 5 (month 3)
//
//  Created by Керемет  on 1/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var goods: [TableView] = [
        TableView(name: "brown sweater", price: 560 , profileImage: UIImage(named: "photo1")!),
        TableView(name: "suit skirt", price: 960, profileImage: UIImage(named: "photo2")!),
        TableView(name: "sports jacket", price: 1250, profileImage: UIImage(named: "photo3")!),
        TableView(name: "winter sweater ", price: 3569,profileImage: UIImage(named: "photo4")!),
        TableView(name: "suit pants ", price: 4000,profileImage: UIImage(named:"photo5")!),
        TableView(name: "sports jacket ", price: 1250,profileImage: UIImage(named: "photo6")!),
        TableView(name: "fall coat ", price: 5000,profileImage: UIImage(named: "photo7")!),
        TableView(name: "green coat ", price: 3999 ,profileImage:UIImage(named:"photo8")!),
        TableView(name: "white jacket ", price: 999 ,profileImage: UIImage(named:"photo9")!),
        TableView(name: "jacket NIKE ", price: 1250 ,profileImage: UIImage(named:"photo10")!)
         
    
       ]
   
    
    
    
    
    
    
    
    
    
    
    var  floatingButton = UIButton()
    
    
    var cartProducts = [TableView]()
    var filteredProducts = [TableView]()
    var totalSum = 0
    var basketButton = UIButton()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let layout = UICollectionViewFlowLayout()
        imageCollectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
        
        floatingButton.setTitle("Busket", for: .normal)
        floatingButton.backgroundColor = UIColor.lightGray
        
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        floatingButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        floatingButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
    }


}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_cell", for: indexPath) as! ImageCell
     
        cell.imageView.image = UIImage(named: goods[indexPath.row].profileImage)
        cell.NameLabel.text = goods[indexPath.row].name
        //cell.priceLabel.text = goods[indexPath.row].price
                
  
        
        
        
        cell.backgroundColor = .lightGray
        return cell    }
}



extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: view.frame.width / 2)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Количество товара", message: "Введите количество товара", preferredStyle: .alert)
        
        var textField = UITextField()
        
        alertController.addTextField { text in
            textField = text
        }
        
        
        
        let actionOk = UIAlertAction(title: "Ok", style: .cancel) { [self] action in
            //print(self.filteredNames[indexPath.row])
            
            let inputText = textField.text!
            
            if let amount = Int(inputText) {
                var counter = 0
                
                while counter < amount {
                    self.cartProducts.append(self.filteredProducts[indexPath.row])
                    
                    counter += 1
                }
                
                self.totalSum += amount
                
                self.basketButton.setTitle("Корзина \(totalSum) шт", for: .normal)
}


}
        
        
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive) { action in
            ()
        }
        
        alertController.addAction(actionOk)
        alertController.addAction(actionCancel)
        
        present(alertController, animated: true, completion: nil)

    }
 

}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredProducts = []
        
        if searchText == "" {
            filteredProducts = goods
        }
        
        for product in goods {
            if product.name.uppercased().contains(searchText.uppercased()) {
                filteredProducts.append(product)
            }
        }
        
        imageCollectionView.reloadData()
    }
}


class SecondViewController: UIViewController {
    
    var cartTableView = UITableView()
    var totalLabel = UILabel()
    
    var cartProducts = [TableView]()
    
    override func viewDidLoad() {
        
        
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cartTableView.register(UITableViewCell.self, forCellReuseIdentifier: "product_cell")
        view.addSubview(cartTableView)
        
        cartTableView.translatesAutoresizingMaskIntoConstraints = false
        cartTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        cartTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        cartTableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        cartTableView.heightAnchor.constraint(equalToConstant: view.frame.height - 100).isActive = true
        

        
        
        cartTableView.dataSource = self
        
        view.addSubview(totalLabel)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        totalLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        totalLabel.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        totalLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        totalLabel.font = .systemFont(ofSize: 20)
        var totalSum = 0
        
        for cartProduct in cartProducts {
            totalSum += cartProduct.price
        }
        totalLabel.text = "Количество товара: \(cartProducts.count) | Сумма: \(totalSum) $"
    }
    }


extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "product_cell")
        
        cell.imageView?.image = cartProducts[indexPath.row].profileImage
        
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 0).isActive = true
        cell.imageView?.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true
        cell.imageView?.widthAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
        cell.imageView?.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
        
        cell.textLabel?.text = "\(cartProducts[indexPath.row].name) \(cartProducts[indexPath.row].price)"
        
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        cell.textLabel?.leftAnchor.constraint(equalTo: cell.imageView!.rightAnchor, constant: 0).isActive = true
        cell.textLabel?.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        cell.textLabel?.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true
        cell.textLabel?.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
        
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}




