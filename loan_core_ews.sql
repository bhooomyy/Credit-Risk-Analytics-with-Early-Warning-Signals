-- Early-Warning Signals 
--revol_util-> How much of the borrower’s available revolving credit is currently being used.
-- total_rev_hi_lim-> maximum credit available(Sum of credit limits on all credit cards + other revolving lines)
-- revol_bal->Total unpaid credit card balances(What the borrower actually owes right now on revolving credit)
create table loan_core_ews as
    select lcr.*,
    -- High utilization (>80%) 
    case 
        when revol_util>=80 
        then 1
        else 0
    end as high_util_flag,

    -- Low available credit buffer
    case
        when total_rev_hi_lim is not null
        and revol_bal is not null
        and (total_rev_hi_lim-revol_bal)<5000
        then 1
        else 0
    end as low_buffer_flag,

    -- High leverage (loan vs income)
    case
        when annual_inc is not null
        and loan_amnt / nullif(annual_inc,0) >0.4
        then 1
        else 0
    end as high_leverage_flag,

    -- Composite early warning signal
    case
        when (revol_util>=80)
        or
        (total_rev_hi_lim is not null and revol_bal is not null and (total_rev_hi_lim-revol_bal)<5000)
        or
        (annual_inc is not null and loan_amnt/nullif(annual_inc,0)>0.4)
        then 1
        else 0
        end as early_warning_flag
    from loan_core_risk lcr;