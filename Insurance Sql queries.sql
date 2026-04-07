create database branch_dashboard;
use branch_dashboard;
select * from invoiceee;

ALter table invoiceee
Change `Account Executive`
Account_Executive Text;
 
 -- No of Invoice by Accnt Exec (KPI)
 select account_executive,count(invoice_number) as no_of_invoices from invoiceee
 group by account_executive
 order by count(invoice_number) Desc;
 
 -- Yearly Meeting Count(KPI)
 select year(str_to_date(meeting_date, '%m/%d/%Y'))   as year , count(*) as total_meeting from meeting
 group by year(str_to_date(meeting_date, '%m/%d/%Y'))
 order by year;
 
-- Stage Funnel by Revenue(KPI)
select stage, sum(revenue_amount) as revenue from oppurunity
group by Stage
Order by sum(revenue_amount) desc;

ALter table meeting
Change `Account Executive`
Account_Executive Text;

-- No of meeting By Account Exe(KPI)
select account_executive, count(global_attendees) as meetings from meeting
group by account_executive
order by meetings desc;

-- Top Open Opportunity(KPI)
select opportunity_name, sum(revenue_amount) from oppurunity
group by opportunity_name
order by sum(revenue_amount) Desc
limit 5;

ALter table budget
Change `Renewal Budget`
Renewal_Budget Decimal(15,2);

ALter table budget
Change `Cross sell bugdet`
Crosssell_buget Decimal(15,2);

ALter table budget
Change `New Budget`
New_Budget Decimal(15,2);

ALTER TABLE brokeragee
CHANGE Amount Amount DECIMAL(15,2);

ALTER TABLE feess
CHANGE Amount Amount DECIMAL(15,2);

ALTER TABLE invoiceee
CHANGE Amount Amount DECIMAL(15,2);

 
-- New / Cross Sell / Renewal: Budget vs Achieved vs Invoice(KPI)
SELECT
    'New' AS income_class,
    SUM(New_Budget) AS target,
    (
        SELECT COALESCE(SUM(Amount), 0) FROM brokeragee WHERE income_class = 'New'
    ) +
    (
        SELECT COALESCE(SUM(Amount), 0) FROM feess WHERE income_class = 'New'
    ) AS achieved,
    (
        SELECT COALESCE(SUM(Amount), 0) FROM invoiceee WHERE income_class = 'New'
    ) AS New
FROM budget

UNION ALL

SELECT
    'Cross Sell' AS income_class,
    SUM(Crosssell_buget) AS target,
    (
        SELECT COALESCE(SUM(Amount), 0) FROM brokeragee WHERE income_class = 'Cross Sell'
    ) +
    (
        SELECT COALESCE(SUM(Amount), 0) FROM feess WHERE income_class = 'Cross Sell'
    ) AS achieved,
    (
        SELECT COALESCE(SUM(Amount), 0) FROM invoiceee WHERE income_class = 'Cross Sell'
    ) AS new
FROM budget

UNION ALL

SELECT
    'Renewal' AS income_class,
    SUM(Renewal_Budget) AS target,
    (
        SELECT COALESCE(SUM(Amount), 0) FROM brokeragee WHERE income_class = 'Renewal'
    ) +
    (
        SELECT COALESCE(SUM(Amount), 0) FROM feess WHERE income_class = 'Renewal'
    ) AS achieved,
    (
        SELECT COALESCE(SUM(Amount), 0) FROM invoiceee WHERE income_class = 'Renewal'
    ) AS new
FROM budget;









 

 
 
  
 