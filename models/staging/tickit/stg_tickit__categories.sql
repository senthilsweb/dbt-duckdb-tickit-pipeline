with source as (

    select * from {{ source('sporting_event_sales_db', 'category') }}

),

renamed as (

    select
        catid as cat_id,
        catgroup as cat_group,
        catname as cat_name,
        catdesc as cat_desc
    from
        source
    where
        catid IS NOT NULL
    order by
        catid

)

select * from renamed