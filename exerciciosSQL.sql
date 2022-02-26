/* Descobrir quantidade de pagamento (total) ocorridas dentre 2003-06 e 2003-12, além disso menor e maior quantidade. */
SELECT paymentDate from payments; /*  Para confirmar o modelo em que data foi gravado no BD */ 
SELECT SUM(amount) from payments WHERE paymentDate BETWEEN '2003-06-01' AND '2003-12-01';
SELECT MIN(amount) from payments WHERE paymentDate BETWEEN '2003-06-01' AND '2003-12-01';
SELECT MAX(amount) from payments WHERE paymentDate BETWEEN '2003-06-01' AND '2003-12-01';

/*Selecionar cidades e paises unicos  dos customers*/
SELECT DISTINCT city, country FROM customers;

/* Nome unico de produtos */
SELECT DISTINCT productName FROM products;

/* Preço de cada produto e quantidade em estoque (sem repetir)*/
SELECT DISTINCT productName, quantityInStock from products;

/* Preço de cada produto */
SELECT buyPrice FROM products;

/* Todos os jobtitles dos employees*/
SELECT DISTINCT jobTitle FROM employees;

/* Nome completo, email e a quem responde de cada funcionário - para depois identificar o reportsTo nome completo e employeenumber - sem utilizar join*/
SELECT firstName, lastName, email, reportsTo from employees;
SELECT firstName, lastName, employeeNumber from employees;

/* Telefone e endereços de cada escritório*/
SELECT phone, addressLine1 from offices;

/* Código do produto e quantidade de pedido*/
SELECT orderNumber, quantityOrdered from orderdetails;

/* Comentarios sobre pedidos (com o número do pedido) onde comentarios existam de fato*/
SELECT comments, orderNumber from orders WHERE comments IS NOT NULL;

/* Data do pedido, data que foi enviado e qual status*/
SELECT orderDate, shippedDate, status from orders;

/* Limite de crédito de cada cliente com nome e telefone*/
SELECT creditlimit, phone, customerName from customers;

/*--------INNER JOINS
/* Preço de dos pedidos ordenado crescente no mês de julho 2004 */
SELECT orderdetails.priceEach, orders.orderDate from orderdetails join orders on orderdetails.orderNumber = orders.orderNumber where orders.orderDate BETWEEN '2004-06-01' AND '2004-12-31' order by orders.orderDate asc;

/* Número do pedido e status*/
SELECT orderdetails.orderNumber, orders.status from orderdetails join orders on orderdetails.orderNumber = orders.orderNumber;

/*Selecionar quantidade de funcionários por escritórios*/
SELECT offices.city, count(employees.employeeNumber) as 'Total number of Employees' from employees right join offices on employees.officeCode = offices.officeCode group by offices.officeCode;

/*Nome do funcionário, telefone e endereço do escritório que trabalha*/
SELECT employees.firstName, offices.phone, offices.addressLine1 from employees join offices on employees.officeCode = offices.officeCode;

/* Descrição do produto e o nome */
SELECT pl.textDescription, p.productName from productlines as pl join products as p on pl.productLine = p.productLine;

/*Alterar charset do banco de dados para utf 8 */
ALTER DATABASE classicmodels CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

/* Trocar nome da coluna address para endereço - confirmar que suporta 'ç'*/
ALTER TABLE offices CHANGE COLUMN `addressLine1` `endereço1` varchar(50) NOT NULL;
/*Resultado com sucesso da consulta após alterar nome de coluna*/
SELECT endereço1 FROM offices;

/*Alterar nome da coluna e erro de smallint 6 - para 5*/
ALTER TABLE products CHANGE COLUMN  `quantityInStock` `qtdEstoque` smallint(5) NOT NULL;
ALTER TABLE orderdetails CHANGE COLUMN  `orderLineNumber` `orderLineNumber` smallint(5) NOT NULL;

/*Alterar textDescription - productlines varchar(4000) para 1000*/
ALTER TABLE productlines CHANGE COLUMN  `textDescription` `textDescription` varchar(1000) DEFAULT NULL;

/*Selecionar datas de pagamento e quantidade de pagamentos superior a 5000*/
SELECT paymentDate, amount FROM payments GROUP BY paymentDate HAVING amount > 5000 ORDER BY paymentDate asc;
 
 /*Selecionar todos os representantes de venda e seus emails*/
 SELECT firstName, lastName, email from employees WHERE jobTitle = 'Sales Rep';
 
 /*Contar numero total de produtos*/
 SELECT distinct COUNT(productName) FROM products;
 
 /*Contar numero total de funcionarios do mesmo escritorio*/
 SELECT COUNT(employees.employeeNumber) from employees join offices on endereço1 WHERE offices.endereço1  = '5-11 Wentworth Avenue';
 
/*Quais funcionários trabalham em San Frascisco*/
 SELECT employees.firstName, employees.email FROM employees join offices WHERE offices.city = 'San Francisco';


/*Inserir um novo escritório*/
INSERT INTO `offices`(`officeCode`,`city`,`phone`,`endereço1`,`addressLine2`,`state`,`country`,`postalCode`,`territory`) values 
('55','Philadelphia','+1 215 253 0070','19 kelmar avenue','side B','PA','USA','19355','NA');

/*Trazer todos os escritórios mesmo que não tenha funcionários, portanto escritório da Philadelphia deve aparecer*/
SELECT o.officeCode, o.city, o.phone, e.firstName from offices o LEFT JOIN employees e on o.officeCode = e.officeCode;

/*Inserir nova funcionária*/
INSERT INTO `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) VALUES
(3015084,'Cordeiro','Gabriela','10616','cordeiro.gabriela@aluno.ifsp.edu.br','1',1002,'Dev Junior');

