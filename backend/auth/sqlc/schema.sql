CREATE TABLE `users` (
    `id` int NOT NULL AUTO_INCREMENT,
    `given_name` varchar(45) NOT NULL,
    `family_name` varchar(45) NOT NULL,
    `email` varchar(45) NOT NULL,
    `password` varchar(45) NOT NULL,
    PRIMARY KEY (`id`)
);