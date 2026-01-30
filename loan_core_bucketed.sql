create table loan_core_bucketed as
    select lce.*,
    -- default_flag=1 -> default
    -- Late status -> High
    -- Early warning + not default -> Medium
    -- No early warning + not default -> Low
    case
        when default_flag=1 then 'DEFAULT'
        when risk_state='LATE' then 'HIGH'
        when early_warning_flag=1 then 'MEDIUM'
        else 'LOW'
    end as risk_bucket
    from loan_core_ews lce;


select risk_bucket, count(*) from loan_core_bucketed group by risk_bucket order by count(*) desc;

select
    risk_bucket,
    count(*) as loans,
    round(count(*) * 100.0 / sum(count(*)) OVER (), 2) as pct_of_portfolio,
    sum(loan_amnt) as total_exposure,
    sum(out_prncp) as outstanding_principal,
    sum(default_flag) as defaults,
    round(avg(revol_util), 2) as avg_utilization,
    round(avg(loan_amnt / nullif(annual_inc,0)), 3) as avg_leverage
from loan_core_bucketed
group by risk_bucket
order by
    case risk_bucket
        when 'LOW' then 1
        when 'MEDIUM' then 2
        when 'HIGH' then 3
        when 'DEFAULT' then 4
    end;
