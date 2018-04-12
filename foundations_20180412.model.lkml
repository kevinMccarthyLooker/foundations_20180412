include: "*.view" # include all the views


datagroup: training_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

#add a note


## Model Level Settings ##
label: "1) Foundations Training"

connection: "events_ecommerce"

persist_with: training_default_datagroup
## ^^^^^^^^^^^^^^^^^^^^ ##


## Explore Definitions ##
explore: users {}


explore: order_items {
  #To Do: Add distribution_centers join to this explore
  description: "Information about orders including user information"

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

}
