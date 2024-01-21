use census_project;

select * from dataset1;
select * from dataset2;

select count(*) from dataset1;
select count(*) from dataset2;

-- dataset for Jharkhand and bihar
select * from dataset1 where state in("Jharkhand","Bihar");

-- Total Population of India
select sum(Population) as Population from dataset2;

-- avg growth
select round(avg(Growth),2) as Avg_Growth from dataset1;

-- avg Growth by State
select State, round(avg(Growth),2) as Avg_Growth from dataset1
group by State order by Avg_Growth desc;

-- avg sex ratio by state
select State, round(avg(Sex_Ratio),0)as Avg_Sex_Ratio from dataset1
group by State;

-- avg literacy rate for States having greater than 90
select State, round(avg(Literacy),2) as Avg_literacy from dataset1
group by State having Avg_literacy>90;

-- top 3 state showing highest avg growth ratio
select State, round(avg(Growth),2) as Avg_growth from dataset1
group by State order by Avg_growth desc
limit 3;

-- bottom 3 state showing lowest avg sex ratio
select State, round(avg(Sex_Ratio),2) as Avg_Sex_ratio from dataset1
group by state order by Avg_Sex_ratio asc
limit 3;

-- filterout states starting with letter 'a'
select distinct State from dataset1 where lower(State) like 'a%' or  lower(State) like 'b%';

-- filterout states starting with letter 'a' and ending with letter 'm'
select distinct State from dataset1 where lower(State) like 'a%' and lower(State) like '%m';

-- calculating no. of males and females by each District
select c.District, c.State, round((c.Population / (c.Sex_ratio + 1)),0) as Male, round((c.Population * c.Sex_ratio )/ (c.Sex_ratio + 1),0) as Female from
(select a.District, a.State, (a.Sex_Ratio/1000) as Sex_ratio, b.Population from dataset1 as a inner join dataset2 as b
on a.District = b.District ) as c;


-- calculating total no. of males and females by State
select d.State, sum(d.Male) as Total_male, sum(d.Female) as Total_female from
(select c.District, c.State, round((c.Population / (c.Sex_ratio + 1)),0) as Male, round((c.Population * c.Sex_ratio )/ (c.Sex_ratio + 1),0) as Female from
(select a.District, a.State, (a.Sex_Ratio/1000) as Sex_ratio, b.Population from dataset1 as a inner join dataset2 as b
on a.District = b.District ) as c) as d
group by d.state
order by d.state ;

-- Total literacy Rate by District
select c.District , c.State, round((c.literacy_ratio*c.Population),0) as Literate_people , round((1-c.literacy_ratio)*c.Population,0) as Illitrate_people from 
(select a.District, a.State, a.Literacy/100 as Literacy_Ratio, b.Population from dataset1 as a inner join dataset2 as b
on a.District = b.District) as c  ;

-- Total literacy Rate by State
select d.State, sum(d.Literate_people) as Total_Literate , sum(d.Illitrate_people) as Total_Illitrate from
(select c.District , c.State, round((c.literacy_ratio*c.Population),0) as Literate_people , round((1-c.literacy_ratio)*c.Population,0) as Illitrate_people from 
(select a.District, a.State, a.Literacy/100 as Literacy_Ratio, b.Population from dataset1 as a inner join dataset2 as b
on a.District = b.District) as c) as d  
group by d.State
order by d.State;




