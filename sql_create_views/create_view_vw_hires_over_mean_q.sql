-- dbo.vw_hires_over_mean_q source

CREATE VIEW vw_hires_over_mean_q as
with agr as(
select de.id ,de.department, count(he.id) hired 
from [dbo].[hired_employees] he
left join [dbo].[departments] de
	on he.department_id = de.id
left join [dbo].[jobs] jo
	on he.job_id = jo.id
where year(he.datetime) = 2021
group by de.id,de.department
)
select * from agr
where hired > (select avg(hired) from agr) 
--order by hired desc;
