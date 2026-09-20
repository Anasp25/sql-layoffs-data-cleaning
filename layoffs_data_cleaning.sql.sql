SELECT * FROM world_layoffs.layoffs_staging;

use world_layoffs ;

drop table if exists layoffs_staging ;
create table  layoffs_staging like layoffs ;

insert into layoffs_staging 
select * from layoffs ;

select * from layoffs_staging ;




-- Remove Duplicates
-- Standardize the data
-- Null values or blank values
-- Remove Any Columns

select *
from layoffs_staging
where company = 'Cazoo';

with duplicate_cte as (
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions)  as Row_num
from layoffs_staging 
)
select * 
from duplicate_cte
where Row_num >1 ;


-- create table for adding a column Row_num

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
  `Row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- inserted data into new table 

insert into layoffs_staging2
select * ,
row_number () over (partition by company,
						location,
                        industry,
                        total_laid_off,
                        percentage_laid_off,
                        date,
                        stage,
                        country,
                        funds_raised_millions
                        )  as row_num
from layoffs_staging;

-- For deleting duplicate

delete
from layoffs_staging2 
WHERE Row_num >1;
                      
select *
from layoffs_staging2
where company = 'Casper';

-- standarlizing data

select *
from layoffs_staging2 ;


select  company , trim(Company)
from layoffs_staging2 ;

update layoffs_staging2 
set company = trim(Company) ;

select distinct(industry) 
from layoffs_staging2 ;

select industry
from layoffs_staging2
where industry like 'Crypto%' ;

SET autocommit = 0;  -- for safety 

update  layoffs_staging2
set industry= 'Crypto'
where industry like 'Crypto%' ;

-- Trim and then update the data base

select distinct(country),trim(trailing '.' from  country)
from layoffs_staging2
where country like 'United state%' ;

update layoffs_staging2
set country = trim(trailing '.' from  country)
where country like 'United States%';

-- changeing date format

select `date` ,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date(`date`,'%m/%d/%Y');

-- Modifying table  

alter table layoffs_staging2   
modify column  `date`  date ; 

select * 
from layoffs_staging2
where industry is  null  or industry ='' ;


select * 
from layoffs_staging2
where company = 'Airbnb';

update layoffs_staging2
set industry = null
where industry = '';

-- Joining table  for finding null values 

select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
where t1.industry is  null  
	and t2.industry is  not null  ;
    

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is  null  
	and t2.industry is  not null ;
    

select *
from layoffs_staging2
where company like 'Bally%';

-- Deleting rows where total_laid_off and percentage_laid_off are both NULL

select * 
from layoffs_staging2
where total_laid_off is null 
	and  percentage_laid_off is null ;
    
delete 
from layoffs_staging2
where total_laid_off is null 
	and  percentage_laid_off is null ;

select * 
from layoffs_staging2
where total_laid_off is null 
	and  percentage_laid_off is null ;
    
delete 
from layoffs_staging2
where total_laid_off is null 
	and  percentage_laid_off is null ;
    
alter table layoffs_staging2 
drop column Row_num ;

commit;