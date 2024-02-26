--Przyk�adowe zapytania dla bazy danych NorthWind
use Northwind
go
--1
-- Produkty, kt�rych cena jest mniejsza od od �redniej z ich kategorii
select p1.ProductName, UnitPrice, p1.CategoryID 
from Products p1 
where UnitPrice < (select avg(UnitPrice) 
	from Products p2 
	where p1.CategoryID = p2.CategoryID)
--2
-- ��czna ilo�� i warto�� produkt�w
select ProductID, sum(Quantity) 'Suma ilosci', sum(Quantity*UnitPrice) 'Calkowita wartosc' 
from [Order Details] 
group by ProductID
--3
-- Liczba produkt�w oferowanych przez poszczeg�lne firmy
select CompanyName, count(ProductID) 'Liczba produkt�w' 
from Suppliers s left join Products p on s.SupplierID = p.SupplierID 
group by CompanyName
--4
-- Zakresy cen dla poszczeg�lnych kategorii
select CategoryName, max(UnitPrice) 'Max cena', min(UnitPrice) 'Min cena', round(avg(UnitPrice),2) 'Srednia cena' 
from Categories c inner join Products p on c.CategoryID = p.CategoryID 
group by CategoryName
--5
-- Zam�wienia z roku 1997
select OrderID, OrderDate, ShipCountry 
from Orders 
where year(ShippedDate) = 1997 
order by OrderID
--6
--  Liczba produkt�w oferowanych przez poszczeg�lne firmy z USA i Zjednoczonego Kr�lestwa
select CompanyName, count(ProductID) 'Liczba produkt�w' 
from Suppliers s left join Products p on s.SupplierID = p.SupplierID 
where Country = 'USA' or Country = 'UK' 
group by CompanyName
--7
-- Liczba produkt�w w poszczeg�lnych kategoriach
select CategoryName, count(ProductID) 'Liczba produkt�w' 
from Categories c left join Products p on c.CategoryID = p.CategoryID 
group by CategoryName
--8
-- Produkty o najwy�szej cenie w kategorii
select ProductName, UnitPrice, CategoryName 
from Products p1 inner join Categories c on p1.CategoryID = c.CategoryID 
where UnitPrice = (select max(UnitPrice) 
	from Products p2 
	where p1.CategoryID = p2.CategoryID)
--9
-- Kwota do zap�aty przez kontrahent�w
select ContactName, (sum(UnitPrice*Quantity)) 'Kwota do zap�aty' 
from Customers c left join Orders o on c.CustomerID = o.CustomerID inner join [Order Details] od on o.OrderID = od.OrderID 
group by ContactName