with source as (

    select * from {{ source('sporting_event_sales_db', 'listing') }}

),

renamed as (

    select
        listid as list_id,
        sellerid as seller_id,
        eventid as event_id,
        dateid as date_id,
        numtickets as num_tickets,
        priceperticket as price_per_ticket,
        totalprice as total_price,
        listtime as list_time

    from
        source
    where
        listid IS NOT NULL
    order by
        listid

)

select *  from renamed
