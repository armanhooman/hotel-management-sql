
CREATE DATABASE IF NOT EXISTS hotel_management
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE hotel_management;

-- drop children first 
DROP TABLE IF EXISTS reservation_status_log;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;
DROP TABLE IF EXISTS room_types;
DROP TABLE IF EXISTS hotels;


-- create tables


-- Hotels
CREATE TABLE `hotels` (
    `hotel_id` INT NOT NULL AUTO_INCREMENT,
    `hotel_name` VARCHAR(100) NOT NULL,
    `city` VARCHAR(50) NOT NULL,
    `address` VARCHAR(255) DEFAULT NULL,
    `star_rating` TINYINT NOT NULL,
    `phone` VARCHAR(20) DEFAULT NULL,
    `email` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`hotel_id`),
    UNIQUE KEY `email_UNIQUE` (`email`),
    CONSTRAINT chk_star_rating
        CHECK (star_rating BETWEEN 1 AND 5)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Room Types
CREATE TABLE `room_types` (
    `room_type_id` INT NOT NULL AUTO_INCREMENT,
    `type_name` VARCHAR(50) NOT NULL,
    `capacity` TINYINT NOT NULL,
    `description` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`room_type_id`),
    UNIQUE KEY `type_name_UNIQUE` (`type_name`),
    CONSTRAINT chk_capacity
        CHECK (capacity > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Guests
CREATE TABLE `guests` (
    `guest_id` INT NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(20) DEFAULT NULL,
    `email` VARCHAR(255) DEFAULT NULL,
    `nationality` VARCHAR(50) NOT NULL,
    `date_of_birth` DATE NOT NULL,
    PRIMARY KEY (`guest_id`),
    UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Rooms
CREATE TABLE `rooms` (
    `room_id` INT NOT NULL AUTO_INCREMENT,
    `hotel_id` INT NOT NULL,
    `room_type_id` INT NOT NULL,
    `room_number` VARCHAR(10) NOT NULL,
    `floor` TINYINT DEFAULT NULL,
    `price_per_night` DECIMAL(9,2) NOT NULL,
    `status` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`room_id`),
    UNIQUE KEY uq_hotel_room_number (hotel_id, room_number),
    KEY `fk_rooms_hotels_idx` (`hotel_id`),
    KEY `fk_rooms_room_types1_idx` (`room_type_id`),
    CONSTRAINT `fk_rooms_hotels`
        FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_rooms_room_types1`
        FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`room_type_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_room_price
        CHECK (price_per_night > 0),
    CONSTRAINT chk_room_status
        CHECK (status IN ('Available', 'Occupied', 'Maintenance'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Employees
CREATE TABLE `employees` (
    `employee_id` INT NOT NULL AUTO_INCREMENT,
    `hotel_id` INT NOT NULL,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `job_title` VARCHAR(50) NOT NULL,
    `hire_date` DATE NOT NULL,
    `salary` DECIMAL(9,2) NOT NULL,
    `phone` VARCHAR(20) DEFAULT NULL,
    `email` VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`employee_id`),
    UNIQUE KEY `email_UNIQUE` (`email`),
    KEY `fk_employees_hotels1_idx` (`hotel_id`),
    CONSTRAINT `fk_employees_hotels`
        FOREIGN KEY (`hotel_id`) REFERENCES `hotels` (`hotel_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_salary
        CHECK (salary >= 0 )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Reservations
CREATE TABLE `reservations` (
    `reservation_id` INT NOT NULL AUTO_INCREMENT,
    `guest_id` INT NOT NULL,
    `room_id` INT NOT NULL,
    `booking_date` DATETIME NOT NULL,
    `check_in` DATE NOT NULL,
    `check_out` DATE NOT NULL,
    `status` VARCHAR(20) NOT NULL,
    `total_price` DECIMAL(9,2) NOT NULL,
    PRIMARY KEY (`reservation_id`),
    KEY `fk_reservation_guests1_idx` (`guest_id`),
    KEY `fk_reservation_rooms1_idx` (`room_id`),
    CONSTRAINT `fk_reservation_guests`
        FOREIGN KEY (`guest_id`) REFERENCES `guests` (`guest_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_reservation_rooms`
        FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_reservation_dates
        CHECK (check_out > check_in),
    CONSTRAINT chk_total_price
        CHECK (total_price >= 0),
    CONSTRAINT chk_reservation_status
        CHECK (status IN ('Pending', 'Confirmed', 'Cancelled', 'Completed'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Payments
CREATE TABLE `payments` (
    `payment_id` INT NOT NULL AUTO_INCREMENT,
    `reservation_id` INT NOT NULL,
    `payment_date` DATETIME NOT NULL,
    `amount` DECIMAL(9,2) NOT NULL,
    `payment_method` VARCHAR(20) NOT NULL,
    `payment_status` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`payment_id`),
    KEY `fk_payments_reservation1_idx` (`reservation_id`),
    CONSTRAINT `fk_payments_reservation1`
        FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`reservation_id`)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_payment_amount
        CHECK (amount > 0),
    CONSTRAINT chk_payment_status
        CHECK (payment_status IN ('Pending', 'Paid', 'Failed', 'Refunded'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




