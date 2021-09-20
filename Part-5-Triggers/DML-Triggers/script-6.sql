SELECT * FROM items;
UPDATE items set item_value = item_value * 1.10 WHERE item_id in (1,2);

ALTER TRIGGER items_bs_upd_trig DISABLE;
UPDATE items set item_value = item_value * 1.10 WHERE item_id in (1,2);

ALTER TRIGGER items_bs_upd_trig ENABLE;
UPDATE items set item_value = item_value * 1.10 WHERE item_id in (1,2);

ALTER TABLE items DISABLE ALL TRIGGERS;
UPDATE items set item_value = item_value * 1.10 WHERE item_id in (1,2);

ALTER TABLE items ENABLE ALL TRIGGERS;
UPDATE items set item_value = item_value * 1.10 WHERE item_id in (1,2);
