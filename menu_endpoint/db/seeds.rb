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

puts 'Menu Created'

# Create Section 1: Pizzas (Configurable)
pizza_section = Section.create!(
  identifier: 'classic_pizzas',
  label: 'Classic Pizzas',
  description: 'Our signature pizzas with the finest ingredients.',
  is_available: true
)

puts 'Section Created'

MenuSection.create!(menu: main_menu, section: pizza_section, display_order: 1)

# Create Items for Pizza Section
pizza_margherita = Item.create!(
  type: 'Product',
  identifier: 'margherita_pizza',
  label: 'Margherita Pizza',
  description: 'A classic pizza with fresh mozzarella, tomatoes, and basil.',
  price: 10.0,
  available_quantity: 10,
  image_url: 'https://kestepizzago.com/cdn/shop/files/Margherita_900x.png?v=1684443293'
)

pizza_pepperoni = Item.create!(
  type: 'Product',
  identifier: 'pepperoni_pizza',
  label: 'Pepperoni Pizza',
  description: 'A pizza topped with spicy pepperoni and mozzarella.',
  price: 12.0,
  available_quantity: 10,
  image_url: 'https://kestepizzago.com/cdn/shop/files/Diavola_900x.png?v=1684442849'
)

puts 'Pizza Items Created'

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

puts 'Modifier Groups Created'

# Link the modifiers to the item (for the configurable item)
ItemModifierGroup.create!(item: pizza_margherita, modifier_group: modifier_size)
ItemModifierGroup.create!(item: pizza_margherita, modifier_group: modifier_toppings)
ItemModifierGroup.create!(item: pizza_pepperoni, modifier_group: modifier_size)
ItemModifierGroup.create!(item: pizza_pepperoni, modifier_group: modifier_toppings)

# Create Modifiers for Size
size_small = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'small_size', label: 'Small (10")', price: 0),
  modifier_group: modifier_size,
  display_order: 1,
  default_quantity: 1,
  price_override: 0.0
)

size_medium = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'medium_size', label: 'Medium (12")', price: 0),
  modifier_group: modifier_size,
  display_order: 2,
  default_quantity: 1,
  price_override: 2.0
)

size_large = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'large_size', label: 'Large (15")', price: 0),
  modifier_group: modifier_size,
  display_order: 3,
  default_quantity: 1,
  price_override: 5.0
)

puts 'Size Modifiers Created'

# Create Modifiers for Extra Toppings
toppings_mushrooms = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'mushrooms', label: 'Mushrooms', price: 1.5),
  modifier_group: modifier_toppings,
  display_order: 1,
  default_quantity: 0,
  price_override: 1.5
)

toppings_cheese = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'extra_cheese', label: 'Extra Cheese', price: 2.0),
  modifier_group: modifier_toppings,
  display_order: 2,
  default_quantity: 0,
  price_override: 2.0
)

toppings_olives = Modifier.create!(
  item: Item.create!(type: 'Component', identifier: 'olives', label: 'Olives', price: 1.0),
  modifier_group: modifier_toppings,
  display_order: 3,
  default_quantity: 0,
  price_override: 1.0
)

puts 'Topping Modifiers Created'

# Create Section 2: Desserts (Non-configurable)
dessert_section = Section.create!(
  identifier: 'desserts',
  label: 'Desserts',
  description: 'Sweet treats to end your meal.',
  is_available: true
)

puts 'Dessert Section Created'

MenuSection.create!(menu: main_menu, section: dessert_section, display_order: 2)

# Create Items for Dessert Section (Non-configurable)
dessert_tiramisu = Item.create!(
  type: 'Product',
  identifier: 'tiramisu',
  label: 'Tiramisu',
  description: 'A classic Italian dessert with layers of coffee-soaked ladyfingers and mascarpone cheese.',
  price: 6.0,
  available_quantity: 10,
  image_url: 'https://kestepizzago.com/cdn/shop/files/Tiramisu02_900x.png?v=1684445048'
)

dessert_panna_cotta = Item.create!(
  type: 'Product',
  identifier: 'panna_cotta',
  label: 'Panna Cotta',
  description: 'A creamy vanilla custard topped with fresh berries.',
  price: 5.0,
  available_quantity: 10,
  image_url: 'https://img.freepik.com/premium-photo/food-photography-panna-cotta-glass-isolated-white-background_847439-3475.jpg'
)

puts 'Dessert Items Created'

# Add items to Dessert Section
SectionItem.create!(section: dessert_section, item: dessert_tiramisu, display_order: 1)
SectionItem.create!(section: dessert_section, item: dessert_panna_cotta, display_order: 2)

# Create Section 3A: Drinks (Non-alcoholic)
na_drinks_section = Section.create!(
  identifier: 'na_drinks',
  label: 'Non-Alcoholic Drinks',
  description: 'A refreshing accompaniment to your meal.',
  is_available: true
)

puts 'NA Drinks Section Created'

MenuSection.create!(menu: main_menu, section: na_drinks_section, display_order: 3)

# Create Items for Drinks Section (Non-configurable)
na_drink_coffee = Item.create!(
  type: 'Product',
  identifier: 'coffee',
  label: 'Coffee',
  description: 'Brewed with freshly roasted beans.',
  price: 4.0,
  available_quantity: 10,
  image_url: 'https://www.shutterstock.com/image-photo/cup-coffee-on-white-background-600nw-2502351597.jpg'
)

na_drink_matcha = Item.create!(
  type: 'Product',
  identifier: 'matcha_latte',
  label: 'Matcha Latte',
  description: 'Made with ceremonial grade matcha direct from Kyoto.',
  price: 6.0,
  available_quantity: 0,
  image_url: 'https://t4.ftcdn.net/jpg/06/49/44/19/360_F_649441929_JZGvp4GcO38ZX4QqtjrukttYrVJje5EO.jpg'
)

puts 'NA Drink Items Created'

# Add items to NA Drinks Section
SectionItem.create!(section: na_drinks_section, item: na_drink_coffee, display_order: 1)
SectionItem.create!(section: na_drinks_section, item: na_drink_matcha, display_order: 2)

# Create Section 3B: Drinks (Alcoholic)
alcoholic_drinks_section = Section.create!(
  identifier: 'alcoholic_drinks',
  label: 'Alcoholic Drinks',
  description: '18+ only',
  is_available: false
)

puts 'Alcoholic Drinks Section Created'

MenuSection.create!(menu: main_menu, section: alcoholic_drinks_section, display_order: 4)

# Create Items for Drinks Section (Non-configurable)
alcoholic_drink_beer = Item.create!(
  type: 'Product',
  identifier: 'beer',
  label: 'Beer',
  description: 'Locally brewed tropical lager',
  price: 6.0,
  available_quantity: 10,
  image_url: 'https://hips.hearstapps.com/del.h-cdn.co/assets/cm/15/11/3200x3272/54f65d39ab05d_-_183341797.jpg?resize=640:*'
)

puts 'Alcoholic Drink Item Created'

# Add items to Alcoholic Drinks Section
SectionItem.create!(section: alcoholic_drinks_section, item: alcoholic_drink_beer, display_order: 1)

puts 'Seed data has been successfully created!'
