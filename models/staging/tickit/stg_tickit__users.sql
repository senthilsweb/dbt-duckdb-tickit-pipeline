with source as (

    select * from {{ source('sporting_event_sales_db', 'user') }}

),

renamed as (

    select
        userid as user_id,
        username,
        firstname as first_name,
        lastname as last_name,
        city,
        state,
        email,
        phone,
        likebroadway as like_broadway,
        likeclassical as like_classical,
        likeconcerts as like_concerts,
        likejazz as like_jazz,
        likemusicals as like_musicals,
        likeopera as like_opera,
        likerock as like_rock,
        likesports as like_sports,
        liketheatre as like_theatre,
        likevegas as like_vegas
    from
        source
    where
        userid IS NOT NULL
    order by
        userid

)

select * from renamed