-- 2-1. Filter
select
	*
from
	flight
where
	departure_airport = 'LAG'
	and (arrival_airport = 'ORD'
		or arrival_airport = 'MDW')
	and scheduled_departure between '2023-05-27' and '2023-05-28';


-- 2-2. Project
select
	city,
	zip
from address;

select
	distinct city,
	zip
from
	address;

-- 2-3. Product
select
	d.airport_code as departure_airport,
	a.airport_code as arrival_airport
from
	airport a,
	airport d;
