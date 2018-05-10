connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: users {

  join: order_items {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id};;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: user_order_fact {
    type: inner
    sql_on: ${users.id} = ${user_order_fact.user_id} ;;
    relationship: one_to_one
  }

}
