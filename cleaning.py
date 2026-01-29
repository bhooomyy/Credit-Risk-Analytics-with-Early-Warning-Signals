import pandas as pd
import os

KEEP_COLs=[
    # keys & dates
    "id", "member_id", "issue_d", "earliest_cr_line", "last_pymnt_d", "last_credit_pull_d",
    #target/ status
    "loan_status",
    
    #loan term
    "loan_amnt", "funded_amnt", "term", "int_rate", "installment", "grade", "sub_grade", "purpose",
    
    #borrower
    "addr_state", "home_ownership", "annual_inc", "emp_length", "verification_status",
    
    #credit profile
    "dti", "delinq_2yrs", "inq_last_6mths", "open_acc", "pub_rec",
    "revol_bal", "revol_util", "total_acc",
    "total_pymnt", "total_rec_prncp", "total_rec_int", "last_pymnt_amnt",
    
    #Extra 
    "out_prncp", "tot_cur_bal", "tot_hi_cred_lim", "total_rev_hi_lim",
    "fico_range_low", "fico_range_high", "last_fico_range_low", "last_fico_range_high"
]
