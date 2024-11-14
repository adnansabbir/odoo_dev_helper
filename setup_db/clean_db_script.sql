UPDATE ir_cron SET active='f'; -- Disable the crons
UPDATE ir_mail_server SET active=false; -- Disable email servers
UPDATE ir_config_parameter SET value = '2042-01-01 00:00:00' WHERE key = 'database.expiration_date'; -- Set the enterprise expiration date some time far away
UPDATE ir_config_parameter SET value = '"+new_uuid+"' WHERE key = 'database.uuid'; -- Change the serial number of the database so you do not send to www.odoo.com information on the behalf of the production database
INSERT INTO ir_mail_server(active,name,smtp_host,smtp_port,smtp_encryption) VALUES (true,'mailcatcher','localhost',1025,false);  -- Add a mailcatcher server email to catch all outgoing emails
UPDATE res_users SET password=login; -- Replace users password by their login
-- DELETE FROM ir_attachment WHERE name like '%assets_%'; -- Delete assets so they are re-generated when you access the database the first time
UPDATE res_users SET password='admin',active=true where id=2;
UPDATE res_users SET login='admin' where id=2;
UPDATE res_users SET totp_secret=NULL;
