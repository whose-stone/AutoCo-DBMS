-- CSC 411/511 - Required Client Queries
USE auto_company;

-- Q1a: Sales trends by brand by YEAR
SELECT b.brand_name, YEAR(s.sale_date) AS sale_year, COUNT(*) AS units_sold, SUM(s.sale_price) AS total_revenue
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id JOIN brand b ON m.brand_id=b.brand_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY b.brand_name, YEAR(s.sale_date) ORDER BY b.brand_name, sale_year;

-- Q1b: Sales trends by brand by MONTH
SELECT b.brand_name, YEAR(s.sale_date) AS yr, MONTH(s.sale_date) AS mo, COUNT(*) AS units, SUM(s.sale_price) AS revenue
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id JOIN brand b ON m.brand_id=b.brand_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY b.brand_name, yr, mo ORDER BY b.brand_name, yr, mo;

-- Q1c: Sales trends by brand by WEEK
SELECT b.brand_name, YEAR(s.sale_date) AS yr, WEEK(s.sale_date) AS wk, COUNT(*) AS units, SUM(s.sale_price) AS revenue
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id JOIN brand b ON m.brand_id=b.brand_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY b.brand_name, yr, wk ORDER BY b.brand_name, yr, wk;

-- Q1d: Sales by GENDER
SELECT b.brand_name, YEAR(s.sale_date) AS yr, c.gender, COUNT(*) AS units, SUM(s.sale_price) AS revenue
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id JOIN brand b ON m.brand_id=b.brand_id JOIN customer c ON s.customer_id=c.customer_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY b.brand_name, yr, c.gender ORDER BY b.brand_name, yr, c.gender;

-- Q1e: Sales by INCOME RANGE
SELECT b.brand_name, YEAR(s.sale_date) AS yr,
  CASE WHEN c.annual_income<50000 THEN 'Under $50K' WHEN c.annual_income<100000 THEN '$50K-$99K' WHEN c.annual_income<200000 THEN '$100K-$199K' ELSE '$200K+' END AS income_range,
  COUNT(*) AS units, SUM(s.sale_price) AS revenue
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id JOIN brand b ON m.brand_id=b.brand_id JOIN customer c ON s.customer_id=c.customer_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY b.brand_name, yr, income_range ORDER BY b.brand_name, yr, income_range;

-- Q2: Getrag defective transmissions - find VIN and customer
SELECT v.vin, c.first_name, c.last_name, c.phone, c.email, sp.supplier_plant_location AS getrag_plant, v.transmission
FROM vehicle v JOIN model_part mp ON v.model_id=mp.model_id JOIN supplier_part sp ON mp.part_id=sp.part_id
JOIN supplier sup ON sp.supplier_id=sup.supplier_id JOIN sale s ON v.vin=s.vin JOIN customer c ON s.customer_id=c.customer_id
WHERE sup.supplier_name='Getrag' AND v.manufacture_date BETWEEN '2023-01-01' AND '2024-06-30' ORDER BY v.vin;

-- Q2 variant: only from one Getrag plant
SELECT v.vin, c.first_name, c.last_name, c.phone, sp.supplier_plant_location
FROM vehicle v JOIN model_part mp ON v.model_id=mp.model_id JOIN supplier_part sp ON mp.part_id=sp.part_id
JOIN supplier sup ON sp.supplier_id=sup.supplier_id JOIN sale s ON v.vin=s.vin JOIN customer c ON s.customer_id=c.customer_id
WHERE sup.supplier_name='Getrag' AND sp.supplier_plant_location='Untergruppenbach Plant A' AND v.manufacture_date BETWEEN '2023-01-01' AND '2024-06-30';

-- Q3: Top 2 brands by dollar amount (past year)
SELECT b.brand_name, SUM(s.sale_price) AS total_dollar_sales
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id JOIN brand b ON m.brand_id=b.brand_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY b.brand_name ORDER BY total_dollar_sales DESC LIMIT 2;

-- Q4: Top 2 brands by unit sales (past year)
SELECT b.brand_name, COUNT(*) AS total_units_sold
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id JOIN brand b ON m.brand_id=b.brand_id
WHERE s.sale_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR) GROUP BY b.brand_name ORDER BY total_units_sold DESC LIMIT 2;

-- Q5: Best month(s) for convertible sales
SELECT MONTH(s.sale_date) AS sale_month, MONTHNAME(s.sale_date) AS month_name, COUNT(*) AS convertibles_sold
FROM sale s JOIN vehicle v ON s.vin=v.vin JOIN model m ON v.model_id=m.model_id
WHERE m.body_style='convertible' GROUP BY MONTH(s.sale_date), MONTHNAME(s.sale_date) ORDER BY convertibles_sold DESC;

-- Q6: Dealers with longest average inventory time
SELECT d.dealer_name, d.city, d.state, ROUND(AVG(DATEDIFF(COALESCE(di.date_sold,CURDATE()),di.date_received)),1) AS avg_days, COUNT(*) AS total_vehicles
FROM dealer_inventory di JOIN dealer d ON di.dealer_id=d.dealer_id GROUP BY d.dealer_id, d.dealer_name, d.city, d.state ORDER BY avg_days DESC;
