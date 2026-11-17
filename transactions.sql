USE hotel_management;

-- 1. Create Reservation with Initial Payment TRANSACTION

START TRANSACTION;
INSERT INTO reservations (
    guest_id,
    room_id,
    booking_date,
    check_in,
    check_out,
    status,
    total_price
)
VALUES(
    5,
    12,
    NOW(),
    '2026-12-10',
    '2026-12-14',
    'Pending',
    DATEDIFF('2026-12-14', '2026-12-10') *
    (SELECT price_per_night FROM rooms WHERE room_id = 12)
);

INSERT INTO payments(
    reservation_id,
    payment_date,
    amount,
    payment_method,
    payment_status
)
VALUES(
    LAST_INSERT_ID(),
    NOW(),
    200,
    'Credit card',
    'Paid'
);

COMMIT;

-- 2. Create Reservation and Payment with Rollback TRANSACTION


START TRANSACTION;

INSERT INTO reservations (
    guest_id,
    room_id,
    booking_date,
    check_in,
    check_out,
    status,
    total_price
)
VALUES (
    6,
    14,
    NOW(),
    '2026-12-20',
    '2026-12-23',
    'Pending',
    DATEDIFF('2026-12-23', '2026-12-20') *
    (SELECT price_per_night FROM rooms WHERE room_id = 14)
);

SET @new_reservation_id = LAST_INSERT_ID();

INSERT INTO payments (
    reservation_id,
    payment_date,
    amount,
    payment_method,
    payment_status
)
VALUES (
    @new_reservation_id,
    NOW(),
    150,
    'Credit Card',
    'Paid'
);

-- Check records before rollback
SELECT *
FROM reservations
WHERE reservation_id = @new_reservation_id;

SELECT *
FROM payments
WHERE reservation_id = @new_reservation_id;

ROLLBACK;

-- Check records after rollback
SELECT *
FROM reservations
WHERE reservation_id = @new_reservation_id;

SELECT *
FROM payments
WHERE reservation_id = @new_reservation_id;

