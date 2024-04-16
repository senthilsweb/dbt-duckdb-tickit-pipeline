with source as (

    select * from {{ source('sporting_event_sales_db', 'venue') }}

),

renamed as (

    select
        venueid as venue_id,
        venuename as venue_name,
        venuecity as venue_city,
        venuestate as venue_state,
        venueseats as venue_seats
    from
        source
    where
        venueid IS NOT NULL
    order by
        venueid
)

select * from renamed