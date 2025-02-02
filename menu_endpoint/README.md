# README

This project is a Ruby on Rails application implementing a GraphQL API for managing restaurant menus. The API allows querying and manipulating menus, sections, items, modifier groups, and modifiers based on the provided ERD.

The project's endpoint can be accessed via [et-menu-endpoint.onrender.com/graphql](https://et-menu-endpoint.onrender.com/graphql) for live interaction.

## Setup Instructions

### Step 1: Clone the Repository
```bash
git clone https://github.com/emileateo/grain-assessment-2025
cd grain-assessment-2025
```

### Step 2: Install Dependencies
```bash
bundle install
```

### Step 3: Configure the Database
1. Ensure PostgreSQL is running on your machine.

2. Create and migrate the database:
    ```bash
    rails db:create
    rails db:migrate
    ```

3. Seed the database with sample data:
    ```bash
    rails db:seed
    ```

### Step 4: Start the Server
```bash
rails server
```

Visit http://localhost:3000/graphiql to access the GraphQL playground locally.


## Seed Data
The application includes preloaded data representing a restaurant menu, organized into sections, items, and modifiers. The seed data demonstrates both configurable and non-configurable menu items.

### Seed Data Details

1. **Menu:**
   - We have an `active` menu for `Menù di Mamma Mia Trattoria`.

2. **Sections:**  
   - **Classic Pizzas:** Includes configurable pizza items.  
   - **Desserts:** Includes non-configurable dessert items.  

3. **Items:**  
   - **Classic Pizzas (Configurable):**  
     - Margherita Pizza ($10.00)  
     - Pepperoni Pizza ($12.00)  
   - **Desserts (Non-configurable):**  
     - Tiramisu ($6.00)  
     - Panna Cotta ($5.00)  

4. **Modifier Groups:**  
   - **Pizza Size (Required):**  
     - Small (10")  
     - Medium (12") (+$2.00)  
     - Large (15") (+$5.00)  
   - **Extra Toppings (Optional):**  
     - Mushrooms (+$1.50)  
     - Extra Cheese (+$2.00)  
     - Olives (+$1.00)
  

This data can be modified in `db/seeds.rb`.

## GraphQL Examples

### Query: Retrieve a Menu

This query retrieves all details about a menu, including its sections, items, and modifiers.

```graphql
query MainMenuQuery {
   menu(id:1) {
      identifier
      label
      state
      startDate
      endDate
      sections {
         identifier
         label
         description
         items {
            type
            identifier
            label
            description
            modifierGroups {
               identifier
               modifiers {
                  item {
                     type
                     identifier
                     label
                  }
                  priceOverride
               }
            }
         }
      }
   }
}
```

Response example:
```json
{
  "data": {
    "menu": {
      "identifier": "main_menu",
      "label": "Menù di Mamma Mia Trattoria",
      "state": "active",
      "startDate": "2025-01-28",
      "endDate": "2026-01-28",
      "sections": [
        {
          "identifier": "classic_pizzas",
          "label": "Classic Pizzas",
          "description": "Our signature pizzas with the finest ingredients.",
          "items": [
            {
              "type": "Product",
              "identifier": "margherita_pizza",
              "label": "Margherita Pizza",
              "description": "A classic pizza with fresh mozzarella, tomatoes, and basil.",
              "modifierGroups": [
                {
                  "identifier": "extra_toppings",
                  "modifiers": [
                    {
                      "item": {
                        "type": "Component",
                        "identifier": "mushrooms",
                        "label": "Mushrooms"
                      },
                      "priceOverride": 1.5
                    },
                    {
                      "item": {
                        "type": "Component",
                        "identifier": "extra_cheese",
                        "label": "Extra Cheese"
                      },
                      "priceOverride": 2
                    }
                  ]
                }
              ]
            }
          ]
        },
        {
          "identifier": "desserts",
          "label": "Desserts",
          "description": "Sweet treats to end your meal.",
          "items": [
            {
              "type": "Product",
              "identifier": "tiramisu",
              "label": "Tiramisu",
              "description": "A classic Italian dessert with layers of coffee-soaked ladyfingers and mascarpone cheese.",
              "modifierGroups": []
            },
            {
              "type": "Product",
              "identifier": "panna_cotta",
              "label": "Panna Cotta",
              "description": "A creamy vanilla custard topped with fresh berries.",
              "modifierGroups": []
            }
          ]
        }
      ]
    }
  }
}
```
### Mutation: Create a new Section under a new Menu

This mutation demonstrates how to create a new `Menu`, a `Section`, and link the `Section` to the `Menu`.

**Step 1: Create a Menu**
Use this mutation to create a new menu.

```graphql
mutation CreateMenu {
   createMenu(input: {
      identifier: "drinks",
      label: "Drinks",
      state: "active",
      startDate: "2025-01-01",
      endDate: "2025-12-31"
   }) {
      id
      identifier
      label
      state
      startDate
      endDate
   }
}
```

Response example:
```json
{
   "data": {
      "createMenu": {
         "id": "2",
         "identifier": "drinks",
         "label": "Drinks",
         "state": "active",
         "startDate": "2025-01-01",
         "endDate": "2025-12-31"
      }
   }
}
```

**Step 2: Create a Section**
Use this mutation to create a new section.

```graphql
mutation CreateSection {
   createSection(input: {
      identifier: "juices",
      label: "Juices",
      description: "Freshly squeezed upon order"
   }) {
      id
      identifier
      label
      description
   }
}
```

Response example:
```json
{
   "data": {
      "createSection": {
         "id": "3",
         "identifier": "juices",
         "label": "Juices",
         "description": "Freshly squeezed upon order"
      }
   }
}
```

**Step 3: Link the Section to the Menu**
Using the IDs of the `Menu` and `Section` that were just created, use this mutation to link the `Section` to the `Menu` by creating a `MenuSection`.

```graphql
mutation CreateMenuSection {
  createMenuSection(input: {
    menuId: 2,
    sectionId: 3,
    displayOrder: 1
  }) {
      id
      menu {
        identifier
      }
      section {
        identifier
      }
      displayOrder
  }
}
```

Response example:
```json
{
  "data": {
    "createMenuSection": {
      "id": "3",
      "menu": {
        "identifier": "drinks"
      },
      "section": {
        "identifier": "juices"
      },
      "displayOrder": 1
    }
  }
}
```

### Mutation: Update a Section's Details

This mutation updates the details of an existing section (e.g., label or description).

Example mutation:
```graphql
mutation UpdateSection {
  updateSection(
    input: {
      id: 1
      description: "Updated description for our signature pizzas."
    }
  ) {
    id
    identifier
    label
    description
  }
}
```

Response example:
```json
{
  "data": {
    "updateSection": {
      "id": "1",
      "identifier": "classic_pizzas",
      "label": "Classic Pizzas",
      "description": "Updated description for our signature pizzas."
    }
  }
}
```

### Mutation: Delete a Section

This mutation deletes a section from the database.

Example mutation:
```graphql
mutation DeleteSection {
   deleteSection(input: { id: 11 }) {
      id
   }
}
```

Response example:
```json
{
   "data": {
      "deleteSection": {
         "id": "11"
      }
   }
}
```

## Potential Metrics to Track

To ensure the application performs optimally, we can track key metrics from several perspectives.

Understanding these metrics will allow us to monitor system health and detect anomalies early, as well as identify areas for improvement, helping us maintain a high level of performance and reliability.

### Request Rates
Tracking the number of requests the application receives within a specific time period helps us predict and prepare for fluctuations in user demand. This allows us to scale resources accordingly to handle higher loads when necessary.

Additionally, identifying anomalies in traffic could help us detect critical issues or malicious activity.

### Throughput
Beyond tracking request rates/volume, it is also important to understand the amount of successful transactions our application can process within a specific time period.

This helps us understand the system's performance under varying load conditions and identify potential technical bottlenecks.

### Response Times
The time taken to complete or send a response to a request is another important metric to measure, and depends on factors such as:

- The amount of available resources
- Network latency
- Performance of database queries

Tracking response times allows us to determine whether we meet user expectations for speed and responsiveness.

### Errors
Errors (e.g. across application transactions or database queries) inform us when the system is not behaving as expected. Often, these are issues that require immediate attention.

Monitoring error rates helps us detect problems early and prioritise fixes, which in turn improves the user experience and reliability of the application. 

### Business Metrics
Beyond performance, understanding how users interact with the application from a business perspective is crucial. Key business-related metrics include:

- **Transaction frequency**
    
    Tracking the frequency of various transactions helps us optimise the performance of the application to suit users' needs. For example, frequently used queries can be optimised for speed and efficiency. while seldom-used fields may be considered for deprecation, simplifying the schema and reducing unnecessary complexity.

- **Conversion Rates & User Journeys**
    
    Tracking how many users complete key actions (e.g., placing an order, modifying a menu) helps assess business impact. Knowing that certain user journeys lead to more orders placed, for example, could influence marketing strategies or feature development.
