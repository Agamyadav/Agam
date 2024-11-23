//
//  RecipeAddEditTableViewController.swift
//  Smart Recipe Manager
//
//  Created by Agam on 23/11/24.
//

import UIKit

class RecipeAddEditTableViewController: UITableViewController {
    
    var recipe: Recipe?
    
    var type : String?

    @IBOutlet weak var meal: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var ingredients: UITextField!
    
    @IBOutlet weak var instructions: UITextField!
    
    @IBOutlet weak var category: UITextField!
    
    @IBOutlet weak var nutritionalInfo: UITextField!
    
    @IBOutlet weak var thumbnailImage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recipe = recipe {
            name.text = recipe.name
            ingredients.text = recipe.ingredients
            instructions.text = recipe.instructions
            category.text = recipe.category
            nutritionalInfo.text = recipe.nutritionInfo
            thumbnailImage.text = recipe.thumbnail
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        
        type = self.meal.text ?? ""
        let name = self.name.text ?? ""
        let ingredients = self.ingredients.text ?? ""
        let instructions = self.instructions.text ?? ""
        let category = self.category.text ?? ""
        let nutritionalInfo = self.nutritionalInfo.text ?? ""
        let thumnailImage = self.thumbnailImage.text ?? ""
    
        
        
        recipe = Recipe(name: name, ingredients: ingredients, instructions: instructions, category: category, nutritionInfo: nutritionalInfo, thumbnail: thumnailImage)
    }

    

}
