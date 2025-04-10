-- Ejercicio 1 --
use GD2015C1
select clie_codigo, clie_razon_social from Cliente
where clie_limite_credito >= 1000
order by clie_codigo