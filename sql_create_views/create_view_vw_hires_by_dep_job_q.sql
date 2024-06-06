--drop view if exists vw_hires_by_dep_job_q;
CREATE VIEW vw_hires_by_dep_job_q as
with agr as(
select de.department,jo.job,year(he.datetime) YEAR,'Q'|| DATEPART(QUARTER, he.datetime) Q, count(he.id) hired 
from [dbo].[hired_employees] he
left join [dbo].[departments] de
	on he.department_id = de.id
left join [dbo].[jobs] jo
	on he.job_id = jo.id
where year(he.datetime) = 2021

group by year(he.datetime),DATEPART(QUARTER, he.datetime),de.department,jo.job
)
select department,job,Q1,Q2,Q3,Q4
from agr
pivot(
sum(hired) for Q in (Q1,Q2,Q3,Q4)
) as pvt
--order by department,job
