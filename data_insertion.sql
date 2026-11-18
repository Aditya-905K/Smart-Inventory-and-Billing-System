INSERT INTO Customers (name, contact)
SELECT
    (ARRAY['Aarav','Vivaan','Aditya','Arjun','Rohan','Karan','Rahul','Amit','Mohit','Nikhil',
           'Sanjay','Vikas','Deepak','Manish','Harsh','Yash','Kunal','Saurabh','Ankit','Pratik',
           'Priya','Ananya','Neha','Pooja','Riya','Sneha','Kavya','Isha','Divya','Shruti',
           'Anjali','Nidhi','Megha','Swati','Komal','Tanvi','Preeti','Ritu','Simran','Payal'])
        [1 + (g * 7 % 40)]
    || ' ' ||
    (ARRAY['Sharma','Verma','Patel','Gupta','Singh','Jain','Mishra','Yadav','Joshi','Kumar',
           'Agrawal','Chauhan','Tiwari','Pandey','Rathore','Solanki','Malviya','Dubey','Saxena','Bhatt',
           'Rajput','Soni','Goyal','Mehta','Thakur'])
        [1 + (g * 3 % 25)] AS name,
    (ARRAY['6','7','8','9','9','9','8','7'])[1 + floor(random()*8)::int]
        || lpad(floor(random()*1000000000)::bigint::text, 9, '0') AS contact
FROM generate_series(1, 100) AS g;


INSERT INTO Products (name, description, price, quantity)
SELECT name, description, price,
       CASE WHEN price > 30000 THEN 3 + floor(random()*13)::int
            WHEN price > 10000 THEN 8 + floor(random()*33)::int
            ELSE 20 + floor(random()*181)::int END
FROM (VALUES
-- Laptops
('Dell Inspiron 15 3520','Intel Core i5-1235U, 16GB RAM, 512GB SSD, 15.6" FHD display, Windows 11',52990.00),
('HP Pavilion 14','AMD Ryzen 5 7530U, 8GB RAM, 512GB SSD, 14" FHD IPS display',54990.00),
('Lenovo IdeaPad Slim 3','Intel Core i3-1315U, 8GB RAM, 512GB SSD, 15.6" FHD display',36990.00),
('ASUS Vivobook 15','Intel Core i5-1335U, 16GB RAM, 512GB SSD, 15.6" FHD display',49990.00),
('Acer Aspire 5','Intel Core i5-1235U, 8GB RAM, 512GB SSD, 15.6" FHD display',44990.00),
('Apple MacBook Air 13 M2','Apple M2 chip, 8GB unified memory, 256GB SSD, 13.6" Liquid Retina display',94990.00),
('MSI Thin GF63','Intel Core i5-12450H, RTX 2050 4GB, 16GB RAM, 512GB SSD, 144Hz display',62990.00),
('ASUS TUF Gaming F15','Ryzen 7 7735HS, RTX 4050 6GB, 16GB RAM, 512GB SSD, 144Hz display',84990.00),
-- Smartphones
('Samsung Galaxy S23 FE 5G','8GB RAM, 128GB storage, 50MP triple camera, 6.4" AMOLED 120Hz display',39999.00),
('OnePlus Nord CE 4 5G','8GB RAM, 128GB storage, Snapdragon 7 Gen 3, 100W fast charging',24999.00),
('Redmi Note 13 Pro 5G','8GB RAM, 128GB storage, 200MP camera, 6.67" AMOLED display',23999.00),
('realme Narzo 70 Pro 5G','8GB RAM, 128GB storage, Sony IMX890 OIS camera, 67W charging',19999.00),
('Apple iPhone 15','128GB storage, A16 Bionic chip, 48MP main camera, USB-C',69900.00),
('Google Pixel 8a','8GB RAM, 128GB storage, Tensor G3, 64MP camera, 7 years of updates',52999.00),
('Motorola Edge 50 Fusion','8GB RAM, 128GB storage, 6.7" pOLED 144Hz display, 68W charging',22999.00),
('Vivo T3 5G','8GB RAM, 128GB storage, Dimensity 7200, 50MP Sony camera, 5000mAh battery',19999.00),
('iQOO Z9 5G','8GB RAM, 256GB storage, Dimensity 7200, 50MP OIS camera, 44W charging',21999.00),
('POCO X6 Pro 5G','8GB RAM, 256GB storage, Dimensity 8300 Ultra, 64MP OIS camera',24999.00),
-- Tablets
('Samsung Galaxy Tab A9+','11" 90Hz display, 4GB RAM, 64GB storage, quad speakers, Wi-Fi',17999.00),
('Apple iPad 10th Generation','10.9" Liquid Retina display, A14 Bionic chip, 64GB, Wi-Fi',34900.00),
('Lenovo Tab M10 Plus 3rd Gen','10.61" 2K display, 4GB RAM, 128GB storage, Dolby Atmos speakers',15999.00),
('Xiaomi Pad 6','11" 2.8K 144Hz display, Snapdragon 870, 6GB RAM, 128GB storage',25999.00),
-- Monitors
('Dell SE2422H 24-inch Monitor','23.8" FHD VA panel, 75Hz refresh rate, AMD FreeSync, HDMI and VGA',8499.00),
('LG 24MP60G 24-inch Monitor','23.8" FHD IPS panel, 75Hz, AMD FreeSync, HDMI and DisplayPort',9999.00),
('Samsung Odyssey G3 27-inch','27" FHD VA panel, 165Hz, 1ms response time, FreeSync Premium',17999.00),
('BenQ GW2480 24-inch','23.8" FHD IPS panel, eye-care technology, brightness intelligence, HDMI and DP',10499.00),
('Acer Nitro VG240Y','23.8" FHD IPS panel, 165Hz, 1ms VRB, AMD FreeSync Premium',11999.00),
('HP M27fw 27-inch','27" FHD IPS panel, 75Hz, built-in speakers, ultra-thin borderless design',13999.00),
-- Keyboards
('Logitech K380 Bluetooth Keyboard','Multi-device wireless keyboard, pairs with 3 devices, compact slim design',2995.00),
('Logitech MK270 Wireless Combo','Wireless keyboard and mouse with 2.4GHz receiver, 8 hotkeys, long battery life',1495.00),
('Keychron K2 V2 Wireless Mechanical','75% layout, Gateron Brown switches, Bluetooth 5.1, white backlight',8499.00),
('Redragon K552 Kumara','TKL mechanical keyboard, blue switches, red backlight, metal base',2799.00),
('HP K500F Backlit Gaming Keyboard','Membrane keyboard with 7-color backlight, 104 keys, spill-resistant',1199.00),
('Dell KB216 Wired Keyboard','Full-size USB keyboard, quiet keys, spill-resistant design',649.00),
-- Mice
('Logitech MX Master 3S','Wireless performance mouse, 8000 DPI, MagSpeed scroll wheel, USB-C charging',9995.00),
('Logitech M331 Silent Plus','Wireless mouse with 90% less click noise, 1000 DPI, 24-month battery life',1295.00),
('Razer DeathAdder Essential','Wired gaming mouse, 6400 DPI optical sensor, ergonomic right-hand design',1999.00),
('HP S1000 Plus Silent Mouse','Wireless silent-click mouse, 2.4GHz, 1600 DPI, slim design',599.00),
('Dell MS116 Wired Mouse','USB optical mouse, 1000 DPI, 3 buttons, plug and play',349.00),
('Logitech G102 Lightsync','Wired gaming mouse, 8000 DPI, RGB lighting, 6 programmable buttons',1495.00),
-- Headphones, earbuds and speakers
('Sony WH-1000XM5','Wireless noise cancelling headphones, 30-hour battery, multipoint Bluetooth',29990.00),
('boAt Rockerz 450','Bluetooth on-ear headphones, 40mm drivers, up to 15 hours playback',1499.00),
('JBL Tune 760NC','Wireless over-ear headphones with active noise cancellation, 50-hour battery',5999.00),
('Apple AirPods Pro 2nd Generation','Active noise cancellation, adaptive transparency, USB-C MagSafe case',24900.00),
('Samsung Galaxy Buds2 Pro','24-bit Hi-Fi audio, intelligent ANC, IPX7 water resistance',11999.00),
('OnePlus Buds Z2','Active noise cancellation, 11mm drivers, 38-hour total playback',4999.00),
('Noise Buds VS104','True wireless earbuds, 45-hour playtime, quad mic ENC, instacharge',999.00),
('boAt Airdopes 141','True wireless earbuds, 42-hour playback, ENx technology, IPX4',1299.00),
('JBL Flip 6','Portable waterproof Bluetooth speaker, 12-hour battery, IP67 rated',9999.00),
('boAt Stone 352','Portable Bluetooth speaker, 10W output, 12-hour playback, IPX7',1799.00),
('Sony SRS-XB13','Compact wireless speaker with Extra Bass, IP67, 16-hour battery',3990.00),
('Mi Portable Bluetooth Speaker 16W','Stereo sound, IPX7 waterproof, 13-hour battery, TWS pairing',1999.00),
('Zebronics Juke Bar 9500 Pro','Dolby Atmos soundbar with wireless subwoofer, 525W output',5999.00),
-- Webcams
('Logitech C270 HD Webcam','720p HD video calling, built-in mic, automatic light correction',2495.00),
('Logitech C920 HD Pro Webcam','1080p Full HD video calling, dual stereo microphones, autofocus',6495.00),
('Zebronics Ultimate Pro Webcam','Full HD 1080p webcam, built-in mic, USB plug and play, tripod-ready',1699.00),
-- Storage
('Samsung 980 NVMe SSD 500GB','M.2 NVMe PCIe 3.0, up to 3100MB/s read speed, 5-year warranty',4499.00),
('WD Blue SN580 1TB NVMe SSD','PCIe Gen4 M.2 SSD, up to 4150MB/s read speed',6499.00),
('Crucial MX500 500GB SATA SSD','2.5" SATA III internal SSD, up to 560MB/s read speed',4299.00),
('Seagate Barracuda 2TB Hard Drive','3.5" internal HDD, 7200 RPM, 256MB cache, SATA 6Gb/s',4999.00),
('WD Elements 1TB Portable HDD','USB 3.0 external hard drive, plug and play, compatible with Windows',4699.00),
('Seagate One Touch 2TB Portable HDD','USB 3.0 external hard drive with password protection, 2-year data recovery',6799.00),
('SanDisk Ultra Dual Drive 64GB','USB 3.0 flash drive with Type-C and Type-A connectors, up to 150MB/s',799.00),
('SanDisk Ultra Flair 128GB Pen Drive','USB 3.0 pen drive with up to 150MB/s read speed, metal casing',1299.00),
('Samsung EVO Plus 128GB microSD','microSDXC card with adapter, up to 130MB/s, A2 rated',1099.00),
('SanDisk Extreme PRO 256GB microSD','UHS-I U3 V30 A2, up to 200MB/s read, ideal for 4K video',3299.00),
-- Networking
('TP-Link Archer C6 AC1200','Dual-band Wi-Fi router, Gigabit ports, 4 antennas, MU-MIMO',2299.00),
('TP-Link Archer AX23 AX1800','Wi-Fi 6 dual-band router, OFDMA, 1.5GHz CPU, 4 antennas',3499.00),
('D-Link DIR-615 N300','Wireless N300 router with 4 LAN ports, WPS button, easy setup',899.00),
('Tenda AC10 AC1200','Smart dual-band Gigabit Wi-Fi router, 4 external antennas',1999.00),
('TP-Link TL-WN725N Nano USB Adapter','150Mbps wireless N nano USB adapter, SoftAP mode',499.00),
('TP-Link TL-SG1008D 8-Port Switch','Unmanaged gigabit desktop network switch, plug and play',1099.00),
-- Power banks, chargers, cables
('Mi 20000mAh Power Bank 3i','18W fast charging, dual input, triple output, 12-layer protection',2199.00),
('Anker 321 Power Bank 10000mAh','12W PowerCore, compact size, PowerIQ technology, dual USB output',2499.00),
('Ambrane 10000mAh Stylo Power Bank','20W fast charging with Type-C PD, slim design',1099.00),
('Anker 735 Nano II 65W Charger','GaN II fast charger with 3 ports, charges laptop and phone together',4999.00),
('Apple 20W USB-C Power Adapter','Fast charging adapter for iPhone and iPad',1900.00),
('Samsung 25W USB-C Charger','Super fast charging wall adapter with Type-C cable',1299.00),
('Anker PowerLine III USB-C Cable 1.8m','USB-C to USB-C cable, 60W charging, 18-month warranty',1499.00),
('Amazon Basics HDMI Cable 1.8m','High-speed HDMI 2.0 cable, supports 4K at 60Hz, gold-plated connectors',599.00),
('Portronics Konnect L Type-C Cable','1.2m braided fast charging and data sync cable',299.00),
('Belkin 6-Socket Surge Protector','1.5m cord, 4000A surge protection, built-in fuse, 6 sockets',1299.00),
-- Printers and ink
('HP Smart Tank 580 All-in-One','Ink tank printer, print/scan/copy, Wi-Fi, auto-duplex',15999.00),
('Canon PIXMA G2010','Refillable ink tank printer, print/scan/copy, up to 6000 black pages per refill',11999.00),
('Epson EcoTank L3250','Wi-Fi ink tank all-in-one printer, print/scan/copy, spill-free refill',14999.00),
('HP 805 Black Original Ink Cartridge','Original ink cartridge for DeskJet 2332 and 2722 printers',849.00),
-- Smartwatches
('Apple Watch SE 2nd Generation 40mm','GPS, crash detection, heart rate monitoring, aluminium case',29900.00),
('Noise ColorFit Pro 5','1.85" AMOLED display, Bluetooth calling, 7-day battery, AI health tracking',3999.00),
('boAt Wave Call 2','1.83" HD display, Bluetooth calling, 700+ active modes, IP68',1999.00),
('Fire-Boltt Ninja Call Pro Plus','1.83" display, Bluetooth calling, voice assistant, 120+ sports modes',1499.00),
-- Accessories
('American Tourister Rogue Laptop Backpack','Fits up to 15.6" laptops, water-resistant, padded compartment, 32L',1999.00),
('Portronics My Buddy Plus Laptop Stand','Adjustable foldable stand with phone holder, supports up to 15.6" laptops',1099.00),
('Cooler Master NotePal X3 Cooling Pad','200mm silent fan, supports up to 17" laptops, adjustable height',2499.00),
('Ugreen 5-in-1 USB-C Hub','4K HDMI, 2 USB 3.0 ports, SD/TF card reader, aluminium body',2299.00),
('Redragon P016 Extended Mouse Pad','Large 800x300mm stitched-edge pad, non-slip rubber base',899.00),
-- Gaming and cameras
('Sony DualSense Wireless Controller','PS5 controller with haptic feedback and adaptive triggers',5990.00),
('Logitech G435 Lightspeed Headset','Wireless gaming headset, 18-hour battery, 165g lightweight design',5495.00),
('HyperX Cloud Stinger Core','Wired gaming headset, 40mm drivers, noise-cancelling mic, lightweight',3499.00),
('GoPro HERO12 Black','5.3K60 video, HyperSmooth 6.0 stabilization, waterproof to 10m',38990.00),
('TP-Link Tapo C200 Security Camera','1080p pan/tilt Wi-Fi camera, night vision, two-way audio, motion detection',2299.00)
) AS t(name, description, price);

INSERT INTO Sales (customer_id, date, total_amount)
SELECT
    (SELECT id FROM Customers WHERE g IS NOT NULL ORDER BY random() LIMIT 1),
    CURRENT_DATE - floor(random()*365)::int,
    0
FROM generate_series(1, 100) AS g;

INSERT INTO sale_items (sale_id, product_id, quantity, price)
SELECT
    s.id,
    p.id,
    1 + floor(power(random(), 2) * 4)::int,
    p.price
FROM Sales s
CROSS JOIN LATERAL (
    SELECT id, price
    FROM Products
    WHERE s.id IS NOT NULL
    ORDER BY random()
    LIMIT 1 + (s.id * 7 % 4)
) p;


select * from sale_items;
select * from sales;
select * from customers;
select * from products;