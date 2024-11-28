use phenikaaEmployee;

-- Tạo ra 1 trigger lắng nghe sự kiện insert thêm mới bản ghi vào trong bảng employees mỗi khi thêm mới 1 bản ghi, 
-- lưu trữ lại tổng số luọng bản ghi có trong bảng Employees
delimiter $$
create trigger saveEmployeeNumber01
after insert
on employees
for each row
begin
	declare counter int default 0;
	select count(*) into counter from employee;
	
    insert into employee_log(count) values (counter);
end$$
delimiter ;

insert into employee(id, name, email) values (2, "LVH", "lvh@gmail.com");

create table employee_log(
	id int primary key,
    content longtext,
    count int
);


-- Tạo 1 trigger before insert checkExceedLimit kiểm tra xem số lượng bản ghi trong bảng có vượt 120 ?
-- nếu có thì không cho insert vào trong bảng employee và hiện thị alert

delimiter $$
create trigger checkExceedLimit02
before insert
on employee
for each row
begin
	declare counter int default 0;
	select count(*) into counter from employee;
	if counter > 2 then 
		signal sqlstate "45000" set message_text = "Over 2!";
    end if;
end$$
delimiter ;

insert into employee(id, name, email) values (4, "LVH", "lvh@gmail.com");

create table InventoryManagement(
	ProductID int primary key not null AUTO_INCREMENT,
    ProductName varchar(100),
    quantity int
);

create table InventoryChanges(
	ChangeID int primary key not null AUTO_INCREMENT,
    ProductID int,
    OldQuantity int,
    NewQuantity int,
    ChangeDate datetime,
    FOREIGN KEY (ProductID) REFERENCES InventoryManagement(ProductID)
);


delimiter $$
create trigger AfterProductUpdate
AFTER UPDATE
on InventoryManagement
for each row
begin
	declare counter int default 0;
	select count(*) into counter from InventoryChanges;
	insert into InventoryChanges(ChangeID, ProductID, OldQuantity, NewQuantity, ChangeDate)
    values(counter + 1, ProductID, Old.quantity, new.quantity, now());
end$$
delimiter ;

update InventoryManagement set quantity = 30 where ProductID = 01;

select * from InventoryChanges;


delimiter $$
create trigger BeforeProductDelete
before delete
on InventoryManagement
for each row
begin
	declare counter int default 0;
	select quantity into counter from InventoryManagement;
	if counter > 10 then 
		signal sqlstate "45000" set message_text = "Can't delete product have 10 quantity left";
    end if;
end$$
delimiter ;

delete from InventoryManagement where ProductID = 2;


alter table InventoryManagement add LastUpdate datetime;

delimiter $$
create trigger AfterProductUpdateSetDate
before UPDATE
on InventoryManagement
for each row
begin
	set new.LastUpdate = now();
end$$
delimiter ;

update InventoryManagement set quantity = 456 where ProductID = 2;

select * from InventoryManagement;


create table ProductSummary(
	SummaryID int primary key not null AUTO_INCREMENT,
    TotalQuantity int
);

insert into ProductSummary(SummaryID, TotalQuantity) values(1, 0);

delimiter $$
create trigger AfterProductUpdateSummary
AFTER UPDATE
on InventoryManagement
for each row
begin
	declare counter int default 0;
	select sum(quantity) into counter from InventoryManagement;
	update ProductSummary set TotalQuantity = counter where SummaryID = 1;
end$$
delimiter ;

select * from ProductSummary;




