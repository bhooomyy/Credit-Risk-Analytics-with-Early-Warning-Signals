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

LOAN_FILE_PATH="/Users/bhoomi/Documents/GitHub/Credit-Risk-Analytics-with-Early-Warning-Signals/loan.csv"
OUT_PATH="/Users/bhoomi/Documents/GitHub/Credit-Risk-Analytics-with-Early-Warning-Signals/loan_core.csv"
os.makedirs(os.path.dirname(OUT_PATH),exist_ok=True)

cols_in_file=pd.read_csv(LOAN_FILE_PATH,nrows=0).columns.tolist()
use_col=[c for c in KEEP_COLs if c in cols_in_file]

chunk=[]
for df in pd.read_csv(LOAN_FILE_PATH,usecols=use_col,chunksize=200_000,low_memory=False):
    for dcol in ["issue_d", "earliest_cr_line", "last_pymnt_d", "last_credit_pull_d"]:
        if dcol in df.columns:
            df[dcol]=pd.to_datetime(df[dcol],format="%b-%Y",errors="coerce")
    if "term" in df.columns:
        df["term"]=pd.to_numeric(df["term"].str.strip().str.split(" ").str[0])
    if "int_rate" in df.columns:
        df["int_rate"]=df["int_rate"].astype(str).str.rstrip("%").astype(float)
    if "revol_util" in df.columns:
        df["revol_util"]=df["revol_util"].astype(str).str.rstrip("%").astype(float)
    if "emp_length" in df.columns:
        df["emp_length"]=df["emp_length"].astype(str).str.strip()
    if "id" in df.columns:
        df["id"]=pd.to_numeric(df["id"],errors="coerce")
    chunk.append(df)

df_core=pd.concat(chunk,ignore_index=True)
df_core.to_csv(OUT_PATH,index=False)

print("rows: ",len(df_core))
print("columns: ",df_core.shape[1])
print("missing columns: ",[c for c in KEEP_COLs if c not in use_col])