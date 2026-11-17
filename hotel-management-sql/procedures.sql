USE hotel_management;

-- 1. update_reservation_status PROCEDURE 

DROP PROCEDURE IF EXISTS update_reservation_status;
DELIMITER $$
CREATE PROCEDURE update_reservation_status (
    IN p_reservation_id INT,
    IN p_new_status VARCHAR(20)
)
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM reservations
        WHERE reservation_id = p_reservation_id
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Reservation does not exist';

    ELSEIF p_new_status NOT IN (
        'Pending',
        'Confirmed',
        'Cancelled',
        'Completed'
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid reservation status';

    ELSE

        UPDATE reservations
        SET status = p_new_status
        WHERE reservation_id = p_reservation_id;

    END IF;

END $$
DELIMITER ;

-- 2. add_payment PROCEDURE 

DROP PROCEDURE IF EXISTS add_payment;
DELIMITER $$
CREATE PROCEDURE add_payment (
    IN p_reservation_id INT,
    IN p_amount DECIMAL(9,2),
    IN p_payment_method VARCHAR(20),
    IN p_payment_status VARCHAR(20)
)
BEGIN 
    IF NOT EXISTS (
        SELECT 1
        FROM reservations 
        WHERE reservation_id = p_reservation_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'reservation_id does not exists !!';
    
    ELSEIF p_amount <= 0 THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'amount should be > 0 !!';

    ELSEIF p_payment_status NOT IN (
        'Paid',
        'Pending',
        'Refunded',
        'Failed'
    ) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'invalid payment status !!';
    
    ELSE 
        INSERT INTO payments (
            reservation_id,
            payment_date,
            amount,
            payment_method,
            payment_status
        )
        VALUES (
            p_reservation_id,
            NOW(),
            p_amount,
            p_payment_method,
            p_payment_status
        );
    END IF;
END $$
DELIMITER ;

-- 3. create reservation PROCEDURE 

DROP PROCEDURE IF EXISTS create_reservation;
DELIMITER $$
CREATE PROCEDURE create_reservation (
    IN p_guest_id INT,
    IN p_room_id INT,
    IN p_check_in DATE,
    IN p_check_out DATE
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM guests
        WHERE guest_id = p_guest_id 
    ) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'guest_id does not exist !!';

    ELSEIF NOT EXISTS (
        SELECT 1
        FROM rooms
        WHERE room_id = p_room_id
    ) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'room_id does not exist !!';

    ELSEIF p_check_out <= p_check_in THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Check-out date must be after check-in date';

    ELSEIF p_room_id IN (SELECT room_id FROM rooms WHERE status = 'Maintenance') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This room is on a Maintenance state right now !! ';

    ELSEIF EXISTS (
        SELECT 1
        FROM reservations
        WHERE room_id = p_room_id
        AND status <> 'Cancelled'
        AND p_check_in < check_out
        AND p_check_out > check_in
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Room is already reserved for this date range';

    ELSE 
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
            p_guest_id,
            p_room_id,
            NOW(),
            p_check_in,
            p_check_out,
            'Pending',
            DATEDIFF(p_check_out, p_check_in) * (SELECT price_per_night FROM rooms WHERE room_id = p_room_id)
        );
    END IF;
END $$
DELIMITER ;



