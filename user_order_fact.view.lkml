view: user_order_fact {
  derived_table: {
    sql:
      SELECT
        u.id as user_id,
        count(*) as lifetime_order_items,
        sum(sale_price) as lifetime_value,
        min(oi.created_at) as first_order,
        max(oi.created_at) as last_order
      FROM public.USERS u
      LEFT JOIN public.order_items oi
      on u.id = oi.user_id
      group by 1
       ;;
  }

  measure: count {
    type: count
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_order_items {
    type: number
    sql: ${TABLE}.lifetime_order_items ;;
  }

  dimension: lifetime_value {
    type: number
    sql: ${TABLE}.lifetime_value ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.last_order ;;
  }

}
