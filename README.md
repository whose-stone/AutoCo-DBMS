# CSC 411/511 Course Project - Option 2: Automobile Company
## AutoCo Database Management System

**Student:** Stone Barnard  
**Course:** CSC 511  
**Due Date:** April 25, 2026

---

## Project Structure

```
auto_dealer_project/
├── README.md                    (this file)
├── database/
│   ├── schema.sql               DDL - table creation scripts
│   ├── seed_data.sql            DML - sample data population
│   └── queries.sql              All required client queries
├── web/
│   └── index.html               Web application (HTML/JS/jQuery)
├── diagrams/
│   └── er_diagram.md            E-R diagram description
├── report/
│   └── project_report.md        Final project report
└── screenshots/                 Application screenshots
```

## How to Run

### 1. Database Setup (MySQL)
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p auto_company < database/seed_data.sql
```

### 2. Run Required Queries
```bash
mysql -u root -p auto_company < database/queries.sql
```

### 3. Web Application
Open `web/index.html` in any modern web browser (Chrome, Firefox, Edge).
No server required - the application uses client-side JavaScript with 
jQuery for the UI and an in-memory data store that mirrors the MySQL schema.

For a production deployment, the JavaScript data store would be replaced
with AJAX calls to a server-side API (servlet, PHP, or Node.js) that
connects to MySQL via JDBC or equivalent.

## Features

### User Interfaces
1. **Dashboard** - Overview statistics and recent sales activity
2. **Vehicle Inventory** - Search, filter, add vehicles with full CRUD
3. **Customer Management** - Customer database with purchase history
4. **Sales Recording** - Record new sales with automatic inventory update
5. **Dealer Network** - View all dealers and their brand assignments
6. **Vehicle Locator** - Cross-dealer inventory search for customer matching
7. **Marketing Reports** - OLAP-style reports (trends, demographics, recalls)
8. **SQL Console (DBA)** - Command-line style SQL interface with presets

### Required Queries Implemented
1. Sales trends by brand (year/month/week) with gender and income breakdowns
2. Getrag defective transmission recall lookup
3. Top 2 brands by dollar amount (past year)
4. Top 2 brands by unit sales (past year)
5. Best month(s) for convertible sales
6. Dealers with longest average inventory duration

## Technology Stack
- **Database:** MySQL 8.0
- **Frontend:** HTML5, CSS3, JavaScript, jQuery 3.7.1
- **Design:** Responsive single-page application
- **Reference:** Database System Concepts 7th Ed. (Silberschatz), JavaScript & jQuery (Duckett)

## AI Disclosure
The web-based UI (web/index.html) was developed with assistance from 
generative AI tools, as permitted per the course project instructions 
(Item 4, Note 3). The database design (E-R diagram, relational schema, 
SQL queries) represent original student work based on course material.
