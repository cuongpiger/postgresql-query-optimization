-- 3-2. A range filtering query executed with a full table scan
explain
select
    flight_no,
    departure_airport,
    arrival_airport
from
    flight
where
    scheduled_departure between '2023-05-15' and '2023-08-31';

-- 3-3. Range filtering with index-based table access
