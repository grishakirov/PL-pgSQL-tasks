# Study Plan Statistic (PL/pgSQL)

This directory implements a PL/pgSQL function `STUDY_PLAN_STATISTIC` that compares a student’s completed courses (from a CSV) against a specified study plan and returns detailed statistics.

---

## Use Case
Analyze a student’s study record versus an academic curriculum to produce:
- A list of completed courses with full names and credit values  
- Summary stats: total courses registered, total credits registered, courses in plan, credits in plan, and plan completion percentage  

---

## Objectives
- Load a CSV of completed course codes.  
- Verify the existence of the given study plan using `CHECK_STUDY_PLAN`.  
- Compute:
  - Number of originally registered courses  
  - Total credits originally registered  
  - Number of courses in the plan  
  - Total plan credits  
  - Percentage completion of the plan  
- Return both row‑level details and overall statistics.

---

## Files

### Schema & Data
- `CREATE_SKRIPT.sql`  
- `INSERT_SCRIPT.sql`  
- `input_file.csv`  

### Core Logic
- `CHECK_STUDY_PLAN.sql`  
- `STUDY_PLAN_STATISTIC.sql`  

### Tests
- `CHECK_FUNCTION_WITH_CORRECT_PROGRAMM.sql`  
- `output_file.csv`  
- `CHECK_FUNCTION_WITH_INCORRECT_PROGRAMM.sql`  
- `output_file_with_incorrect_programm.csv`