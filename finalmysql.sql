CREATE TABLE IF NOT EXISTS ecommerce.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
);


CREATE TABLE IF NOT EXISTS ecommerce.discount
(
    id character varying(255) NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS ecommerce.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) ,
    category_type integer,
    create_time timestamp ,
    update_time timestamp ,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
);

ALTER TABLE `ecommerce`.`product_category` 
CHANGE COLUMN `category_id` `category_id` INT NOT NULL AUTO_INCREMENT ;


CREATE TABLE IF NOT EXISTS ecommerce.product_info
(
    product_id character varying(255)  NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp ,
    product_description character varying(255) ,
    product_icon character varying(255) ,
    product_name character varying(255)  NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp ,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
);

CREATE TABLE IF NOT EXISTS ecommerce.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) ,
    email character varying(255) ,
    name character varying(255) ,
    password character varying(255) ,
    phone character varying(255) ,
    role character varying(255) ,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
);

ALTER TABLE `ecommerce`.`users` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) ,
    buyer_email character varying(255) ,
    buyer_name character varying(255) ,
    buyer_phone character varying(255) ,
    create_time timestamp,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
);

ALTER TABLE `ecommerce`.`order_main` 
CHANGE COLUMN `order_id` `order_id` BIGINT NOT NULL AUTO_INCREMENT ;



CREATE TABLE IF NOT EXISTS ecommerce.product_in_order
(
    id bigint NOT NULL AUTO_INCREMENT,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255)  NOT NULL,
    product_icon character varying(255) ,
    product_id character varying(255) ,
    product_name character varying(255) ,
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES ecommerce.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES ecommerce.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        ,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
);



CREATE TABLE IF NOT EXISTS ecommerce.wishlist
(
    id bigint NOT NULL AUTO_INCREMENT,
    created_date timestamp ,
    user_id bigint,
    product_id character varying(255),
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES ecommerce.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_wish_Fkey FOREIGN KEY (user_id)
        REFERENCES ecommerce.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

ALTER TABLE `ecommerce`.`discount`
ADD COLUMN user_email VARCHAR(255);

ALTER TABLE `ecommerce`.`discount` 
ADD INDEX `user_email_fkey_idx` (`user_email` ASC) VISIBLE;
;
ALTER TABLE `ecommerce`.`discount` 
ADD CONSTRAINT `user_email_fkey`
  FOREIGN KEY (`user_email`)
  REFERENCES `ecommerce`.`users` (`email`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
  ALTER TABLE `ecommerce`.`discount` 
DROP PRIMARY KEY;
;

ALTER TABLE `ecommerce`.`discount` 
ADD COLUMN `coupon` VARCHAR(255) NULL AFTER `user_email`,
CHANGE COLUMN `id` `id` BIGINT NOT NULL ,
ADD PRIMARY KEY (`id`);
;

ALTER TABLE `ecommerce`.`discount` 
CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT ;




INSERT INTO ecommerce.product_category VALUES (2147483641, 'Laptop & Mobiles', '0', '2022-06-23 23:03:26', '2022-07-16 17:55:50');
INSERT INTO ecommerce.product_category VALUES (2147483642, 'Fashion', '1', '2022-06-23 23:03:26', '2022-07-16 17:55:50');
INSERT INTO ecommerce.product_category VALUES ('2147483643', 'Appliances', '2', '2022-06-23 23:03:26', '2022-07-16 17:55:50');
INSERT INTO ecommerce.product_category VALUES ('2147483644', 'Electronic', '3', '2022-06-23 23:03:26', '2022-07-16 17:55:50');
INSERT INTO ecommerce.product_category VALUES ('2147483645', 'Sports', '4', '2022-06-23 23:03:26', '2022-07-16 17:55:50');

INSERT INTO ecommerce.product_info VALUES ('IF001', '0', '2022-06-23 23:03:26', '15.6inch(39.6cm) FHD,Anti-Glare,Micro-Edge Display/Intel Irlt-', 'https://m.media-amazon.com/images/I/81snY7iZorL._SL1500_.jpg', 'HP 15s 12th Gen Intel Core i5 8GB RAM/512GB SSD', '52340.00', '0', '8', '2022-07-16 17:55:50');

INSERT INTO ecommerce.product_info VALUES ('IF002', '0', '2022-06-23 23:03:26', 'Laptop (4GB RAM/256GB SSD/Windows 11 Home/Black/1.9 Kg, A314-22)', 'https://m.media-amazon.com/images/I/71rceuYk9JL._AC_UY218_.jpg', 'Acer Aspire 3 AMD 3020e Dual core Processor ', '63225.00', '0', '60', '2022-06-23 23:03:26');

INSERT INTO ecommerce.product_info VALUES ('IF003', '0', '2022-06-23 23:03:26', '(Blue Tide, 6GB RAM, 128GB Storage)', 'https://m.media-amazon.com/images/I/71AvQd3VzqL._SL1500_.jpg', 'OnePlus Nord CE 2', '19950.00', '0', '30', '2022-07-15 21:51:18');

INSERT INTO ecommerce.product_info VALUES ('IF007', '0', '2022-07-15 22:04:53', 'Additional Exchange Offers | Charger Included| Get 2 Months of YouTube Premium Free!', 'https://m.media-amazon.com/images/I/71UDT0TuNDL._SL1500_.jpg', 'Redmi Note 11 Pro + 5G (Mirage Blue, 6GB RAM, 128GB Storage)', '2599.00', '0', '30', '2022-07-15 22:04:53');

INSERT INTO ecommerce.product_info VALUES ('IF008', '0', '2022-07-15 22:04:53', 'Apple iPhone 12 (128GB) - Blue+Red+Black+White', 'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/katariy/Apple/iphone_SE/preorder/AMZ_FamilyStripe_iphone_13_pro_max._CB626819224_.png', 'Apple iPhone 12 (128GB) - Blue', '36500.00', '0', '30', '2022-07-15 22:04:53');
INSERT INTO ecommerce.product_info VALUES ('IF009', '0', '2022-07-15 22:04:53', '128GB Storage) with No Cost EMI/Additional Exchange Offers', 'https://m.media-amazon.com/images/I/511oJE35CxS._SL1200_.jpg', 'Vivo Y73 (Diamond Flare, 8GB RAM', '35340.00', '0', '30', '2022-07-15 22:04:53');




INSERT INTO ecommerce.product_info VALUES ('WS001', '1', '2022-06-23 23:03:26', 'Symbol Men\'s Regular Shirt', 'https://m.media-amazon.com/images/I/61gA0Y0m9mL._AC_UL320_.jpg', 'Amazon Brand ', '535.00', '0', '22', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS002', '1', '2022-06-23 23:03:26', 'Men\'s Solid Straight Kurta Pyjama Set Cotton', 'https://m.media-amazon.com/images/I/518BCIxk75L._AC_UL320_.jpg', 'STYLEXA', '85.00', '0', '10', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS003', '1', '2022-06-23 23:03:26', 'Men\'s Jacquard Silk Kurta and Pyjama', 'https://m.media-amazon.com/images/I/71o+66lNImL._UL1500_.jpg', 'Jompers', '45.00', '0', '50', '2022-06-23 23:03:26');
INSERT INTO ecommerce.product_info VALUES ('WS007', '1', '2022-07-15 22:04:53', 'Cotton Checkered Casual Slim Fit Shirt', 'https://m.media-amazon.com/images/I/61jnRJpgZOS._UX425_.jpg', 'JAI TEXTILES Men\'s', '999.00', '0', '46', '2022-07-15 22:04:53');
INSERT INTO ecommerce.product_info VALUES ('WS008', '1', '2022-07-15 22:04:53', ' Sports Mode & Sleep Monitor, Gesture,Camera & Music Control, IP68 Dust &...', 'https://m.media-amazon.com/images/I/61OMmLzG0jL._SL1500_.jpg', 'Fire-Boltt Ninja 2 Max 1.5\" Full Touch Display,', '1600.00', '0', '46', '2022-07-15 22:04:53');
INSERT INTO ecommerce.product_info VALUES ('WS009', '1', '2022-07-15 22:04:53', 'Dial Men\'s Watch-1805QM02', 'https://m.media-amazon.com/images/I/714-r1WKC-L._UL1500_.jpg', 'Titan Analog Blue', '2799.00', '0', '46', '2022-07-15 22:04:53');

INSERT INTO ecommerce.product_info VALUES ('PA001', '2', '2022-06-23 23:03:26', 'Four Seater Dinning Table with 3 Chairs & 1 Bench for Home | Dining Room Sets for Restraunts | Sheesham Wood, Honey Brown', 'https://m.media-amazon.com/images/I/61MAzfI+4vL._SX425_.jpg', 'Ramdoot Furniture Wooden Dining Table 4 Seater ', '15273.00', '0', '20', '2022-06-23 23:03:26');

INSERT INTO ecommerce.product_info VALUES ('PA002', '2', '2022-06-23 23:03:26', 'Fixed Speed Split AC (Copper, PM 2.5 Filter, 2022 Model, FTL28U, White)', 'https://images-eu.ssl-images-amazon.com/images/I/21997wd3e4L._AC_SX184_.jpg', 'Daikin 0.8 Ton 3 Star', '35757.00', '0', '21', '2022-07-16 17:36:06');

INSERT INTO ecommerce.product_info VALUES ('PA003', '2', '2022-06-23 23:03:26', 'Basics 564 L Side-by-Side Door Refrigerator (Black Glass Door)', 'https://m.media-amazon.com/images/I/71fa4e1KQsL._AC_UL320_.jpg', 'Door Refrigerator ', '95.00', '0', '11', '2022-07-16 16:34:22');
INSERT INTO ecommerce.product_info VALUES ('PA007', '2', '2022-07-15 22:04:53', 'Refrigerator (Silver, Triple cooling zone, Convertible)', 'https://m.media-amazon.com/images/I/61TDcCsF9CL._SL1500_.jpg', 'AmazonBasics 670 L French', '2499.00', '0', '22', '2022-07-15 22:04:53');
 INSERT INTO ecommerce.product_info VALUES ('PA008', '2', '2022-07-15 22:04:53', '2 Years Warranty on Product and 10 Years on Motor (CRLWMD702STL75, Grey)', 'https://m.media-amazon.com/images/I/71LOdVOg2ML._SY355_.jpg', 'Croma 7.5 kg 5 Star Fully Automatic', '2099.00', '0', '12', '2022-07-15 22:04:53');
 INSERT INTO ecommerce.product_info VALUES ('PA009', '2', '2022-07-15 22:04:53', 'Oven (NN-ST26JMFDG, Silver, 51 Auto Menus)', 'https://m.media-amazon.com/images/I/71Odjpsi1NL._AC_UY218_.jpg', 'Panasonic 20L Solo Microwave', '6090.00', '0', '3', '2022-07-15 22:04:53');


INSERT INTO ecommerce.product_info VALUES ('AF001', '3', '2022-06-23 23:03:26', 'Bluetooth Truly Wireless in Ear Earbuds with Mic (Bold Black)', 'https://m.media-amazon.com/images/I/51HBom8xz7L._SY355_.jpg', 'boAt Airdopes 141 42H', '1490.00', '0', '38', '2022-07-16 17:55:50');

INSERT INTO ecommerce.product_info VALUES ('AF002', '3', '2022-06-23 23:03:26', '2.4 GHz with USB Nano Receiver, Optical Tracking, 12-Months Battery Life, Ambidextrous, PC/Mac/Laptop - Black', 'https://images-eu.ssl-images-amazon.com/images/G/31/img22/pd22/peripherals/price/xcm_banners_6inpd_2022_440x460-product-headline-price-badge-acentsss-vrljy_440x460_in-en.jpg', 'Logitech B170 Wireless Mouse', '76.00', '0', '75', '2022-07-17 09:01:18');

INSERT INTO ecommerce.product_info VALUES ('AF003', '3', '2022-06-23 23:03:26', 'LED Backlit, Anti-Ghosting Keys and Windows Lock Key (Wired) (Black)', 'https://m.media-amazon.com/images/I/61gshB7YIgL._SL1500_.jpg', 'EvoFox Fireblade Gaming Keyboard with Compact', '82.00', '0', '19', '2022-07-17 09:01:07');

INSERT INTO ecommerce.product_info VALUES ('AF007', '3', '2022-07-15 22:04:53', 'FreeSync Premium, HDR 10, HDMI, Tilt, Height, Pivot Stand, VA Panel Gaming Monitor (32GN650)', 'https://m.media-amazon.com/images/I/71PbKy5iBFL._SY355_.jpg', 'LG Ultragear QHD (32 inch / 80 cm) 165 Hz 1ms, Nvidia G-Sync Compatible', '32379.00', '0', '40', '2022-07-15 22:04:53');
  
INSERT INTO ecommerce.product_info VALUES ('AF008', '3', '2022-07-15 22:04:53', 'Fantastic Purple,6GB RAM,128GB Storage) with No Cost EMI/Additional Exchange Offers', 'https://m.media-amazon.com/images/I/71geVdy6-OS._SL1500_.jpg', 'OPPO A74 5G', '43500.00', '0', '35', '2022-07-15 22:04:53');

INSERT INTO ecommerce.product_info VALUES ('AF009', '3', '2022-07-15 22:04:53', ' (Black) with AF-S DX NIKKOR 18-140mm f/3.5-5.6G ED VR Lens', 'https://m.media-amazon.com/images/I/613YqAs5n3L._SL1000_.jpg', 'Nikon D7500 20.9MP Digital SLR Camera (Black) ', '5298.00', '0', '30', '2022-07-15 22:04:53');


INSERT INTO ecommerce.product_info VALUES ('WSH007', '4', '2022-07-15 22:04:53', 'Sports Sweat Resistant Sports Non Slip Elastic Headband Double Anti Slip Sweatband for Yoga Biker Running Cycling Fitness Exercise Unisex Hairband', 'https://m.media-amazon.com/images/I/312Ru7J2-0L.jpg', 'Qenixo® Headband for Men and Women', '852.00', '0', '49', '2022-07-16 17:55:50');
INSERT INTO ecommerce.product_info VALUES ('WSH008', '4', '2022-07-15 22:04:53', 'Sports Headband for Workout & Running, Breathable, Non-Slip Sweat Head Bands for Long Hair - Black', 'https://m.media-amazon.com/images/I/51vrm69CbDL._SY355_.jpg', 'Boldfit Gym Headband for Men and Women', '595.00', '0', '35', '2022-07-15 22:04:53');
INSERT INTO ecommerce.product_info VALUES ('WSH009', '4', '2022-07-15 22:04:53', ' Brand - Symactive', 'https://m.media-amazon.com/images/I/71XLQvgWOdL._AC_UL480_FMwebp_QL65_.jpg', ' Men Sports Shoes Running', '799.00', '0', '25', '2022-07-15 22:04:53');
INSERT INTO ecommerce.product_info VALUES ('WSH010', '4', '2022-07-15 22:04:53', 'BAT - THE STROM BREAKER', 'https://m.media-amazon.com/images/I/51f0DXy0hBL._SL1500_.jpg', 'BAT ', '799.00', '0', '10', '2022-07-15 22:04:53');



INSERT INTO ecommerce.users VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Jabalpur', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');




