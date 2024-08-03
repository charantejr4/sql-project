-- Exploratory data

select*from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

-- check the companies where everyone is laid of
select*from layoffs_staging2
where percentage_laid_off=1
order by total_laid_off desc;

-- checking the duration of the layoffs
select min(`date`),max(`date`)
from layoffs_staging2;

-- checking the most laid off industry
select industry,sum(total_laid_off)
from layoffs_staging2
group by industry 
order by 2 desc;

-- countries with most layoffs
select country,sum(total_laid_off) as laid_offs
from layoffs_staging2
group by country
order by laid_offs desc;

-- checking the highest lay_offs by year
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by sum(total_laid_off) desc;

-- checking the lay_offs in different months of an year

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 ;
 
-- finding the rolling total
-- it is nothing but adding the above values to the current value 
-- as we go down

with rolling_sub as
(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off,
sum(total_off) over (order by `month`) as rolling_total
from rolling_sub;
 
-- finding the rolling total by comapny
with rolling_sub_total as(
select country,sum(total_laid_off) as laid_offs
from layoffs_staging2
group by country
order by laid_offs asc
)
select country, laid_offs,
sum(laid_offs) over(order by country) as rolling
from rolling_sub_total;

-- ranking the comapanies with most lay_offs in a year

select company, year(`date`), sum(total_laid_off)
from layoffs_staging2 
group by company, year(`date`)
order by 3 desc;

with company_year(company,years,total_laid_off) as
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2 
group by company, year(`date`)
),company_rank as
(select *, DENSE_RANK() over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
)
select * from
company_rank where ranking <=5;
