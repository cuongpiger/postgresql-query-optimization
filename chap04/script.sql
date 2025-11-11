-- 4-1. A query selecting the number of passengers on specific flights
SELECT
    f.flight_no,
    f.actual_departure,
    count(passenger_id) passengers
FROM
    flight f
    JOIN booking_leg bl ON bl.flight_id = f.flight_id
    JOIN passenger p ON p.booking_id = bl.booking_id
WHERE
    f.departure_airport = 'JFK'
    AND f.arrival_airport = 'ORD'
    AND f.actual_departure BETWEEN '2023-08-10' and '2023-08-13'
GROUP BY
    f.flight_id,
    f.actual_departure;
