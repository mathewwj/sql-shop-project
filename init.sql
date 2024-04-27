INSERT INTO CATEGORIES VALUES (1, 'Beverages', 'Beverages');
INSERT INTO CATEGORIES VALUES (2, 'Bread', 'Bread');
INSERT INTO CATEGORIES VALUES (3, 'Canned', 'Canned');
INSERT INTO CATEGORIES VALUES (4, 'Dairy', 'Dairy');
INSERT INTO CATEGORIES VALUES (5, 'Meat', 'Meat');

INSERT INTO PRODUCTS(id, name, category_id, quantity, price) VALUES (1, 'Cola', 1, 10, 1.20);
INSERT INTO PRODUCTS(id, name, category_id, quantity, price) VALUES (2, 'Bead', 2, 15, 1.50);
INSERT INTO PRODUCTS(id, name, category_id, quantity, price) VALUES (3, 'Beans', 3, 4, 0.70);
INSERT INTO PRODUCTS(id, name, category_id, quantity, price) VALUES (4, 'Milk', 4, 100, 1.00);
INSERT INTO PRODUCTS(id, name, category_id, quantity, price) VALUES (5, 'Beef 500g', 5, 6, 4.50);

INSERT INTO REGALS VALUES (1, 10, 10, 20, 20);
INSERT INTO REGALS VALUES (2, 50, 50, 70, 80);
INSERT INTO REGALS VALUES (3, 30, 30, 40, 40);

INSERT INTO REGAL_PRODUCT VALUES (1, 1, 5); -- 5x Cola
INSERT INTO REGAL_PRODUCT VALUES (2, 4, 4); -- 4x Milk
INSERT INTO REGAL_PRODUCT VALUES (2, 5, 3); -- 3x Beef
INSERT INTO REGAL_PRODUCT VALUES (3, 1, 5); -- 5x Cola
INSERT INTO REGAL_PRODUCT VALUES (3, 3, 1); -- 2x Beans

