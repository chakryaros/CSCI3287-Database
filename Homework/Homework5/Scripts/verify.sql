use salesdw;

select 'Table', 'Rows' from dim_customer
union
select 'dim_customer', count(*) from dim_customer
union
select 'dim_date', count(*) from dim_date
union
select 'dim_product', count(*) from dim_product
union
select 'dim_salesperson', count(*) from dim_salesperson
union
select 'dim_store', count(*) from dim_store
union
select 'fact_productsales', count(*) from fact_productsales;