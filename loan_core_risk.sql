select distinct loan_status from loan_core;

create table loan_core_risk as 
select lc.*, 
    case 
        when loan_status in (
            'Charged Off',
            'Default',
            'Does not meet the credit policy. Status:Charged Off'
        )
        then 1
        else 0
    end as default_flag,
        
    case 
        when loan_status in (
            'Charged Off', 
            'Default',
            'Does not meet the credit policy. Status:Charged Off'
        )then 'DEFAULT'
        
        when loan_status in(
            'Late (16-30 days)',
            'Late (31-120 days)',
            'In Grace Period'
        )then 'LATE'

        when loan_status in(
            'Fully Paid',
            'Does not meet the credit policy. Status:Fully Paid'
        )then 'PAID'

        when loan_status ='Current'
        then 'CURRENT'

        else 'OTHER'
    end as risk_state,
issue_d as issue_month
from loan_core lc;

select risk_state, count(*)
from loan_core_risk
group by risk_state
order by count(*) desc;

select default_flag, count(*)
from loan_core_risk
group by default_flag;

select loan_status, risk_state, count(*)
from loan_core_risk
group by loan_status, risk_state
order by count(*) desc;

-- Does not meet the credit policy. Status:Charged Of → OTHER (761)
update loan_core_risk
set
    default_flag = 1,
    risk_state = 'DEFAULT'
where loan_status like 'Does not meet the credit policy. Status:Charged%';


select risk_state, count(*)
from loan_core_risk
group by risk_state
order by count(*) desc;
