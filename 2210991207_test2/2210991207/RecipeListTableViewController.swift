//
//  RecipeListTableViewController.swift
//  Smart Recipe Manager
//
//  Created by Agam on 23/11/24.
//

import UIKit

class RecipeListTableViewController: UITableViewController {
    
    var meals: Meal = Meal(
        breakfast: [
            Recipe(
                name: "Grilled Cheese Sandwich",
                   ingredients: "Bread, Cheese, Butter",
                   instructions: "Butter the bread, add cheese, and grill until golden brown.",
                   category: "Vegetarian",
                   nutritionInfo: "Calories: 350, Protein: 12g, Carbs: 30g",
                   thumbnail: "grilled_cheese_thumbnail"
            ),
            Recipe(
                name: "Quinoa Salad",
                    ingredients: "Quinoa, Cucumber, Cherry Tomatoes, Lemon Juice, Olive Oil",
                    instructions: "Cook quinoa, mix with chopped veggies, and drizzle with lemon juice and olive oil.",
                    category: "Vegan",
                    nutritionInfo: "Calories: 200, Protein: 6g, Carbs: 28g",
                    thumbnail: "quinoa_salad_thumbnail"
            )
        ],
        lunch: [
            Recipe(
                name: "Turkey Wrap",
                       ingredients: "Turkey, Tortilla, Lettuce, Cheese, Mayo",
                       instructions: "Place turkey and veggies on a tortilla, add cheese and mayo, then roll it up.",
                       category: "Non-Vegetarian",
                       nutritionInfo: "Calories: 320, Protein: 25g, Carbs: 20g",
                       thumbnail: "turkey_wrap_thumbnail"
            ),
            Recipe(
                name: "Chickpea Curry",
                        ingredients: "Chickpeas, Onion, Tomato, Coconut Milk, Spices",
                        instructions: "Cook chickpeas in a spiced coconut milk curry sauce.",
                        category: "Vegan",
                        nutritionInfo: "Calories: 300, Protein: 10g, Carbs: 35g",
                        thumbnail: "chickpea_curry_thumbnail"
            )
        ],
        dinner: [
            Recipe(
                name: "Chicken Alfredo Pasta",
                       ingredients: "Fettuccine, Chicken, Alfredo Sauce, Parmesan Cheese",
                       instructions: "Cook fettuccine, sauté chicken, and mix with Alfredo sauce.",
                       category: "Non-Vegetarian",
                       nutritionInfo: "Calories: 600, Protein: 35g, Carbs: 50g",
                       thumbnail: "chicken_alfredo_thumbnail"
            ),
            Recipe(
                name: "Stuffed Bell Peppers",
                        ingredients: "Bell Peppers, Quinoa, Black Beans, Corn, Spices",
                        instructions: "Stuff bell peppers with cooked quinoa and veggies, then bake.",
                        category: "Vegan",
                        nutritionInfo: "Calories: 250, Protein: 8g, Carbs: 35g",
                        thumbnail: "stuffed_peppers_thumbnail"

            )
        ],
        snacks: [
            Recipe(
                name: "Avocado Toast",
                        ingredients: "Bread, Avocado, Olive Oil, Salt, Pepper",
                        instructions: "Toast bread, mash avocado, and spread on top. Drizzle with olive oil and season.",
                        category: "Vegan",
                        nutritionInfo: "Calories: 250, Protein: 5g, Carbs: 30g",
                        thumbnail: "avocado_toast_thumbnail"

            ),
            Recipe(
                name: "Hummus and Veggie Sticks",
                       ingredients: "Hummus, Carrots, Cucumber, Bell Peppers",
                       instructions: "Slice veggies into sticks and serve with hummus.",
                       category: "Vegan",
                       nutritionInfo: "Calories: 150, Protein: 4g, Carbs: 18g",
                       thumbnail: "hummus_sticks_thumbnail"
            )
        ]
    )


    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return meals.breakfast.count
            case 1: return meals.lunch.count
            case 2: return meals.snacks.count
            case 3: return meals.dinner.count
            default: return 0
        }
    
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! RecipeListTableViewCell
        
        var recipe: Recipe
        
        switch indexPath.section {
            case 0: recipe = meals.breakfast[indexPath.row]
            case 1: recipe = meals.lunch[indexPath.row]
            case 2: recipe = meals.snacks[indexPath.row]
            case 3: recipe = meals.dinner[indexPath.row]
            default: recipe = Recipe(name: "", ingredients: "", instructions: "", category: "", nutritionInfo: "",thumbnail: "r1")
        }
        
        cell.update(using : recipe)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Breakfast"
        case 1: return "Lunch"
        case 2: return "Snacks"
        case 3: return "Dinner"
        default: return ""
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  segue.identifier == "editSegue" else { return }
        let destinationVC = segue.destination as? RecipeAddEditTableViewController
        
        let indexPath = tableView.indexPathForSelectedRow!
        var selectedRecipe: Recipe?
        switch indexPath.section {
        case 0:
            selectedRecipe = meals.breakfast[indexPath.row]
        case 1:
            selectedRecipe = meals.lunch[indexPath.row]
        case 2:
            selectedRecipe = meals.snacks[indexPath.row]
        case 3:
            selectedRecipe = meals.dinner[indexPath.row]
        default:
            break
        }
        destinationVC?.recipe = selectedRecipe
        
    }
    
    
    @IBAction func unwindSegue(segue : UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        if let sourceVC = segue.source as? RecipeAddEditTableViewController {
            if let recipe = sourceVC.recipe, let mealType = sourceVC.type {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        switch indexPath.section {
                        case 0: meals.breakfast[indexPath.row] = recipe
                        case 1: meals.lunch[indexPath.row] = recipe
                        case 2: meals.snacks[indexPath.row] = recipe
                        case 3: meals.dinner[indexPath.row] = recipe
                        default: break
                        }
                        tableView.reloadData()
                    }
                    else {
                        switch mealType {
                        case "breakfast":
                            meals.breakfast.append(recipe)
                            let newIndexPath = IndexPath(row: meals.breakfast.count - 1, section: 0)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "lunch":
                            meals.lunch.append(recipe)
                            let newIndexPath = IndexPath(row: meals.lunch.count - 1, section: 1)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "snacks":
                            meals.snacks.append(recipe)
                            let newIndexPath = IndexPath(row: meals.snacks.count - 1, section: 2)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        case "dinner":
                            meals.dinner.append(recipe)
                            let newIndexPath = IndexPath(row: meals.dinner.count - 1, section: 3)
                            tableView.insertRows(at: [newIndexPath], with: .automatic)
                            
                        default:
                            break
                        }
                    }
                }
            }
    }

}
