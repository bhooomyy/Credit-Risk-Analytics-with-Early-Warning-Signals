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


