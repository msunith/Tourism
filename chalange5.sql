select count(*) from foreign_visitors 
SELECT count(*) FROM domestic_visitors;

1. Top 10 districts highest visitors
SELECT  district, sum(visitors) as visitors FROM domestic_visitors group by district order by visitors desc limit 10;

2. list down the top 3 districts based on compounded annual growth rate(CAGR) of visitors between (2016-2019)?
(Insight: Districts that are growing)
 
 with cte as
 (select district,year,sum(visitors) as tot_visitors from domestic_visitors group by district,year)
  select district,dom_visitor, for_visitor, round((power((for_visitor/Dom_visitor),1/3)-1)*100,2) as CAGR
 from ( select district,
	sum(case when year = 2016 then tot_visitors else 0 End) as dom_visitor,
    sum(case when year = 2019 then tot_visitors else 0 End) as for_visitor
from cte group by district)subquery order by CAGR desc limit 3 ;

3. list down the top 3 districts based on compounded annual growth rate(CAGR) of visitors between (2016-2019)?
(Insight: Districts that are growing)


    
 
 
 
5.Show the top & bottom 3 districts with high domestic to foreign tourist ratio?
with cte as (
Select d.district,max(d.visitors) as top3, min(f.visitors) as bottom3 from domestic_visitors d
join foreign_visitors f on d.district = f.district
group by d.district)
select district,top3,bottom3,top3/bottom3 as ratio from cte order by ratio desc limit 3;