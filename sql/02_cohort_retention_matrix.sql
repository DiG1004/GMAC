WITH user_cohorts AS (
    SELECT 
        uid,
        DATE(FROM_UNIXTIME(reg_ts)) AS reg_date
    FROM reg_data
),
daily_activity AS (
    SELECT DISTINCT 
        uid,
        DATE(FROM_UNIXTIME(auth_ts)) AS auth_date
    FROM auth_data
),
cohort_merged AS (
    SELECT 
        c.uid,
        c.reg_date,
        a.auth_date,
        DATEDIFF(day, c.reg_date, a.auth_date) AS days_since_reg
    FROM user_cohorts c
    INNER JOIN daily_activity a ON c.uid = a.uid
    WHERE a.auth_date >= c.reg_date
),
cohort_sizes AS (
    SELECT 
        reg_date,
        COUNT(DISTINCT uid) AS cohort_size
    FROM user_cohorts
    GROUP BY reg_date
)
SELECT 
    cm.reg_date AS cohort_group,
    cs.cohort_size,
    cm.days_since_reg,
    COUNT(DISTINCT cm.uid) AS retained_users,
    ROUND(COUNT(DISTINCT cm.uid) * 100.0 / cs.cohort_size, 2) AS retention_rate_pct
FROM cohort_merged cm
JOIN cohort_sizes cs ON cm.reg_date = cs.reg_date
GROUP BY cm.reg_date, cs.cohort_size, cm.days_since_reg
ORDER BY cm.reg_date DESC, cm.days_since_reg ASC;