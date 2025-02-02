# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ['Action', 'Comedy', 'Drama', 'Horror'].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data to avoid duplicates
ItemModifierGroup.destroy_all
Modifier.destroy_all
ModifierGroup.destroy_all
SectionItem.destroy_all
Item.destroy_all
MenuSection.destroy_all
Section.destroy_all
Menu.destroy_all

# Create a Menu
main_menu = Menu.create!(
  identifier: 'main_menu',
  label: 'Menù di Mamma Mia Trattoria',
  state: 'active',
  start_date: Date.today,
  end_date: Date.today + 1.year
)

# Create Section 1: Pizzas (Configurable)
pizza_section = Section.create!(
  identifier: 'classic_pizzas',
  label: 'Classic Pizzas',
  description: 'Our signature pizzas with the finest ingredients.'
)

MenuSection.create!(menu: main_menu, section: pizza_section, display_order: 1)

# Create Items for Pizza Section
pizza_margherita = Item.create!(
  type: 'Product',
  identifier: 'margherita_pizza',
  label: 'Margherita Pizza',
  description: 'A classic pizza with fresh mozzarella, tomatoes, and basil.',
  price: 10.0
)

pizza_pepperoni = Item.create!(
  type: 'Product',
  identifier: 'pepperoni_pizza',
  label: 'Pepperoni Pizza',
  description: 'A pizza topped with spicy pepperoni and mozzarella.',
  price: 12.0
)

SectionItem.create!(section: pizza_section, item: pizza_margherita, display_order: 1)
SectionItem.create!(section: pizza_section, item: pizza_pepperoni, display_order: 2)

# Create Modifier Groups
modifier_size = ModifierGroup.create!(
  identifier: 'size',
  label: 'Pizza Size',
  selection_required_min: 1,
  selection_required_max: 1
)

modifier_toppings = ModifierGroup.create!(
  identifier: 'extra_toppings',
  label: 'Extra Toppings',
  selection_required_min: 0,
  selection_required_max: 3
)

# Link the modifiers to the item (for the configurable item)
ItemModifierGroup.create!(item: pizza_margherita, modifier_group: modifier_size)
ItemModifierGroup.create!(item: pizza_margherita, modifier_group: modifier_toppings)
ItemModifierGroup.create!(item: pizza_pepperoni, modifier_group: modifier_size)
ItemModifierGroup.create!(item: pizza_pepperoni, modifier_group: modifier_toppings)

# Create Modifiers for Size
size_small = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'small_size', label: 'Small (10")'),
  modifier_group: modifier_size,
  display_order: 1,
  default_quantity: 1,
  price_override: 0.0
)

size_medium = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'medium_size', label: 'Medium (12")'),
  modifier_group: modifier_size,
  display_order: 2,
  default_quantity: 1,
  price_override: 2.0
)

size_large = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'large_size', label: 'Large (15")'),
  modifier_group: modifier_size,
  display_order: 3,
  default_quantity: 1,
  price_override: 5.0
)

# Create Modifiers for Extra Toppings
toppings_mushrooms = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'mushrooms', label: 'Mushrooms'),
  modifier_group: modifier_toppings,
  display_order: 1,
  default_quantity: 0,
  price_override: 1.5
)

toppings_cheese = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'extra_cheese', label: 'Extra Cheese'),
  modifier_group: modifier_toppings,
  display_order: 2,
  default_quantity: 0,
  price_override: 2.0
)

toppings_olives = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'olives', label: 'Olives'),
  modifier_group: modifier_toppings,
  display_order: 3,
  default_quantity: 0,
  price_override: 1.0
)

# Create Section 2: Desserts (Non-configurable)
dessert_section = Section.create!(
  identifier: 'desserts',
  label: 'Desserts',
  description: 'Sweet treats to end your meal.'
)

MenuSection.create!(menu: main_menu, section: dessert_section, display_order: 2)

# Create Items for Section 1 (Non-configurable)
dessert_tiramisu = Item.create!(
  type: 'Product',
  identifier: 'tiramisu',
  label: 'Tiramisu',
  description: 'A classic Italian dessert with layers of coffee-soaked ladyfingers and mascarpone cheese.',
  price: 6.0
)

dessert_panna_cotta = Item.create!(
  type: 'Product',
  identifier: 'panna_cotta',
  label: 'Panna Cotta',
  description: 'A creamy vanilla custard topped with fresh berries.',
  price: 5.0
)

# Add items to Section 1
SectionItem.create!(section: dessert_section, item: dessert_tiramisu, display_order: 1)
SectionItem.create!(section: dessert_section, item: dessert_panna_cotta, display_order: 2)

puts 'Seed data has been successfully created!'
