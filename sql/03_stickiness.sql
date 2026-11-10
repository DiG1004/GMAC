-- Tính toán chỉ số Conversion Rate, ARPU và ARPPU theo nhóm thử nghiệm
SELECT 
    "group",
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT CASE WHEN revenue > 0 THEN user_id END) AS paying_users,
    ROUND(COUNT(DISTINCT CASE WHEN revenue > 0 THEN user_id END) * 100.0 / COUNT(DISTINCT user_id), 2) AS conversion_rate_pct,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(revenue), 2) AS arpu,
    ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT CASE WHEN revenue > 0 THEN user_id END), 0), 2) AS arppu
FROM ab_test_data
GROUP BY "group";