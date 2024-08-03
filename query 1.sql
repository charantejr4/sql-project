SELECT* FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null Values or blank values
-- 4. Remove Any Columns

CREATE TABLE lauoffs_staging
LIKE layoffs;

SELECT * FROM
layoffs_staging;

INSERT layoffs_staging
SELECT*FROM layoffs;

-- new column rank is made to get the duplicates and originals
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location, industry, total_laid_off,percentage_laid_off
,`date`,stage,country,funds_raised_millions) AS row_num FROM layoffs_staging
)
SELECT * FROM 
duplicate_cte
WHERE row_num>1;


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- we delete the rows where the rank is greater than 2 
DELETE 
FROM layoffs_staging2
WHERE row_num>1;

select*from layoffs_staging2;



-- Standardizing the Data

-- Trim is used to remove the white spaces in the beginning

select trim(company)
from layoffs_staging2;

UPDATE layoffs_staging2
SET company=TRIM(company);

SELECT DISTINCT(industry)
FROM layoffs_staging2 ORDER BY 1;

-- Check if the values in the columns are different but they come in same category
-- Example crypto and crypto currency
SELECT*FROM layoffs_staging2
where industry like "Crypto%";

UPDATE layoffs_staging2
set industry="Crypto"
WHERE industry like "Crypto%";
 
 -- example united states and united states.
 
UPDATE layoffs_staging2
set country="United States"
WHERE country like "United States.";
-- or by using trim and trailing
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
set country=TRIM(TRAILING '.' FROM country)
WHERE country like "United States.";

-- change date fromm text to date

SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date`=STR_TO_DATE(`date`,'%m/%d/%Y');

select `date` from layoffs_staging2;

alter table layoffs_staging2
modify column `date` DATE;


-- remove null and blanck values in the table

select * from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

-- lets try to populate the null and blank places if possible
SELECT * FROM
layoffs_staging2
WHERE company='Airbnb';

-- try to make the blank value in the industry a null and 
-- then change the value with the other field of airbnb

update layoffs_staging2
set industry = null
where industry='';

select t1.industry,t2.industry
from layoffs_staging2 t1 
join layoffs_staging2 t2 
	on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
set t1.industry=t2.industry
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

select * from
layoffs_staging2 where company='Airbnb';

-- delete the rows where total_laid_off and percentage 
-- _laid_offs anre both null

delete from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from
layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

-- drop the row_num column

alter table layoffs_staging2
drop column row_num;

select*from layoffs_staging2;







