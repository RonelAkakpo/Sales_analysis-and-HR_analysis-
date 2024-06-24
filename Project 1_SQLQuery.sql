SELECT [Order ID]
      ,[Product]
      ,[Quantity Ordered]
      ,[Price Each]
      ,[Order Date]
      ,[Purchase Address]
      ,[Month]
      ,[Sales]
      ,[City]
      ,[Hour]
  FROM [PortfolioProject].[dbo].[Sales Data]
 where [Hour] is null 

 --suppression de l'observation avec valeurs manquantes
 delete from [dbo].[Sales Data] 
 where [Order ID]=177853

 -- conversion du format de la date
  select distinct ([Order Date]), count([Order Date])
  from [dbo].[Sales Data]
  group by [Order Date]
  order by 2

  select [Order Date],
  convert(Date,[Order Date])
  from [dbo].[Sales Data]

  alter table [dbo].[Sales Data] -- ajout d'une nouvelle colonne au format date
  add OrderDateConverted date;

  update [dbo].[Sales Data]
  set OrderDateConverted=convert(Date,[Order Date])

 -- extraction du mois en caractere
 select distinct(Month), count(Month)
  from [dbo].[Sales Data]
  group by Month
  order by 2

  alter table [dbo].[Sales Data] 
  alter column Month nvarchar(50)

  select OrderDateConverted, Month, 
  CASE when Month='1' then 'Jan'
     when Month='9' then 'Sep'
	 when Month='8' then 'Aug'
	 when Month='2' then 'Feb'
	 when Month='6' then 'Jun'
	 when Month='7' then 'Jul'
	 when Month='3' then 'Mar'
	 when Month='5' then 'May'
	 when Month='11' then 'Nov'
	 when Month='4' then 'Apr'
	 when Month='10' then 'Oct'
	 when Month='12' then 'Dec'
	 else Month
	 end
	from [dbo].[Sales Data]

	update [dbo].[Sales Data]
	set MonthConverted= CASE when Month='1' then 'Jan'
     when Month='9' then 'Sep'
	 when Month='8' then 'Aug'
	 when Month='2' then 'Feb'
	 when Month='6' then 'Jun'
	 when Month='7' then 'Jul'
	 when Month='3' then 'Mar'
	 when Month='5' then 'May'
	 when Month='11' then 'Nov'
	 when Month='4' then 'Apr'
	 when Month='10' then 'Oct'
	 when Month='12' then 'Dec'
	 else Month
	 end

	 select *
	 from [dbo].[Sales Data]

--Extraction de l'année
select OrderDateConverted,
parsename(replace(OrderDateConverted, '-','.'), 3)
from [dbo].[Sales Data]

alter table [dbo].[Sales Data] 
add YearConverted nvarchar(50);

  update [dbo].[Sales Data]
  set YearConverted=parsename(replace(OrderDateConverted, '-','.'), 3)

  --extraction de l'Etat(state)
  select [Purchase Address],
left(parsename(replace([Purchase Address], ',','.'), 1),3)
from [dbo].[Sales Data]

alter table [dbo].[Sales Data] 
add State nvarchar(50);

update [dbo].[Sales Data]
set State=left(parsename(replace([Purchase Address], ',','.'), 1),3)

select *
from [dbo].[Sales Data]