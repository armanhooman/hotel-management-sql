USE hotel_management;
-- Question 1:
-- Which hotel has the highest total reservation value?

SELECT h.hotel_name , SUM(re.total_price) AS total_reservation_value
FROM hotels h
JOIN rooms r    
    USING(hotel_id)
JOIN reservations re 
    USING(room_id)
WHERE re.status <> 'Cancelled'
GROUP BY h.hotel_name 
ORDER BY total_reservation_value DESC;


--  Question 2 
-- Which room type is booked most frequently?

SELECT  
    rt.type_name ,
      COUNT(*) AS number_booked
FROM reservations r
JOIN rooms ro 
    USING(room_id)
JOIN room_types rt 
    USING(room_type_id)
WHERE r.status <> 'Cancelled'
GROUP BY rt.type_name
ORDER BY number_booked DESC;


-- Question 3
-- Which guests have made more than one reservation?

SELECT 
    g.first_name,
    g.last_name,
    COUNT(*) AS number_reserved
FROM reservations r 
JOIN guests g   
    USING(guest_id)
GROUP BY g.guest_id, g.first_name, g.last_name
HAVING COUNT(*) > 1 ;


-- Question 4 
-- What percentage of all reservations were cancelled?

SELECT 
    (
        SELECT COUNT(*)
        FROM reservations
        WHERE status = 'Cancelled'
    ) * 100.0
    /
    (
        SELECT COUNT(*)
        FROM reservations
    ) AS cancelled_percentage;


-- Question 5
-- Which reservations are unpaid or only partially paid?

SELECT 
    r.reservation_id,
    r.total_price,
    COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'Paid' THEN p.amount
            WHEN p.payment_status = 'Refunded' THEN -p.amount
            ELSE 0
        END
    ), 0) AS paid_amount,

    r.total_price - COALESCE(SUM(
        CASE
            WHEN p.payment_status = 'Paid' THEN p.amount
            WHEN p.payment_status = 'Refunded' THEN -p.amount
            ELSE 0
        END
    ), 0) AS remaining

FROM reservations r
LEFT JOIN payments p
    USING (reservation_id)
GROUP BY r.reservation_id, r.total_price
HAVING remaining > 0;


-- Question 6 
-- Which hotel has the highest average room price?

SELECT
    h.hotel_name,
    TRUNCATE(AVG(price_per_night) , 2) AS average_price_room
FROM hotels h 
INNER JOIN rooms r 
    USING(hotel_id)
GROUP BY h.hotel_id, h.hotel_name
ORDER BY average_price_room DESC;

-- Question 7
-- Which hotel has the highest number of completed reservations?

SELECT
    h.hotel_name,
    COUNT(*) AS completed_reservation
FROM hotels h
INNER JOIN rooms r 
    USING(hotel_id)
INNER JOIN reservations re 
    USING(room_id)
WHERE re.status = 'Completed'
GROUP BY h.hotel_id, h.hotel_name
ORDER BY completed_reservation DESC;

-- Question 8
-- Which guests have spent more than the average guest spending?

SELECT 
    g.first_name,
    g.last_name,
    g.nationality,
    SUM(p.amount) AS total_spent
FROM guests g 
JOIN reservations r     
    USING(guest_id)
JOIN payments p 
    USING(reservation_id)
WHERE p.payment_status = 'Paid'
GROUP BY g.guest_id , g.first_name, g.last_name, g.nationality
HAVING SUM(p.amount) > (
 SELECT AVG(guest_total)
    FROM (
        SELECT SUM(p2.amount) AS guest_total
        FROM reservations r2
        JOIN payments p2
            USING (reservation_id)
        WHERE p2.payment_status = 'Paid'
        GROUP BY r2.guest_id
    ) AS guest_spending
);

-- Question 9
-- Which room generated the highest total revenue?

SELECT 
    h.hotel_name, 
    r.room_id,
    r.room_number, 
    rt.type_name AS room_type,
    SUM(p.amount) AS total_revenue
FROM rooms r 
JOIN reservations re 
    USING (room_id)
JOIN payments p 
    USING (reservation_id)
JOIN room_types rt 
    USING (room_type_id)
JOIN hotels h
    USING (hotel_id)
WHERE re.status <> 'Cancelled'
  AND p.payment_status = 'Paid'
GROUP BY 
    h.hotel_name,
    r.room_id,
    r.room_number,
    rt.type_name
ORDER BY total_revenue DESC;


-- Question 10
-- Which month generated the highest gross paid revenue?

SELECT
    YEAR(payment_date) AS year,
    MONTHNAME(payment_date) AS month,
    SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'Paid'
GROUP BY YEAR(payment_date), MONTH(payment_date), MONTHNAME(payment_date)
ORDER BY total_revenue DESC;

-- Question 11
-- Which guests have never made a reservation?

SELECT 
    g.first_name,
    g.last_name,
    g.nationality
FROM guests g
LEFT JOIN reservations r
    USING (guest_id)
WHERE r.reservation_id IS NULL;

-- Question 12
-- Which hotel has the highest average reservation value?

SELECT 
    h.hotel_name,
    TRUNCATE(AVG(re.total_price) , 2)  AS average_reservation_value
FROM hotels h 
JOIN rooms r 
    USING(hotel_id) 
JOIN reservations re 
    USING(room_id)
WHERE re.status <> 'Cancelled'
GROUP BY h.hotel_id , h.hotel_name
ORDER BY average_reservation_value DESC;

-- Question 13
-- Which guests have the highest number of completed reservations?

SELECT 
    g.guest_id,
    g.first_name,
    g.last_name,
    g.nationality,
    COUNT(*) AS completed_reservation
FROM guests g 
JOIN reservations r 
    USING(guest_id)
WHERE r.status = 'Completed'
GROUP BY 
    g.guest_id,
    g.first_name,
    g.last_name,
    g.nationality
ORDER BY completed_reservation DESC;

-- Question 14 
-- Which room types generate more revenue than the average room type revenue?

SELECT 
    rt.room_type_id,
    rt.type_name,
    SUM(p.amount) AS total_revenue_room_type
FROM room_types rt 
JOIN rooms r 
    USING (room_type_id)
JOIN reservations re 
    USING (room_id)
JOIN payments p 
    USING (reservation_id)
WHERE p.payment_status = 'Paid'
GROUP BY
    rt.room_type_id,
    rt.type_name
HAVING SUM(p.amount) > (
    SELECT AVG(room_type_revenue)
    FROM (
        SELECT 
            rt2.room_type_id,
            SUM(p2.amount) AS room_type_revenue
        FROM room_types rt2
        JOIN rooms r2
            USING (room_type_id)
        JOIN reservations re2
            USING (room_id)
        JOIN payments p2
            USING (reservation_id)
        WHERE p2.payment_status = 'Paid'
        GROUP BY rt2.room_type_id
    ) AS room_type_totals
)
ORDER BY total_revenue_room_type DESC;

-- Question 15
-- Which guests have spent more than the average spending of guests from the same nationality?

SELECT 
    g.guest_id,
    g.first_name,
    g.last_name,
    g.nationality,
    SUM(p.amount) AS guest_total_spending

FROM guests g 
JOIN reservations r 
    USING(guest_id)
JOIN payments p 
    USING(reservation_id)
WHERE p.payment_status = 'Paid'
GROUP BY 
    g.guest_id,
    g.first_name,
    g.last_name,
    g.nationality

HAVING SUM(p.amount) > (
     SELECT AVG(guest_total)
    FROM (
        SELECT
            g2.guest_id,
            SUM(p2.amount) AS guest_total
        FROM guests g2
        JOIN reservations r2
            USING (guest_id)
        JOIN payments p2
            USING (reservation_id)
        WHERE p2.payment_status = 'Paid'
          AND g2.nationality = g.nationality
        GROUP BY g2.guest_id
    ) AS nationality_guest_totals)
ORDER BY guest_total_spending DESC;









