//
//  ViewController.swift
//  Sqlite.Swift
//
//  Created by Kenvin on 16/7/24.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

import UIKit
import SQLite
class ViewController: UIViewController {

    var   sqdbManager:Connection!=nil
    var   users = Table("users")
    let   id    = Expression<Int64>("id")
    let   name  = Expression<String>("name")
    let   email = Expression<String>("email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
          sqdbManager = try Connection(NSHomeDirectory()+"/Documents/db.sqlite3")
            try sqdbManager.run(users.create{ t in
                t.column(id,primaryKey:true)
                t.column(name)
                t.column(email)
            })
            
           
        }catch{
            print(error)
        }
    }

    @IBAction func addDataAction(sender: AnyObject) {
     do{
        let insert = users.insert(name<-"StringX",email<-"?")
            try sqdbManager.run(insert)
        }catch{
            print(error)
        }
    }
    
    @IBAction func deleteDataAction(sender: AnyObject) {
       let stringX = users.filter(id==8)
        do{
          try  sqdbManager.run(stringX.delete())
        }catch{
            print(error)
        }
    }
    
 
    
    @IBAction func modifyDataAction(sender: AnyObject) {
        let strongX = users.filter(id == 8)
        do{
         try sqdbManager.run(strongX.update(name<-name.replace("StringX", with: "String")))
        }catch{
            print(error)
        }
        
    }
    
    @IBAction func queryDataAction(sender: AnyObject) {
        do{
            for user in try sqdbManager.prepare(users) {
                print("id:\(user[id]),name:\(user[name]),email:\(user[email])")
            }
            
        }catch{
            print(error)

        }
    }
}

