-- 1-1. A query selecting flights with the comparison operators
select
	flight_id
      ,
	departure_airport
      ,
	arrival_airport
from
	flight
where
	scheduled_arrival >= '2023-10-14'
	and scheduled_arrival <'2023-10-15';


-- 1-2. A query selecting flights by casting to date
select
	flight_id
     ,
	departure_airport
,
	arrival_airport
from
	flight
where
	scheduled_arrival ::date = '2023-10-14';


-- 1-3. Imperatively constructed query
with bk as (
with level4 as (
select
	*
from
	account
where
	frequent_flyer_id in (
	select
		frequent_flyer_id
	from
		frequent_flyer
	where
		level = 4
                               )
                 )
select
	*
from
	booking
where
	account_id in
              (
	select
		account_id
	from
		level4
              )
           )
select
	*
from
	bk
where
	bk.booking_id in
   (
	select
		booking_id
	from
		booking_leg
	where
		leg_num = 1
		and is_returning is false
		and flight_id in (
		select
			flight_id
		from
			flight
		where
			departure_airport in ('ORD', 'MDW')
				and scheduled_departure:: DATE = '2023-07-04')
      );


-- 1-4. Calculating a total number of passengers
with bk_chi as (
   with bk as (
      with level4 as (
select
	*
from
	account
where
	frequent_flyer_id in (
	select
		frequent_flyer_id
	from
		frequent_flyer
	where
		level = 4
)
                    )
select
	*
from
	booking
where
	account_id in
                 (
	select
		account_id
	from
		level4
                 )
              )
select
	*
from
	bk
where
	bk.booking_id in
         (
	select
		booking_id
	from
		booking_leg
	where
		leg_num = 1
		and is_returning is false
		and flight_id in (
		select
			flight_id
		from
			flight
		where
			departure_airport in ('ORD', 'MDW')
				and scheduled_departure:: DATE = '2023-07-04')
           )
          )
select
	count(*)
from
	passenger
where
	booking_id in (
	select
		booking_id
	from
		bk_chi);


-- 1-5. Declarative query to calculate the number of passengers
select
	count(*)
from
	booking bk
join booking_leg bl on
	bk.booking_id = bl.booking_id
join flight f on
	f.flight_id = bl.flight_id
join account a on
	a.account_id = bk.account_id
join frequent_flyer ff on
	ff.frequent_flyer_id = a.frequent_flyer_id
join passenger ps on
	ps.booking_id = bk.booking_id
where
	level = 4
	and leg_num = 1
	and is_returning is false
	and departure_airport in ('ORD', 'MDW')
	and scheduled_departure >= '2023-07-04'
	and scheduled_departure <'2023-07-05';

      