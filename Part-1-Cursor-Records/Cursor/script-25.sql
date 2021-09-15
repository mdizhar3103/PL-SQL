-- Commit & Rollback

BEGIN
    UPDATE departments SET dept_name = 'Marketing'
    WHERE dept_id = 2;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN 
        ROLLBACK;
END;
