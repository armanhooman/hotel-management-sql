USE hotel_management;
-- 1. calculate stay nights FUNCTION

DROP FUNCTION IF EXISTS calculate_stay_nights;
DELIMITER $$
CREATE FUNCTION calculate_stay_nights(
    p_check_in DATE,
    p_check_out DATE
)
RETURNS INTEGER
DETERMINISTIC 
BEGIN
    RETURN DATEDIFF( p_check_out, p_check_in );
END $$
DELIMITER ;


-- 2. calculate_remaining_balance


DROP FUNCTION IF EXISTS calculate_remaining_balance;
DELIMITER $$
CREATE FUNCTION calculate_remaining_balance(
    p_reservation_id INT
)
RETURNS DECIMAL(9,2)
READS SQL DATA
BEGIN
    DECLARE v_total_price DECIMAL(9,2);
    DECLARE v_net_paid DECIMAL(9,2);

    SELECT total_price
    INTO v_total_price
    FROM reservations
    WHERE reservation_id = p_reservation_id;

    SELECT COALESCE(
        SUM(
            CASE
                WHEN payment_status = 'Paid' THEN amount
                WHEN payment_status = 'Refunded' THEN - amount
                ELSE 0
            END
        ),
        0
    )
    INTO v_net_paid
    FROM payments
    WHERE reservation_id = p_reservation_id;

    RETURN v_total_price - v_net_paid;
END $$
DELIMITER ;













    
    






