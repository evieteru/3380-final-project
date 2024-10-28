DROP DATABASE IF EXISTS lego;

CREATE DATABASE lego;

USE lego;

CREATE TABLE `theme` (
	`Name` VARCHAR(100) PRIMARY KEY
);

CREATE TABLE `piece` (
    `piece_no` INT PRIMARY KEY,
    `quantity` INT,
    `type` VARCHAR(100),
    `color` VARCHAR(50)
);

CREATE TABLE `minifigure` (
    `Name` VARCHAR(100) PRIMARY KEY,
    `series` VARCHAR(50),
    `quantity` INT
);

CREATE TABLE `user` (
    `Username` VARCHAR(50) PRIMARY KEY,
    `Email` VARCHAR(100),
    `Lego_VIP` BOOLEAN,
    `Spending_total` DECIMAL(10, 2)
);



CREATE TABLE `set` (
    `Set_ID` INT AUTO_INCREMENT PRIMARY KEY,
    `Theme_name` VARCHAR(255),
    `Username` VARCHAR(255),
    `Set_name` VARCHAR(255) NOT NULL,
    `Original_price` DECIMAL(10, 2),
    `Selling_price` DECIMAL(10, 2),
    FOREIGN KEY (`Theme_name`) REFERENCES `theme`(`Name`) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (`Username`) REFERENCES `user`(`Username`) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `instructions` (
    `Instruction_ID` INT AUTO_INCREMENT PRIMARY KEY,
    `Set_ID` INT,
    `Type` VARCHAR(255),
    FOREIGN KEY (`Set_ID`) REFERENCES `SET`(`Set_ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `minifig_accessories` (
	`Minifig_name` VARCHAR(100),
    `Accessory` VARCHAR(100),
    PRIMARY KEY (`minifig_name`, `accessory`),
    FOREIGN KEY (`minifig_name`) REFERENCES `minifigure`(`Name`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `buys_minifig` (
    `Username` VARCHAR(50),
    `Minifig_name` VARCHAR(100),
    `Quantity_minifig` INT,
    PRIMARY KEY (`Username`, `Minifig_name`),
    FOREIGN KEY (`Username`) REFERENCES `user`(`Username`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (`Minifig_name`) REFERENCES `minifigure`(`Name`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `minifig_belongs_to_set` (
    `Set_ID` INT,
    `Minifig_name` VARCHAR(100),
    PRIMARY KEY (`Set_ID`, `Minifig_name`),
    FOREIGN KEY (`Set_ID`) REFERENCES `SET`(`Set_ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (`Minifig_name`) REFERENCES `minifigure`(`Name`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE `set_comprised_of_pieces` (
    `Set_ID` INT,
    `Piece_no` INT,
    `Quantity_in_set` INT,
    PRIMARY KEY (`Set_ID`, `Piece_no`),
    FOREIGN KEY (`Set_ID`) REFERENCES `set`(`Set_ID`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (`Piece_no`) REFERENCES `piece`(`piece_no`)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);







INSERT INTO `theme` (`Name`)
VALUES
('City'),
('Expert Creator'),
('Star Wars'),
('Ninjago');

INSERT INTO `piece` (`piece_no`, `quantity`, `type`, `color`)
VALUES
(10, 30, 'brick', 'red'),
(11, 45, 'plate', 'light blue'),
(12, 25, 'cylinder', 'yellow'),
(13, 15, 'brick', 'grey'),
(14, 50, 'plate', 'black');

INSERT INTO `minifigure` (`Name`, `series`, `quantity`)
VALUES
('Mickey Mouse', 'Disney 1' , 5),
('Astronaut', 'Series 3', 10),
('Pirate', 'Series 18', 3),
('Zombie', 'Series 22', 7),
('Lloyd', 'Ninjago', 12);

INSERT INTO `user` (`Username`, `Email`, `Lego_VIP`, `Spending_total`)
VALUES
('Jim', 'jimlego@example.com', TRUE, 10000.40),
('Evie', 'evielego@example.com', FALSE, 1234.56);

INSERT INTO `set` (`Theme_name`, `Username`, `Set_name`, `Original_price`, `Selling_price`)
VALUES
('City', 'Jim', 'Fire Station', 99.99, 149.99),
('Star Wars', 'Jim', 'AT-AT', 159.99, 229.99),
('Expert Creator', 'Evie', 'Boutique Hotel', 229.99, 250.00);

INSERT INTO `instructions` (`Set_ID`, `Type`)
VALUES
(1, 'PDF'),
(2, 'Paper'),
(3, 'Online');

INSERT INTO `minifig_accessories` (`Minifig_name`, `Accessory`)
VALUES
('Lloyd', 'Sword'),
('Astronaut', 'Helmet'),
('Pirate', 'Parrot');

INSERT INTO `buys_minifig` (`Username`, `Minifig_name`, `Quantity_minifig`)
VALUES
('Jim', 'Zombie', 2),
('Jim', 'Astronaut', 1),
('Evie', 'LLoyd', 3);

INSERT INTO `minifig_belongs_to_set` (`Set_ID`, `Minifig_name`)
VALUES
(1, 'Zombie'),
(2, 'Astronaut'),
(3, 'LLoyd');

INSERT INTO `set_comprised_of_pieces` (`Set_ID`, `Piece_no`, `Quantity_in_set`)
VALUES
(1, 10, 10),
(1, 11, 5),
(2, 12, 7),
(2, 13, 2),
(3, 14, 15);




