# TCS-lastmile-salesforce

# Salesforce Inventory & Order Tracking Dashboard

## Problem Statement
Many small and medium businesses still manage products and track customer orders manually using spreadsheets or paper-based methods.  
This leads to errors, delays, and difficulty maintaining real-time stock updates.  

**Objective:**  
To build a Salesforce application that manages products and orders efficiently, automates stock adjustments, and provides dashboards for quick insights.

---

## Project Overview
The Inventory & Order Tracking Dashboard is a Salesforce-based application designed to:
- Store products, orders, and order items as custom objects.
- Automatically update stock when orders are placed or modified.
- Provide interactive dashboards for inventory and order status.
- Demonstrate Salesforce declarative and programmatic capabilities (Admin + Developer).

---

## Phase-wise Implementation

### Phase 1: Problem Understanding & Industry Analysis
- **Requirement Gathering:** Identify project scope (products, orders, stock management).  
- **Stakeholder Analysis:** Determine users (sales team, inventory staff).  
- **Business Process Mapping:** Define order-to-stock workflow.  
- **Industry-specific Use Case Analysis:** E-commerce and retail inventory scenarios.  
- **AppExchange Exploration:** Look for existing solutions for learning references.

### Phase 2: Org Setup & Configuration
- **Salesforce Editions & Company Profile:** Set up org with licenses, fiscal year, business hours, and holidays.  
- **User Setup & Security:** Configure profiles, roles, permission sets, OWD, and sharing rules.  
- **Sandbox & Deployment Basics:** Prepare development environment for testing and deployment.

### Phase 3: Data Modeling & Relationships
- **Custom Objects:** `Product__c`, `Order__c`, `Order_Item__c`.  
- **Fields & Record Types:** Define product code, stock quantity, price, order details.  
- **Page Layouts & Schema Builder:** Organize field visibility and relationships.  
- **Relationships:** Master-Detail between Order and Order Items; Lookup for Products.

### Phase 4: Process Automation (Admin)
- **Validation Rules:** Ensure data integrity (e.g., stock quantity ≥ 0).  
- **Flows & Process Builder:** Automate default values, notifications, or updates.  
- **Approval Processes & Email Alerts:** Optional for order approvals.

### Phase 5: Apex Programming (Developer)
- **Triggers & Handlers:** Auto-update stock quantity on order item insert/update/delete.  
- **Classes & Methods:** Apex controller for LWCs (`InventoryController`, `InventoryCallout`).  
- **SOQL/SOSL & Collections:** Efficient queries and batch processing.  
- **Test Classes & Exception Handling:** Ensure robust deployment.

### Phase 6: User Interface Development
- **Lightning App Builder:** Create Inventory Dashboard app.  
- **Record Pages & Tabs:** Configure pages for Products and Orders.  
- **LWCs:** `productList`, `orderList`, `inventoryDashboard`, `stockSummary`.  
- **Wire Adapters & Imperative Apex:** Fetch data reactively or on demand.  
- **Navigation & Events:** Optional navigation and communication for child-parent LWCs.

### Phase 7: Integration & External Access
- **Named Credentials & Callouts:** Access external APIs for inventory updates.  
- **External Services / REST/SOAP:** Expose external inventory data.  
- **Platform Events & Change Data Capture:** Real-time updates for stock/order changes.  
- **Salesforce Connect:** Access external database tables (external objects).  
- **OAuth & API Limits:** Configure authentication and monitor API usage.

### Phase 8: Data Management & Deployment
- **Data Import Wizard & Data Loader:** Import sample products and orders.  
- **Duplicate Rules:** Prevent duplicate products or orders.  
- **Data Export & Backup:** Regular CSV backups.  
- **Change Sets & VS Code/SFDX:** Deploy metadata from local dev environment.

### Phase 9: Reporting, Dashboards & Security Review
- **Reports:** Tabular, Summary, Matrix for Products and Orders.  
- **Report Types:** Custom report types for joined objects.  
- **Dashboards & Dynamic Dashboards:** Visualize stock levels and order status.  
- **Field-Level Security & Sharing:** Ensure appropriate data visibility.  
- **Session Settings & Audit Trail:** Monitor org activity.

## VS Code & SFDX Commands

```bash
# Authenticate Salesforce Org
sf login org

# Check connected orgs
sf org list

# Retrieve metadata from org
sf project retrieve start --manifest package.xml

# Deploy metadata to org
sf project deploy start --source-dir force-app

# Check deployment report
sf project deploy report --use-most-recent

# Open org in browser
sf org open

# Check deployed classes and LWCs
sf project list
