CREATE TABLE `pets` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(45) NOT NULL,
    `gender` varchar(45) NOT NULL,
    `birthdate` date NOT NULL,
    `owner_id` int unsigned NOT NULL,
    PRIMARY KEY (`id`)
);