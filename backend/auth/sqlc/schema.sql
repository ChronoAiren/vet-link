CREATE TABLE `users` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `given_name` varchar(45) NOT NULL,
    `family_name` varchar(45) NOT NULL,
    `email` varchar(45) NOT NULL,
    `password` varchar(45) NOT NULL,
    `role_id` tinyint unsigned NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`)
);

CREATE TABLE `clinics` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `user_id` int unsigned NOT NULL,
    `name` varchar(45) NOT NULL,
    `location` varchar(45) NOT NULL,
    `business_no` varchar(45) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `roles` (
    `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
    `description` varchar(45) NOT NULL,
    PRIMARY KEY (`id`)
);