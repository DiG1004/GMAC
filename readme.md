# 🎮 Mobile Game Telemetry & A/B Testing Analytics

## 📌 Business Context & Project Goals
Dự án phân tích dữ liệu chuyên sâu dựa trên dữ liệu telemetry thực tế từ mobile game (*Gamelytics Challenge*). Mục tiêu chính là đánh giá hiệu quả giữ chân người chơi (**Cohort Retention**) và thử nghiệm tính năng thương mại hóa (**Monetization A/B Testing**), từ đó đưa ra các đề xuất tối ưu sản phẩm dựa trên dữ liệu (Data-Driven Decisions).

---

## 🛠️ Tech Stack & Methodology
* **Programming & Libraries:** Python (Pandas, NumPy, Matplotlib, Seaborn, SciPy).
* **Database & Querying:** SQL (ANSI SQL / MySQL dialect, CTEs, Window Functions).
* **Statistical Testing:** 
  * Chi-Square Test of Independence & Goodness-of-Fit (SRM & Conversion Rate).
  * Mann-Whitney U Test (Doanh thu phân phối không chuẩn).
  * Bootstrap Resampling (2,000 iterations cho khoảng tin cậy 95% Delta ARPU).
* **Version Control:** Git, GitHub (`.gitignore` chuẩn cho dự án Data Science).

---

## 📊 Business Metrics & Analytical Workflow

### 1. Data Profiling & Quality Audit (`01_data_cleaning_and_validation.ipynb`)
* **Time Normalization:** Chuyển đổi Unix timestamp về mốc `datetime64` đồng nhất.
* **Data Sanity Check:** Rà soát và xử lý tài khoản ma (ghost users) và lỗi nghịch lý thời gian đăng nhập trước ngày đăng ký (`auth_date < reg_date`).
* **Granularity Adjustment:** Khử trùng lặp phiên đăng nhập trong ngày để chuẩn hóa dữ liệu tính DAU và Retention.

### 2. Cohort Retention & Engagement Deep-dive (`02_cohort_retention_deepdive.ipynb`)
* **Retention Matrix & Heatmap:** Xây dựng ma trận tam giác giữ chân từ Day 0 đến Day 30 cho các nhóm thuần tập.
* **Benchmark 40-20-10:** Đánh giá độ dốc đường cong giữ chân so với tiêu chuẩn ngành Mobile Game (Casual/Midcore).
* **Stickiness Ratio ($\frac{\text{DAU}}{\text{MAU}}$):** Theo dõi chỉ số bám dính để đo lường thói quen mở game hàng ngày của tập người chơi cốt lõi.

### 3. A/B Testing & Monetization Analysis (`03_ab_testing_monetization.ipynb`)
* **Sample Ratio Mismatch (SRM):** Kiểm định phân bổ mẫu $1:1$ đảm bảo không bị lỗi phân luồng kỹ thuật ($p \ge 0.01$).
* **Monetization Funnel:** Phân tích CR (Conversion Rate), ARPU (Average Revenue Per User) và ARPPU (Average Revenue Per Paying User).
* **Non-parametric & Bootstrap Testing:** Xây dựng khoảng tin cậy 95% (95% CI) cho chênh lệch ARPU giữa hai biến thể để đưa ra quyết định Rollout hay Rollback.

---

## 📂 Repository Structure
```text
GMAC/
├── data/
│   ├── raw/               # (Git-ignored) Dữ liệu thô gốc (reg_data.csv, auth_data.csv, ab_test.csv)
│   └── processed/         # Dữ liệu sạch đã nắn chỉnh (cleaned_reg_data.csv, cleaned_auth_daily.csv)
├── notebooks/
│   ├── 01_data_cleaning_and_validation.ipynb
│   ├── 02_cohort_retention_deepdive.ipynb
│   └── 03_ab_testing_monetization.ipynb
├── sql/
│   ├── 01_data_cleaning_and_deduplication.sql
│   ├── 02_cohort_retention_matrix.sql
│   └── 03_ab_test_metrics.sql
├── .gitignore
└── README.md