drop table regal_product;
drop table regals;
drop table products;
drop table categories;

drop sequence seq_categories_id;
drop sequence seq_products_id;
drop sequence seq_regals_id;

CREATE TABLE categories (
    id NUMBER CONSTRAINT pk_categories_id PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(100)
);

CREATE TABLE products (
    id NUMBER CONSTRAINT pk_products_id PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    category_id NUMBER CONSTRAINT fk_category_id REFERENCES categories(id),
    desc_url VARCHAR2(200),
    image_url VARCHAR2(200),
    price NUMBER(10, 2) NOT NULL,
    quantity NUMBER DEFAULT 0
);

CREATE TABLE regals (
    id NUMBER CONSTRAINT pk_regals_id PRIMARY KEY,
    x0 NUMBER NOT NULL,
    y0 NUMBER NOT NULL,
    x1 NUMBER NOT NULL,
    y1 NUMBER NOT NULL
);

CREATE TABLE regal_product (
    regal_id NUMBER CONSTRAINT fk_regal_id REFERENCES regals(id),
    product_id NUMBER CONSTRAINT fk_product_id REFERENCES products(id),
    quantity NUMBER NOT NULL,
    CONSTRAINT pk_product_regal PRIMARY KEY (product_id, regal_id)
);

-- SEQUENCES
CREATE SEQUENCE seq_categories_id start with 100;
CREATE SEQUENCE seq_products_id start with 100;
CREATE SEQUENCE seq_regals_id start with 100;

--TRIGGERS
CREATE OR REPLACE TRIGGER regal_count_check AFTER INSERT OR UPDATE ON regal_product
DECLARE
    CURSOR regal_cursor IS select product_id, sum(quantity) as qsum from regal_product group by product_id;
    regal_count NUMBER;
    total_count NUMBER;
BEGIN
    for record in regal_cursor LOOP
        regal_count := record.qsum;
        SELECT quantity INTO total_count FROM products WHERE id = record.product_id;
        IF regal_count > total_count THEN
            RAISE_APPLICATION_ERROR(-20001, 'Total quantity in regals exceeds total quantity');
        end if;
    end loop;
END;
/

CREATE OR REPLACE TRIGGER product_count_check AFTER UPDATE ON products FOR EACH ROW
DECLARE
    regal_count NUMBER;
BEGIN
    SELECT sum(quantity) INTO regal_count from regal_product where product_id = :new.id group by product_id;
    IF regal_count > :new.quantity THEN
        RAISE_APPLICATION_ERROR(-20001, 'Total quantity in regals exceeds total quantity');
    end if;
END;
/


-- get all products, which are in multiple regals
SELECT id, name, multiple_regals.regal_count FROM products JOIN
    (SELECT product_id, count(product_id) as regal_count FROM regal_product GROUP BY product_id having count(product_id) >= 2)  multiple_regals
    on products.id = multiple_regals.product_id;

-- get all products, which are in regals less than 50%
SELECT id, name, NVL(qty_in_regs, 0) as products_in_regals, NVL(qty_in_regs, 0) / quantity * 100 as products_in_regals_percent
    FROM products LEFT OUTER JOIN
        (select product_id, sum(quantity) as qty_in_regs from regal_product group by product_id) reg
        on products.id = reg.product_id
    WHERE quantity * 0.5 > NVL(qty_in_regs, 0)
    ORDER BY products_in_regals_percent;
