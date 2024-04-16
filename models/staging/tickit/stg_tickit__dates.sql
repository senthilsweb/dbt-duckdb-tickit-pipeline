with source as (

    select * from {{ source('sporting_event_sales_db', 'date') }}

),

renamed as (

    select
        dateid as date_id,
        caldate as cal_date,
        day,
        month,
        year,
        week,
        qtr,
        holiday
    from
        source
    where
        dateid IS NOT NULL
    order by
        dateid

)

select * from renamed