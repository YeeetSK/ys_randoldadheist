DROP TABLE IF EXISTS `ys_randolheist`;
CREATE TABLE `ys_randolheist` (
    `player` VARCHAR(255) PRIMARY KEY,
    `xp` INT NOT NULL,
    `quest` VARCHAR(255) NOT NULL
);
