WITH clean_auth AS (
    SELECT 
        uid,
        DATE(FROM_UNIXTIME(auth_ts)) AS auth_date
    FROM auth_data
    WHERE auth_ts IS NOT NULL
)
SELECT DISTINCT 
    uid, 
    auth_date
FROM clean_auth;


