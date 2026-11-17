USE hotel_management;
-- hotel records

INSERT INTO hotels
    (hotel_name, city, address, star_rating, phone, email)
VALUES
    ('Hilton', 'Berlin', '12 Alexanderplatz, Berlin', 5, '+49-30-5550101', 'berlin@hilton-demo.com'),
    ('Plaza', 'Munich', '48 Marienplatz, Munich', 4, '+49-89-5550202', 'munich@plaza-demo.com'),
    ('Espinas', 'Hamburg', '27 Hafenstrasse, Hamburg', 4, '+49-40-5550303', 'hamburg@espinas-demo.com'),
    ('Atlantis Royal', 'Cologne', '91 Rhine Avenue, Cologne', 5, '+49-221-5550404', 'cologne@atlantis-demo.com');

-- room_type records

INSERT INTO room_types 
    (type_name , capacity , description)
VALUES
    ('Single' , 1 , 'One single bed'),
    ('Double' , 2 , 'One double bed'),
    ('Deluxe' , 2 , 'Premium room with extra amenities'),
    ('Suite' , 4 , 'Large room with separate living area');

-- guests record

INSERT INTO guests
    (first_name , last_name , phone , email , nationality , date_of_birth)
VALUES 
    ('Liam', 'Anderson', '+49-151-1001001', 'liam.anderson@example.com', 'German', '1993-04-12'),
    ('Emma', 'Schneider', '+49-151-1001002', 'emma.schneider@example.com', 'German', '1988-09-21'),
    ('Noah', 'Martin', '+33-6-1001003', 'noah.martin@example.com', 'French', '1996-01-30'),
    ('Olivia', 'Rossi', '+39-320-1001004', 'olivia.rossi@example.com', 'Italian', '1991-07-18'),
    ('Ethan', 'Miller', '+1-202-1001005', 'ethan.miller@example.com', 'American', '1985-11-03'),
    ('Sophia', 'Brown', '+44-7700-1001006', 'sophia.brown@example.com', 'British', '1998-02-14'),
    ('Lucas', 'Garcia', '+34-610-1001007', 'lucas.garcia@example.com', 'Spanish', '1990-05-27'),
    ('Mia', 'Wilson', '+1-202-1001008', 'mia.wilson@example.com', 'American', '1995-12-09'),
    ('Amir', 'Hosseini', '+98-912-1001009', 'amir.hosseini@example.com', 'Iranian', '1994-03-16'),
    ('Sara', 'Karimi', '+98-912-1001010', 'sara.karimi@example.com', 'Iranian', '1997-08-25'),
    ('Leo', 'Weber', '+49-151-1001011', 'leo.weber@example.com', 'German', '1989-06-11'),
    ('Anna', 'Keller', '+49-151-1001012', 'anna.keller@example.com', 'German', '1992-10-04'),
    ('Daniel', 'Smith', '+44-7700-1001013', 'daniel.smith@example.com', 'British', '1987-01-19'),
    ('Sofia', 'Lopez', '+34-610-1001014', 'sofia.lopez@example.com', 'Spanish', '1999-04-02'),
    ('Marco', 'Bianchi', '+39-320-1001015', 'marco.bianchi@example.com', 'Italian', '1986-09-13'),
    ('Claire', 'Dubois', '+33-6-1001016', 'claire.dubois@example.com', 'French', '1993-12-22'),
    ('David', 'Johnson', '+1-202-1001017', 'david.johnson@example.com', 'American', '1990-02-08'),
    ('Nina', 'Fischer', '+49-151-1001018', 'nina.fischer@example.com', 'German', '1996-07-07'),
    ('Arman', 'Nouri', '+98-912-1001019', 'arman.nouri@example.com', 'Iranian', '2001-11-15'),
    ('Elena', 'Petrova', '+49-151-1001020', 'elena.petrova@example.com', 'Russian', '1994-05-31');

-- rooms record

INSERT INTO rooms
    (hotel_id , room_type_id , room_number , floor , price_per_night , status)
VALUES
    -- Hilton
    (1, 1, '101', 1, 90.00, 'Available'),
    (1, 2, '102', 1, 140.00, 'Available'),
    (1, 2, '201', 2, 155.00, 'Occupied'),
    (1, 3, '202', 2, 220.00, 'Available'),
    (1, 3, '301', 3, 250.00, 'Maintenance'),
    (1, 4, '302', 3, 390.00, 'Available'),
    (1, 4, '401', 4, 450.00, 'Available'),

    -- Plaza
    (2, 1, '101', 1, 75.00, 'Available'),
    (2, 1, '102', 1, 80.00, 'Available'),
    (2, 2, '201', 2, 125.00, 'Occupied'),
    (2, 2, '202', 2, 135.00, 'Available'),
    (2, 3, '301', 3, 195.00, 'Available'),
    (2, 3, '302', 3, 210.00, 'Maintenance'),
    (2, 4, '401', 4, 320.00, 'Available'),

    -- Espinas
    (3, 1, '101', 1, 85.00, 'Available'),
    (3, 2, '102', 1, 130.00, 'Available'),
    (3, 2, '201', 2, 145.00, 'Available'),
    (3, 3, '202', 2, 205.00, 'Occupied'),
    (3, 3, '301', 3, 235.00, 'Available'),
    (3, 4, '302', 3, 350.00, 'Available'),
    (3, 4, '401', 4, 410.00, 'Maintenance'),

    -- Atlantis Royal
    (4, 1, '101', 1, 110.00, 'Available'),
    (4, 2, '102', 1, 170.00, 'Available'),
    (4, 2, '201', 2, 185.00, 'Occupied'),
    (4, 3, '202', 2, 280.00, 'Available'),
    (4, 3, '301', 3, 320.00, 'Available'),
    (4, 4, '302', 3, 480.00, 'Available'),
    (4, 4, '401', 4, 550.00, 'Maintenance');

-- employees record

INSERT INTO employees 
    (hotel_id , first_name , last_name , job_title , hire_date , salary , phone , email)
VALUES
    -- Hilton
    (1, 'Daniel', 'Meyer', 'Manager', '2020-03-15', 5200.00, '+49-151-2001001', 'daniel.meyer@hilton-demo.com'),
    (1, 'Laura', 'Schmidt', 'Receptionist', '2022-06-10', 2800.00, '+49-151-2001002', 'laura.schmidt@hilton-demo.com'),
    (1, 'Kevin', 'Braun', 'Chef', '2021-11-05', 3400.00, '+49-151-2001003', 'kevin.braun@hilton-demo.com'),
    (1, 'Mila', 'Wagner', 'Housekeeping', '2023-02-18', 2400.00, '+49-151-2001004', 'mila.wagner@hilton-demo.com'),

    -- Plaza
    (2, 'Thomas', 'Keller', 'Manager', '2019-09-01', 4800.00, '+49-151-2001005', 'thomas.keller@plaza-demo.com'),
    (2, 'Anna', 'Fischer', 'Receptionist', '2022-01-22', 2600.00, '+49-151-2001006', 'anna.fischer@plaza-demo.com'),
    (2, 'Marco', 'Leone', 'Chef', '2021-05-30', 3200.00, '+49-151-2001007', 'marco.leone@plaza-demo.com'),
    (2, 'Nina', 'Wolf', 'Housekeeping', '2023-07-12', 2300.00, '+49-151-2001008', 'nina.wolf@plaza-demo.com'),

    -- Espinas
    (3, 'Reza', 'Ahmadi', 'Manager', '2020-08-20', 5000.00, '+49-151-2001009', 'reza.ahmadi@espinas-demo.com'),
    (3, 'Sara', 'Moradi', 'Receptionist', '2021-12-11', 2750.00, '+49-151-2001010', 'sara.moradi@espinas-demo.com'),
    (3, 'Ali', 'Karimi', 'Chef', '2022-04-17', 3300.00, '+49-151-2001011', 'ali.karimi@espinas-demo.com'),
    (3, 'Lena', 'Hoffmann', 'Housekeeping', '2023-09-03', 2350.00, '+49-151-2001012', 'lena.hoffmann@espinas-demo.com'),

    -- Atlantis Royal
    (4, 'Michael', 'Brown', 'Manager', '2018-11-25', 5600.00, '+49-151-2001013', 'michael.brown@atlantis-demo.com'),
    (4, 'Sophia', 'Taylor', 'Receptionist', '2021-03-14', 3000.00, '+49-151-2001014', 'sophia.taylor@atlantis-demo.com'),
    (4, 'David', 'Rossi', 'Chef', '2020-10-09', 3600.00, '+49-151-2001015', 'david.rossi@atlantis-demo.com'),
    (4, 'Emma', 'Wilson', 'Housekeeping', '2022-08-28', 2500.00, '+49-151-2001016', 'emma.wilson@atlantis-demo.com');

-- reservation records

INSERT INTO reservations 
    (guest_id , room_id , booking_date , check_in , check_out , status , total_price)
VALUES
     (1, 1,  '2026-01-05 10:20:00', '2026-01-15', '2026-01-18', 'Completed', 270.00),
    (2, 4,  '2026-01-08 14:10:00', '2026-01-20', '2026-01-22', 'Completed', 440.00),
    (3, 8,  '2026-01-12 09:30:00', '2026-02-02', '2026-02-05', 'Completed', 225.00),
    (4, 11, '2026-01-17 18:45:00', '2026-02-10', '2026-02-12', 'Cancelled', 270.00),
    (5, 15, '2026-01-25 11:15:00', '2026-02-15', '2026-02-19', 'Completed', 340.00),

    (6, 18, '2026-02-01 12:00:00', '2026-02-20', '2026-02-23', 'Completed', 615.00),
    (7, 22, '2026-02-05 16:20:00', '2026-02-25', '2026-02-27', 'Completed', 220.00),
    (8, 25, '2026-02-11 10:10:00', '2026-03-02', '2026-03-05', 'Completed', 840.00),
    (9, 2,  '2026-02-14 13:40:00', '2026-03-10', '2026-03-14', 'Completed', 560.00),
    (10, 6, '2026-02-18 08:50:00', '2026-03-15', '2026-03-18', 'Cancelled', 1170.00),

    (11, 9,  '2026-03-01 15:35:00', '2026-03-20', '2026-03-23', 'Completed', 240.00),
    (12, 12, '2026-03-06 10:25:00', '2026-03-25', '2026-03-28', 'Completed', 585.00),
    (13, 16, '2026-03-10 17:00:00', '2026-04-01', '2026-04-04', 'Completed', 390.00),
    (14, 19, '2026-03-15 12:30:00', '2026-04-05', '2026-04-08', 'Cancelled', 705.00),
    (15, 23, '2026-03-20 09:15:00', '2026-04-10', '2026-04-13', 'Completed', 510.00),

    (16, 26, '2026-04-01 11:45:00', '2026-04-20', '2026-04-23', 'Completed', 960.00),
    (17, 3,  '2026-04-04 14:20:00', '2026-04-25', '2026-04-27', 'Completed', 310.00),
    (18, 7,  '2026-04-08 16:50:00', '2026-05-01', '2026-05-04', 'Completed', 1350.00),
    (19, 10, '2026-04-12 10:05:00', '2026-05-05', '2026-05-08', 'Completed', 375.00),
    (20, 17, '2026-04-18 13:25:00', '2026-05-10', '2026-05-14', 'Completed', 580.00),

    -- repeat guests
    (1, 20,  '2026-05-01 09:00:00', '2026-05-20', '2026-05-23', 'Completed', 1050.00),
    (2, 24,  '2026-05-04 11:10:00', '2026-05-25', '2026-05-28', 'Completed', 555.00),
    (3, 27,  '2026-05-08 15:30:00', '2026-06-01', '2026-06-04', 'Completed', 1440.00),
    (4, 5,   '2026-05-11 12:40:00', '2026-06-05', '2026-06-07', 'Cancelled', 500.00),
    (5, 13,  '2026-05-15 17:15:00', '2026-06-10', '2026-06-13', 'Completed', 630.00),

    (6, 21,  '2026-06-01 10:50:00', '2026-06-20', '2026-06-22', 'Completed', 820.00),
    (7, 28,  '2026-06-05 13:05:00', '2026-06-25', '2026-06-27', 'Cancelled', 1100.00),
    (8, 14,  '2026-06-09 09:40:00', '2026-07-01', '2026-07-05', 'Completed', 1280.00),
    (9, 4,   '2026-06-13 16:25:00', '2026-07-10', '2026-07-13', 'Completed', 660.00),
    (10, 18, '2026-06-18 11:55:00', '2026-07-15', '2026-07-18', 'Completed', 615.00),

    -- more recent / upcoming
    (11, 22, '2026-09-10 10:30:00', '2026-11-15', '2026-11-18', 'Confirmed', 330.00),
    (12, 25, '2026-09-15 12:20:00', '2026-11-20', '2026-11-23', 'Confirmed', 840.00),
    (13, 6,  '2026-09-20 15:10:00', '2026-11-25', '2026-11-28', 'Confirmed', 1170.00),
    (14, 12, '2026-09-25 09:45:00', '2026-12-01', '2026-12-04', 'Pending', 585.00),
    (15, 16, '2026-10-01 14:05:00', '2026-12-05', '2026-12-08', 'Pending', 390.00),

    (16, 23, '2026-10-05 11:30:00', '2026-12-10', '2026-12-13', 'Confirmed', 510.00),
    (17, 27, '2026-10-10 17:20:00', '2026-12-15', '2026-12-18', 'Pending', 1440.00),
    (18, 2,  '2026-10-15 13:50:00', '2026-12-20', '2026-12-23', 'Confirmed', 420.00),
    (19, 9,  '2026-10-20 08:35:00', '2026-12-24', '2026-12-27', 'Cancelled', 240.00),
    (20, 26, '2026-10-25 16:00:00', '2026-12-28', '2027-01-02', 'Pending', 1600.00);

-- payment records

INSERT INTO payments 
    (reservation_id , payment_date , amount , payment_method , payment_status)
VALUES
      -- Reservations 1-10
    (1,  '2026-01-05 10:30:00', 270.00, 'Card',   'Paid'),

    (2,  '2026-01-08 14:20:00', 150.00, 'Online', 'Paid'),
    (2,  '2026-01-20 09:15:00', 290.00, 'Card',   'Paid'),

    (3,  '2026-01-12 09:40:00', 225.00, 'Online', 'Paid'),

    -- Cancelled: payment was returned
    (4,  '2026-01-17 19:00:00', 100.00, 'Card', 'Paid'),
    (4,  '2026-01-25 12:00:00', 100.00, 'Card', 'Refunded'),

    (5,  '2026-01-25 11:30:00', 340.00, 'Cash', 'Paid'),

    (6,  '2026-02-01 12:15:00', 200.00, 'Online', 'Paid'),
    (6,  '2026-02-20 10:30:00', 415.00, 'Card',   'Paid'),

    (7,  '2026-02-05 16:30:00', 220.00, 'Card', 'Paid'),

    (8,  '2026-02-11 10:20:00', 840.00, 'Online', 'Paid'),

    (9,  '2026-02-14 14:00:00', 200.00, 'Card', 'Paid'),
    (9,  '2026-03-10 08:30:00', 360.00, 'Cash', 'Paid'),

    -- Payment attempt failed, reservation later cancelled
    (10, '2026-02-18 09:00:00', 300.00, 'Online', 'Failed'),

    -- Reservations 11-20
    (11, '2026-03-01 15:45:00', 240.00, 'Card', 'Paid'),

    (12, '2026-03-06 10:40:00', 185.00, 'Online', 'Paid'),
    (12, '2026-03-25 09:10:00', 400.00, 'Card',   'Paid'),

    (13, '2026-03-10 17:15:00', 390.00, 'Online', 'Paid'),

    -- Cancelled + refunded
    (14, '2026-03-15 12:45:00', 200.00, 'Card', 'Paid'),
    (14, '2026-03-22 11:00:00', 200.00, 'Card', 'Refunded'),

    (15, '2026-03-20 09:30:00', 510.00, 'Cash', 'Paid'),

    (16, '2026-04-01 12:00:00', 300.00, 'Online', 'Paid'),
    (16, '2026-04-20 09:30:00', 660.00, 'Card',   'Paid'),

    (17, '2026-04-04 14:30:00', 310.00, 'Card', 'Paid'),

    (18, '2026-04-08 17:00:00', 500.00, 'Online', 'Paid'),
    (18, '2026-05-01 10:00:00', 850.00, 'Card',   'Paid'),

    (19, '2026-04-12 10:20:00', 375.00, 'Cash', 'Paid'),

    (20, '2026-04-18 13:40:00', 580.00, 'Online', 'Paid'),

    -- Reservations 21-30
    (21, '2026-05-01 09:15:00', 350.00, 'Card', 'Paid'),
    (21, '2026-05-20 09:00:00', 700.00, 'Card', 'Paid'),

    (22, '2026-05-04 11:25:00', 555.00, 'Online', 'Paid'),

    (23, '2026-05-08 15:45:00', 500.00, 'Online', 'Paid'),
    (23, '2026-06-01 08:30:00', 940.00, 'Card',   'Paid'),

    -- Cancelled, no successful payment
    (24, '2026-05-11 13:00:00', 250.00, 'Online', 'Failed'),

    (25, '2026-05-15 17:30:00', 630.00, 'Card', 'Paid'),

    (26, '2026-06-01 11:10:00', 300.00, 'Online', 'Paid'),
    (26, '2026-06-20 08:45:00', 520.00, 'Cash',   'Paid'),

    -- Cancelled + refund
    (27, '2026-06-05 13:20:00', 300.00, 'Card', 'Paid'),
    (27, '2026-06-12 10:30:00', 300.00, 'Card', 'Refunded'),

    (28, '2026-06-09 09:55:00', 1280.00, 'Online', 'Paid'),

    (29, '2026-06-13 16:40:00', 660.00, 'Card', 'Paid'),

    (30, '2026-06-18 12:10:00', 200.00, 'Online', 'Paid'),
    (30, '2026-07-15 09:20:00', 415.00, 'Card',   'Paid'),

    -- Future reservations 31-40
    -- Confirmed: some fully paid, some deposit only
    (31, '2026-09-10 10:45:00', 330.00, 'Online', 'Paid'),

    (32, '2026-09-15 12:35:00', 300.00, 'Card', 'Paid'),
    (32, '2026-09-15 12:36:00', 540.00, 'Card', 'Paid'),

    (33, '2026-09-20 15:25:00', 500.00, 'Online', 'Paid'),
    (33, '2026-10-20 11:00:00', 670.00, 'Online', 'Paid'),

    -- Pending reservation with deposit still pending
    (34, '2026-09-25 10:00:00', 200.00, 'Online', 'Pending'),

    -- No payment record for reservation 35 yet

    (36, '2026-10-05 11:45:00', 510.00, 'Card', 'Paid'),

    (37, '2026-10-10 17:35:00', 400.00, 'Online', 'Pending'),

    (38, '2026-10-15 14:05:00', 420.00, 'Online', 'Paid'),

    -- Cancelled reservation, failed payment
    (39, '2026-10-20 08:50:00', 240.00, 'Card', 'Failed'),

    -- Partial payment for a pending reservation
    (40, '2026-10-25 16:15:00', 500.00, 'Online', 'Paid');

 










