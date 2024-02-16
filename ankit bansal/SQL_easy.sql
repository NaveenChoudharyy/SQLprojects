
Create table  World (name varchar(255), continent varchar(255), area int, population int, gdp int)

insert into World (name, continent, area, population, gdp) values ('Afghanistan', 'Asia', '652230', '25500100', '203430000')
insert into World (name, continent, area, population, gdp) values ('Albania', 'Europe', '28748', '2831741', '129600000')
insert into World (name, continent, area, population, gdp) values ('Algeria', 'Africa', '2381741', '37100000', '1886810000')
insert into World (name, continent, area, population, gdp) values ('Andorra', 'Europe', '468', '78115', '37120000')
insert into World (name, continent, area, population, gdp) values ('Angola', 'Africa', '1246700', '20609294', '1009900000')



select w.name, w.population, w.area from World as w
where w.population > 25000000 or w.area > 3000000

-----------------------------------------------------------------------------------------------


Create table ProductsX (product_id int, low_fats varchar(10) not null check (low_fats in ('y','n')), recyclable varchar(10) not null check (recyclable in ('y','n')))


[rank]  nvarchar (255) NOT NULL CHECK ([rank] IN('Fresh meat', 'Intern','Janitor','Lieutenant','Supreme being')) DEFAULT 'Fresh meat'


insert into Productsx (product_id, low_fats, recyclable) values ('0', 'Y', 'N')
insert into Productsx (product_id, low_fats, recyclable) values ('1', 'Y', 'Y')
insert into Productsx (product_id, low_fats, recyclable) values ('2', 'N', 'Y')
insert into Productsx (product_id, low_fats, recyclable) values ('3', 'Y', 'Y')
insert into Productsx (product_id, low_fats, recyclable) values ('4', 'N', 'N')



select x.product_id from ProductsX as x
where x.low_fats = 'y' and x.recyclable = 'y'










