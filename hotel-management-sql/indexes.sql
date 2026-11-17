USE hotel_management;
-- Optimized reservation overlap checks.
CREATE INDEX idx_room_id_status_check_in_check_out
ON reservations (room_id, status, check_in, check_out);


CREATE INDEX idx_payment_status_date
ON payments (payment_status, payment_date);






