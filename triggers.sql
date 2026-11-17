USE hotel_management;

-- 1. log_reservation_after_update TRIGGER

DROP TABLE IF EXISTS reservation_status_log;

CREATE TABLE reservation_status_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    old_status VARCHAR(20) NOT NULL,
    new_status VARCHAR(20) NOT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_status_log_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES reservations(reservation_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

DROP TRIGGER IF EXISTS log_reservation_after_update;
DELIMITER $$
CREATE TRIGGER log_reservation_after_update
AFTER UPDATE ON reservations
FOR EACH ROW
BEGIN
    IF NEW.status <> OLD.status THEN
        INSERT INTO reservation_status_log (
            reservation_id,
            old_status,
            new_status
        )
        VALUES (
            NEW.reservation_id,
            OLD.status,
            NEW.status
        );
    END IF;
END $$
DELIMITER ;

-- 2. prevent_overlapping_reservation_before_insert TRIGGER

DROP TRIGGER IF EXISTS prevent_overlapping_reservation_before_insert;
DELIMITER $$
CREATE TRIGGER prevent_overlapping_reservation_before_insert
BEFORE INSERT ON reservations
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM reservations
        WHERE room_id = NEW.room_id
          AND status <> 'Cancelled'
          AND NEW.check_in < check_out
          AND NEW.check_out > check_in
    ) THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Room is already reserved for this date range';

    END IF;
END $$
DELIMITER ;




