--Przyk³adowe zapytania dla bazy danych NorthWind
use Northwind
go
--1
-- Produkty, których cena jest mniejsza od od œredniej z ich kategorii
select p1.ProductName, UnitPrice, p1.CategoryID 
from Products p1 
where UnitPrice < (select avg(UnitPrice) 
	from Products p2 
	where p1.CategoryID = p2.CategoryID)
--2
-- £¹czna iloœæ i wartoœæ produktów
select ProductID, sum(Quantity) 'Suma ilosci', sum(Quantity*UnitPrice) 'Calkowita wartosc' 
from [Order Details] 
group by ProductID
--3
-- Liczba produktów oferowanych przez poszczególne firmy
select CompanyName, count(ProductID) 'Liczba produktów' 
from Suppliers s left join Products p on s.SupplierID = p.SupplierID 
group by CompanyName
--4
-- Zakresy cen dla poszczególnych kategorii
select CategoryName, max(UnitPrice) 'Max cena', min(UnitPrice) 'Min cena', round(avg(UnitPrice),2) 'Srednia cena' 
from Categories c inner join Products p on c.CategoryID = p.CategoryID 
group by CategoryName
--5
-- Zamówienia z roku 1997
select OrderID, OrderDate, ShipCountry 
from Orders 
where year(ShippedDate) = 1997 
order by OrderID
--6
--  Liczba produktów oferowanych przez poszczególne firmy z USA i Zjednoczonego Królestwa
select CompanyName, count(ProductID) 'Liczba produktów' 
from Suppliers s left join Products p on s.SupplierID = p.SupplierID 
where Country = 'USA' or Country = 'UK' 
group by CompanyName
--7
-- Liczba produktów w poszczególnych kategoriach
select CategoryName, count(ProductID) 'Liczba produktów' 
from Categories c left join Products p on c.CategoryID = p.CategoryID 
group by CategoryName
--8
-- Produkty o najwy¿szej cenie w kategorii
select ProductName, UnitPrice, CategoryName 
from Products p1 inner join Categories c on p1.CategoryID = c.CategoryID 
where UnitPrice = (select max(UnitPrice) 
	from Products p2 
	where p1.CategoryID = p2.CategoryID)
--9
-- Kwota do zap³aty przez kontrahentów
select ContactName, (sum(UnitPrice*Quantity)) 'Kwota do zap³aty' 
from Customers c left join Orders o on c.CustomerID = o.CustomerID inner join [Order Details] od on o.OrderID = od.OrderID 
group by ContactName