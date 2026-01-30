# 📊 Credit Risk Analytics with Early Warning Signals  
**Lending Club Loan Portfolio (Kaggle)**

---

## Executive Summary
This project implements a **production-style credit risk analytics pipeline** using Lending Club loan-level data. It demonstrates how financial institutions ingest raw loan data, engineer risk signals, and build **early-warning systems** to proactively identify loans with elevated default risk.

The solution mirrors **real-world banking analytics workflows**, including chunked ingestion of large datasets, canonical risk labeling, early-warning signal engineering, and portfolio-level risk segmentation suitable for management reporting.

This project is designed to reflect **senior-level analyst / analytics engineer responsibilities** in credit risk, portfolio analytics, and early-warning monitoring.

---

## 🔍 Business Problem
Banks and lenders must detect **early signs of borrower distress** before loans become delinquent or default. Loan status alone is insufficient; proactive risk management requires:

- Monitoring revolving credit utilization  
- Identifying shrinking credit buffers  
- Measuring borrower leverage relative to income  
- Segmenting portfolio risk for actionability  

This project answers:
> *“Which loans show early-warning signals today, and how concentrated is portfolio risk?”*

---

## 🏗 Architecture Overview
Raw CSV (loan.csv)
   ↓
Python – Chunked Processing & Standardization
   ↓
loan_core (Processed Core Dataset)
   ↓
loan_core_risk (Canonical Risk Labeling)
   ↓
loan_core_ews (Early Warning Signals)
   ↓
loan_core_bucketed (Portfolio Risk Buckets)

