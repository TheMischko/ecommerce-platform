-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecommerce_platform
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `product_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_type` (
  `product_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL,
  `slug` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`product_type_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `title_UNIQUE` ON `product_type` (`title` ASC);


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `image` (
  `image_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL,
  `alt_text` VARCHAR(128) NOT NULL,
  `source` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`image_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product` (
  `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL,
  `slug` VARCHAR(200) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `content` LONGTEXT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `last_updated` DATETIME NULL,
  `product_type_id` INT NOT NULL,
  `title_image_id` INT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `product_id_UNIQUE` ON `product` (`product_id` ASC);

CREATE UNIQUE INDEX `slug_UNIQUE` ON `product` (`slug` ASC);

CREATE INDEX `fk_product_product_type1_idx` ON `product` (`product_type_id` ASC);

CREATE INDEX `fk_product_image1_idx` ON `product` (`title_image_id` ASC);


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `category` (
  `product_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL,
  `slug` VARCHAR(200) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `product_id_UNIQUE` ON `category` (`product_id` ASC);

CREATE UNIQUE INDEX `slug_UNIQUE` ON `category` (`slug` ASC);


-- -----------------------------------------------------
-- Table `product_has_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_has_category` (
  `product_product_id` INT UNSIGNED NOT NULL,
  `category_product_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`product_product_id`, `category_product_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_product_has_category_category1_idx` ON `product_has_category` (`category_product_id` ASC);

CREATE INDEX `fk_product_has_category_product_idx` ON `product_has_category` (`product_product_id` ASC);


-- -----------------------------------------------------
-- Table `keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `keyword` (
  `keyword_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NOT NULL,
  `slug` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`keyword_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `keyword_id_UNIQUE` ON `keyword` (`keyword_id` ASC);

CREATE UNIQUE INDEX `slug_UNIQUE` ON `keyword` (`slug` ASC);


-- -----------------------------------------------------
-- Table `product_has_keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_has_keyword` (
  `product_product_id` INT UNSIGNED NOT NULL,
  `keyword_keyword_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`product_product_id`, `keyword_keyword_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_product_has_keyword_keyword1_idx` ON `product_has_keyword` (`keyword_keyword_id` ASC);

CREATE INDEX `fk_product_has_keyword_product1_idx` ON `product_has_keyword` (`product_product_id` ASC);


-- -----------------------------------------------------
-- Table `product_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_detail` (
  `detail_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unit` VARCHAR(45) NULL,
  `amount` FLOAT UNSIGNED NULL DEFAULT 1,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`detail_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `detail_id_UNIQUE` ON `product_detail` (`detail_id` ASC);


-- -----------------------------------------------------
-- Table `product_variant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_variant` (
  `product_variant_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_product_id` INT UNSIGNED NOT NULL,
  `product_details_detail_id` INT UNSIGNED NOT NULL,
  `info` VARCHAR(255) NULL,
  PRIMARY KEY (`product_variant_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_product_has_product_details_product_details1_idx` ON `product_variant` (`product_details_detail_id` ASC);

CREATE INDEX `fk_product_has_product_details_product1_idx` ON `product_variant` (`product_product_id` ASC);

CREATE UNIQUE INDEX `product_detail_id_UNIQUE` ON `product_variant` (`product_variant_id` ASC);


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `address` (
  `address_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `company_identifier` VARCHAR(128) NULL,
  `street` VARCHAR(255) NOT NULL,
  `house_number` VARCHAR(20) NOT NULL,
  `district` VARCHAR(45) NULL,
  `city` VARCHAR(128) NOT NULL,
  `country_part` VARCHAR(128) NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `phone` VARCHAR(16) NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `address_id_UNIQUE` ON `address` (`address_id` ASC);


-- -----------------------------------------------------
-- Table `order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_status` (
  `order_status_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `text` MEDIUMTEXT NULL,
  PRIMARY KEY (`order_status_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `order_status_id_UNIQUE` ON `order_status` (`order_status_id` ASC);


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(128) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `first_name` VARCHAR(80) NOT NULL,
  `middle_name` VARCHAR(128) NULL,
  `surname` VARCHAR(80) NOT NULL,
  `phone` VARCHAR(16) NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `user_id_UNIQUE` ON `user` (`user_id` ASC);

CREATE UNIQUE INDEX `email_UNIQUE` ON `user` (`email` ASC);


-- -----------------------------------------------------
-- Table `payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `payment` (
  `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `method` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `payment_id_UNIQUE` ON `payment` (`payment_id` ASC);


-- -----------------------------------------------------
-- Table `shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shipping` (
  `shipping_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `icon` VARCHAR(255) NULL,
  `title` VARCHAR(255) NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`shipping_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `shipping_id_UNIQUE` ON `shipping` (`shipping_id` ASC);


-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `note` MEDIUMTEXT NULL,
  `created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `address_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `order_status_id` INT UNSIGNED NOT NULL,
  `payment_id` INT UNSIGNED NOT NULL,
  `shipping_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `order_id_UNIQUE` ON `order` (`order_id` ASC);

CREATE INDEX `fk_order_address1_idx` ON `order` (`address_id` ASC);

CREATE INDEX `fk_order_order_status1_idx` ON `order` (`order_status_id` ASC);

CREATE INDEX `fk_order_user1_idx` ON `order` (`user_id` ASC);

CREATE INDEX `fk_order_payment1_idx` ON `order` (`payment_id` ASC);

CREATE INDEX `fk_order_shipping1_idx` ON `order` (`shipping_id` ASC);


-- -----------------------------------------------------
-- Table `order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_item` (
  `order_item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `product_variant_id` INT UNSIGNED NOT NULL,
  `amount` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_item_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `order_item_id_UNIQUE` ON `order_item` (`order_item_id` ASC);

CREATE INDEX `fk_order_item_product_variant1_idx` ON `order_item` (`product_variant_id` ASC);


-- -----------------------------------------------------
-- Table `order_has_order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_has_order_item` (
  `order_order_id` INT UNSIGNED NOT NULL,
  `order_item_order_item_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_order_id`, `order_item_order_item_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_order_has_order_item_order_item1_idx` ON `order_has_order_item` (`order_item_order_item_id` ASC);

CREATE INDEX `fk_order_has_order_item_order1_idx` ON `order_has_order_item` (`order_order_id` ASC);


-- -----------------------------------------------------
-- Table `stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `stock` (
  `product_variant_id` INT UNSIGNED NOT NULL,
  `amount` INT NULL DEFAULT 0,
  PRIMARY KEY (`product_variant_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `product_variant_id_UNIQUE` ON `stock` (`product_variant_id` ASC);


-- -----------------------------------------------------
-- Table `meta_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `meta_data` (
  `meta_data_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `value` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`meta_data_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `meta_data_id_UNIQUE` ON `meta_data` (`meta_data_id` ASC);


-- -----------------------------------------------------
-- Table `product_has_meta_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_has_meta_data` (
  `product_product_id` INT UNSIGNED NOT NULL,
  `product_meta_data_meta_data_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`product_product_id`, `product_meta_data_meta_data_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_product_has_product_meta_data_product_meta_data1_idx` ON `product_has_meta_data` (`product_meta_data_meta_data_id` ASC);

CREATE INDEX `fk_product_has_product_meta_data_product1_idx` ON `product_has_meta_data` (`product_product_id` ASC);


-- -----------------------------------------------------
-- Table `user_has_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_has_address` (
  `user_user_id` INT UNSIGNED NOT NULL,
  `address_address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`user_user_id`, `address_address_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_user_has_address_address1_idx` ON `user_has_address` (`address_address_id` ASC);

CREATE INDEX `fk_user_has_address_user1_idx` ON `user_has_address` (`user_user_id` ASC);


-- -----------------------------------------------------
-- Table `product_type_has_meta_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_type_has_meta_data` (
  `product_type_product_type_id` INT NOT NULL,
  `meta_data_meta_data_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`product_type_product_type_id`, `meta_data_meta_data_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_product_type_has_meta_data_meta_data1_idx` ON `product_type_has_meta_data` (`meta_data_meta_data_id` ASC);

CREATE INDEX `fk_product_type_has_meta_data_product_type1_idx` ON `product_type_has_meta_data` (`product_type_product_type_id` ASC);


-- -----------------------------------------------------
-- Table `event_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_code` (
  `event_code_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `discount` FLOAT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NULL,
  PRIMARY KEY (`event_code_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `event_code_id_UNIQUE` ON `event_code` (`event_code_id` ASC);

CREATE UNIQUE INDEX `code_UNIQUE` ON `event_code` (`code` ASC);


-- -----------------------------------------------------
-- Table `order_has_event_code`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_has_event_code` (
  `order_order_id` INT UNSIGNED NOT NULL,
  `event_code_event_code_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`order_order_id`, `event_code_event_code_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_order_has_event_code_event_code1_idx` ON `order_has_event_code` (`event_code_event_code_id` ASC);

CREATE INDEX `fk_order_has_event_code_order1_idx` ON `order_has_event_code` (`order_order_id` ASC);


-- -----------------------------------------------------
-- Table `gallery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gallery` (
  `gallery_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(128) NULL,
  `slug` VARCHAR(200) NULL,
  PRIMARY KEY (`gallery_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `gallery_id_UNIQUE` ON `gallery` (`gallery_id` ASC);


-- -----------------------------------------------------
-- Table `image_has_gallery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `image_has_gallery` (
  `image_image_id` INT NOT NULL,
  `gallery_gallery_id` INT NOT NULL,
  PRIMARY KEY (`image_image_id`, `gallery_gallery_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_image_has_gallery_gallery1_idx` ON `image_has_gallery` (`gallery_gallery_id` ASC);

CREATE INDEX `fk_image_has_gallery_image1_idx` ON `image_has_gallery` (`image_image_id` ASC);


-- -----------------------------------------------------
-- Table `product_has_gallery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_has_gallery` (
  `product_product_id` INT UNSIGNED NOT NULL,
  `gallery_gallery_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`product_product_id`, `gallery_gallery_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_product_has_gallery_gallery1_idx` ON `product_has_gallery` (`gallery_gallery_id` ASC);

CREATE INDEX `fk_product_has_gallery_product1_idx` ON `product_has_gallery` (`product_product_id` ASC);


-- -----------------------------------------------------
-- Table `config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `config` (
  `key` VARCHAR(128) NOT NULL,
  `value` VARCHAR(255) NULL,
  PRIMARY KEY (`key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role` (
  `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_has_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_has_role` (
  `user_user_id` INT UNSIGNED NOT NULL,
  `role_role_id` INT NOT NULL,
  PRIMARY KEY (`user_user_id`, `role_role_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_user_has_role_role1_idx` ON `user_has_role` (`role_role_id` ASC);

CREATE INDEX `fk_user_has_role_user1_idx` ON `user_has_role` (`user_user_id` ASC);


-- -----------------------------------------------------
-- Table `permission_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `permission_category` (
  `permission_category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(60) NULL,
  `key` VARCHAR(60) NULL,
  PRIMARY KEY (`permission_category_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `permission_category_UNIQUE` ON `permission_category` (`permission_category_id` ASC);


-- -----------------------------------------------------
-- Table `permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `permission` (
  `permission_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` VARCHAR(60) NULL,
  `title` VARCHAR(60) NULL,
  `permission_category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`permission_id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `permission_id_UNIQUE` ON `permission` (`permission_id` ASC);

CREATE INDEX `fk_permission_permission_category1_idx` ON `permission` (`permission_category_id` ASC);


-- -----------------------------------------------------
-- Table `role_has_permission`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_has_permission` (
  `role_role_id` INT NOT NULL,
  `permission_permission_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`role_role_id`, `permission_permission_id`))
ENGINE = InnoDB;

CREATE INDEX `fk_role_has_permission_permission1_idx` ON `role_has_permission` (`permission_permission_id` ASC);

CREATE INDEX `fk_role_has_permission_role1_idx` ON `role_has_permission` (`role_role_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
