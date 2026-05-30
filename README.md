# Karoo Agriculture Phase 2: Supplier Risk & Compliance Auditor

## Project Overview

This project was developed to help Karoo Organics monitor supplier compliance and operational risk. The system automatically identifies suppliers requiring management review based on certification status, supplier engagement, and harvest performance.

## Files Included

### 1. auditor_views.sql
Contains:
- The `v_supplier_health` monitoring view
- The supplier risk identification query

### 2. audit_suppliers.py
Python automation script that:
- Connects to the SQLite database
- Runs the supplier risk query
- Updates flagged suppliers to `status = 'Review'`
- Uses parameterised SQL updates
- Commits changes permanently
- Uses rollback on failure
- Prints an audit summary

### 3. test_data.sql
Contains:
- Certification data
- Harvest data
- Orders data

The data demonstrates:
- Expired certifications
- Certifications expiring soon
- Suppliers with no recent orders
- Declining harvest yields

## Monitoring Logic

The `v_supplier_health` view combines:
- suppliers
- orders
- certifications
- harvest records

The following calculated fields are included:

### cert_status
Determines whether a supplier certification is:
- Valid
- Expiring Soon
- Expired

### orders_90d
Counts supplier orders within the last 90 days.

### latest_yield
Retrieves the supplier’s most recent harvest yield.

### rolling_avg_yield
Calculates the average yield from the supplier’s latest 3 harvest records.

## Risk Logic

Suppliers are flagged for review if:
- Certification expires within 30 days
- Certification is expired
- No orders were placed within the last 90 days
- Latest harvest yield is below 80% of the rolling average yield

## Database Requirement

The suppliers table must include:

```sql
CREATE TABLE suppliers (
    supplier_id INTEGER PRIMARY KEY,
    farm_name VARCHAR(100) NOT NULL UNIQUE,
    region VARCHAR(50) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Active'
);
```

## Technologies Used

- SQL
- SQLite
- Python
- Pandas

## Author

Sipho Mosia