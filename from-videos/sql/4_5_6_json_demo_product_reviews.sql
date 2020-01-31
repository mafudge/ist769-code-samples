use demo 
go

if exists(select * from sys.objects where name = 'products')
drop table products
go
create table products
(
	id int primary key not null,
	name varchar(50) not null,
	price money not null,
	reviews varchar(max) null,
	constraint ck_product_review_is_json check (isjson(reviews)>0)
)
go 

insert into products (id, name, price, reviews) values (1, 'Bike-Pump', 15, '[
		{"Reviewer":{"Name": "Erin Detyers","Email": "edt@mail.com", "Rating" : 5 }}
	]')
insert into products (id, name, price, reviews) values (2, 'Handlebars', 30, '[
		{"Reviewer":{"Name": "Kent Belevit", "Rating" : 2 }}, 
		{"Reviewer":{"Name": "Artie Choke", "Email": "ack@mail.com", "Rating" : 3 }}
	]')
insert into products (id, name, price, reviews) values (3, 'Seat', 40, null)

-- fail
insert into products (id, name, price, reviews) values (4, 'FAIL', 0, 'not json')

select * from products


-- simple query of reviews
select id, name,price, JSON_QUERY(reviews) as Reviews from products for json auto


