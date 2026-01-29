CREATE TABLE loan_core (
    id BIGINT,
    member_id BIGINT,
    loan_amnt DECIMAL(12,2),
    funded_amnt DECIMAL(12,2),
    term INT,
    int_rate DECIMAL(6,3),
    installment DECIMAL(12,2),
    grade CHAR(1),
    sub_grade VARCHAR(5),
    emp_length	VARCHAR(20),
    home_ownership	VARCHAR(20),
    annual_inc	DECIMAL(12,2),
    verification_status	VARCHAR(30),
    issue_d VARCHAR(20),
    loan_status	VARCHAR(50),
    purpose	VARCHAR(50),
    addr_state CHAR(2),
    dti DECIMAL(6,2),
    delinq_2yrs	INT,
    earliest_cr_line VARCHAR(20),	
    fico_range_low	INT,
    fico_range_high	INT,
    inq_last_6mths	INT,
    open_acc INT,
    pub_rec	INT,
    revol_bal DECIMAL(14,2),
    revol_util DECIMAL(6,2),
    total_acc INT,
    out_prncp DECIMAL(14,2),
    total_pymnt	DECIMAL(14,2),
    total_rec_prncp	DECIMAL(14,2),
    total_rec_int DECIMAL(14,2),
    last_pymnt_d VARCHAR(20),
    last_pymnt_amnt	DECIMAL(14,2),
    last_credit_pull_d	VARCHAR(20),
    last_fico_range_high INT,
    last_fico_range_low	INT,
    tot_cur_bal	DECIMAL(16,2),
    total_rev_hi_lim DECIMAL(16,2),
    tot_hi_cred_lim DECIMAL(16,2)
);


LOAD DATA LOCAL INFILE '/Users/bhoomi/Documents/GitHub/Credit-Risk-Analytics-with-Early-Warning-Signals/loan_core.csv'
INTO TABLE loan_core
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;