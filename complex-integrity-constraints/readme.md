# Oracle PL/SQL – Complex Integrity Constraints Implementation

This repository contains the assignment for implementing two non‑declarative integrity constraints in the database schema using Oracle PL/SQL.

---

## Objectives
- Formulate two integrity constraints that cannot be enforced declaratively in plain SQL.  
- Implement one constraint as a **TRIGGER** and the other as a **PACKAGE** with procedures.  
- Provide test scenarios that demonstrate both positive (allowed) and negative (disallowed) cases.

---

## Assignment

1. **Define Two Complex Constraints**  
   - Choose two business rules from your schema that cannot be expressed with `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, or `NOT NULL`.  

2. **Implement Constraint 1 with a TRIGGER**  
   - Write a PL/SQL trigger that enforces the rule whenever relevant DML occurs.

3. **Implement Constraint 2 with a PACKAGE**  
   - Disable direct DML on the target table(s) (conceptually).  
   - Provide a PL/SQL package exposing procedures for `INSERT`, `UPDATE`, and `DELETE` that enforce the rule.

4. **Test & Document**  
   - For each implementation, create a test script (unit test) showing:  
     - **Positive cases** where data modifications succeed.  
     - **Negative cases** where attempts are blocked or return an error/`FALSE`.  
   - Capture output in log files or screenshots for easy verification.

---

## Solution Overview

### Integrity Constraint 1  
- **Rule:** Each branch may have at most one goods set supplied by the same supplier.  
- **Implementation:** A row‑level trigger on the `pobocka_sada_zbozi` join table that, before insert or update, queries existing assignments and raises an error if a duplicate supplier–branch combination is detected.

### Integrity Constraint 2  
- **Rule:**  
  1. On **INSERT** into `Pobocka`, if `employee_count < 5`, set it to `5`.  
  2. On **UPDATE**, disallow reducing `employee_count` below its current value.  
  3. Disallow **DELETE** of any branch that has assigned goods (`sada_zbozi`).  
  4. Ensure presence and uniqueness of `pobocka_id`.  
- **Implementation:** A PL/SQL package `branch_mgmt_pkg` providing:  
  - `insertPobocka(p_id, p_name, p_count, ...)`  
  - `updatePobocka(p_id, new_count, ...)`  
  - `deletePobocka(p_id)`  
  Each procedure enforces the corresponding rule and returns success/failure.

---

## Deliverables

- `schema.png` — Relational schema diagram  
- `implementace-IO1.sql` — Trigger definition for Constraint 1  
- `implementace-IO2.sql` — Package specification & body for Constraint 2  
- `test-IO1.sql` — Test script for Constraint 1 (positive & negative cases)  
- `test-IO2.sql` — Test script for Constraint 2 (positive & negative cases)  
- `.png and log_test_IO2.md` — Directory containing output logs and screenshots demonstrating test executions  
 