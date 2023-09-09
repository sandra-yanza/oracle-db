-- ####################################
-- Sandra Isabel Yanza Hernandez
-- ####################################


--  ###### Script to create "invoices_sandra" table
-- DROP TABLE invoices_sandra;
CREATE TABLE invoices_sandra
( 
    invoice_id        NUMBER(8,0)  CONSTRAINT C_PK_INVOICE primary key, 
    vendor_id         NUMBER(8,0) CONSTRAINT C_VENDOR_NN NOT NULL, 
    invoice_number    VARCHAR2(50) CONSTRAINT C_INVOICENU_NN NOT NULL, 
    invoice_date      DATE  CONSTRAINT C_INVOICEDA_NN NOT NULL, 
    invoice_total     NUMBER(8,2)   CONSTRAINT C_INVOICETO_NN NOT NULL, 
    payment_total     NUMBER(8,2)   DEFAULT 0, 
    credit_total      NUMBER(8,2)   DEFAULT 0, 
    terms_id          NUMBER(8,0) CONSTRAINT C_TERMS NOT NULL, 
    invoice_due_date  DATE  CONSTRAINT C_INVODUE_NN NOT NULL, 
    payment_date      DATE  
) ;

-- INSERT INTO invoices 
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,
invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(1,34,'QP58872',TO_DATE('25-FEB-14','DD-MON-RR'),116.54,116.54,0,4,TO_DATE('22-APR-14','DD-MON-RR'),TO_DATE('11-APR-14','DD-MON-RR'));

INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(2,34,'Q545443',TO_DATE('14-MAR-14','DD-MON-RR'),1083.58,1083.58,0,4,TO_DATE('23-MAY-14','DD-MON-RR'),TO_DATE('14-MAY-14','DD-MON-RR'));
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(3,110,'P-0608',TO_DATE('11-APR-14','DD-MON-RR'),20551.18,0,1200,5,TO_DATE('30-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(4,110,'P-0259',TO_DATE('16-APR-14','DD-MON-RR'),26881.4,26881.4,0,3,TO_DATE('16-MAY-14','DD-MON-RR'),TO_DATE('12-MAY-14','DD-MON-RR'));
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(5,81,'MABO1489',TO_DATE('16-APR-14','DD-MON-RR'),936.93,936.93,0,3,TO_DATE('16-MAY-14','DD-MON-RR'),TO_DATE('13-MAY-14','DD-MON-RR'));
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(6,122,'989319-497',TO_DATE('17-APR-14','DD-MON-RR'),2312.2,0,0,4,TO_DATE('26-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(7,82,'C73-24',TO_DATE('17-APR-14','DD-MON-RR'),600,600,0,2,TO_DATE('10-MAY-14','DD-MON-RR'),TO_DATE('05-MAY-14','DD-MON-RR'));
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(8,122,'989319-487',TO_DATE('18-APR-14','DD-MON-RR'),1927.54,0,0,4,TO_DATE('19-JUN-14','DD-MON-RR'),null);
INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,credit_total,terms_id,invoice_due_date,payment_date) 
VALUES 
(9,122,'989319-477',TO_DATE('19-APR-14','DD-MON-RR'),2184.11,2184.11,0,4,TO_DATE('12-JUN-14','DD-MON-RR'),TO_DATE('07-JUN-14','DD-MON-RR'));


commit;
SELECT * FROM invoices_sandra;


--  ###### Script to create "sandra_invoices_audit" table
-- DROP TABLE sandra_invoices_audit;
CREATE TABLE sandra_invoices_audit
( 
    vendor_id        NUMBER(8,0) CONSTRAINT C_VENDORAUDI_NN NOT NULL, 
    invoice_number   VARCHAR2(50) CONSTRAINT C_INVOICENUAU_NN NOT NULL, 
    invoice_total    NUMBER(8,2)   CONSTRAINT C_INVOICETOAUD_NN NOT NULL, 
    action_type      VARCHAR2(50)  CONSTRAINT C_TYPEAU_NN NOT NULL, 
    action_date      DATE  DEFAULT CURRENT_DATE NOT NULL,
    action_time      TIMESTAMP  DEFAULT CURRENT_TIMESTAMP NOT NULL 
) ;

SELECT * FROM sandra_invoices_audit;

--#############
--create the Row Level Trigger to fire when Insert Operation is done 
--on "invoices_sandra" table. Then the table "sandra_invoices_audit" 
--should be updated automatically by the trigger.
--##############

CREATE OR REPLACE TRIGGER sandra_after_trig
AFTER INSERT ON invoices_sandra
FOR EACH ROW 
DECLARE
    v_event sandra_invoices_audit.action_type%TYPE;
BEGIN
    v_event := 'INSERTED';
    INSERT INTO sandra_invoices_audit(vendor_id, invoice_number,
                                invoice_total, action_type, action_date, action_time)
        VALUES(:NEW.vendor_id, :NEW.invoice_number, :NEW.invoice_total,
        v_event, SYSDATE, SYSTIMESTAMP);
END;



INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,
credit_total,terms_id,invoice_due_date,payment_date)
VALUES(10,122,'989319-477',TO_DATE('15-JUN-23','DD-MON-RR'),
2184.11,2184.11,0,4,TO_DATE('30-JUN-23','DD-MON-RR'),
TO_DATE('29-JUN-23','DD-MON-RR'));

INSERT INTO invoices_sandra 
(invoice_id,vendor_id,invoice_number,invoice_date,invoice_total,payment_total,
credit_total,terms_id,invoice_due_date,payment_date)
VALUES(11,133,'666666-222',TO_DATE('26-MAY-23','DD-MON-RR'),
7654.11,8328.11,0,4,TO_DATE('30-DEC-23','DD-MON-RR'),
TO_DATE('18-JUN-23','DD-MON-RR'));

COMMIT;

SELECT * FROM invoices_sandra;

--Check the audit table 
SELECT * FROM sandra_invoices_audit;










