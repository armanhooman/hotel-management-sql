USE hotel_management ;

-- 1. reservation_details VIEW
DROP VIEW IF EXISTS reservation_details;
CREATE VIEW reservation_details AS
SELECT 
    r.reservation_id,
    g.first_name,
    g.last_name,
    h.hotel_name,
    ro.room_number,
    rt.type_name AS room_type,
    r.booking_date,
    r.check_in,
    r.check_out,
    r.status,
    r.total_price

FROM guests g 
JOIN reservations r
    USING(guest_id)
JOIN rooms ro 
    USING(room_id)
JOIN room_types rt 
    USING(room_type_id)
JOIN hotels h 
    USING(hotel_id);

-- 2. hotel_revenue_summary

DROP VIEW IF EXISTS hotel_revenue_summary;
CREATE VIEW hotel_revenue_summary AS
SELECT 
    h.hotel_id,
    h.hotel_name,
    SUM(p.amount) AS total_revenue
FROM hotels h 
JOIN rooms r 
    USING(hotel_id)
JOIN reservations re 
    USING(room_id)
JOIN payments p 
    USING(reservation_id)
WHERE p.payment_status = 'Paid'
GROUP BY h.hotel_id , h.hotel_name;

-- reservation_payment_status

DROP VIEW IF EXISTS reservation_payment_status;
CREATE VIEW reservation_payment_status AS
SELECT
    r.reservation_id,
    r.total_price,

    COALESCE(
        SUM(
            CASE
                WHEN p.payment_status = 'Paid' THEN p.amount
                WHEN p.payment_status = 'Refunded' THEN -p.amount
                ELSE 0
            END
        ), 0
    ) AS total_paid,

    r.total_price -
    COALESCE(
        SUM(
            CASE
                WHEN p.payment_status = 'Paid' THEN p.amount
                WHEN p.payment_status = 'Refunded' THEN -p.amount
                ELSE 0
            END
        ), 0
    ) AS price_remaining,

    CASE
        WHEN COALESCE(
            SUM(
                CASE
                    WHEN p.payment_status = 'Paid' THEN p.amount
                    WHEN p.payment_status = 'Refunded' THEN -p.amount
                    ELSE 0
                END
            ), 0
        ) = 0
            THEN 'Unpaid'

        WHEN COALESCE(
            SUM(
                CASE
                    WHEN p.payment_status = 'Paid' THEN p.amount
                    WHEN p.payment_status = 'Refunded' THEN -p.amount
                    ELSE 0
                END
            ), 0
        ) < r.total_price
            THEN 'Partially Paid'

        ELSE 'Fully Paid'
    END AS reservation_payment_status

FROM reservations r
LEFT JOIN payments p
    USING (reservation_id)

GROUP BY
    r.reservation_id,
    r.total_price;


















