create database smurfs;
use smurfs;
create table user (
user_id int(5) not null auto_increment,
username varchar(15) not null,
user_first_name varchar(15) not null,
user_last_name varchar(15) not null,
user_email varchar(30) not null,
user_password varchar(15) not null,
user_phone_number varchar(15),
user_street varchar(20),
user_street_number varchar(5),
user_postal_code int(5),
user_type enum('customer','secretary','captains','team_leader','other_employee', 'other'),
PRIMARY KEY (user_id)


);



create table camper (
camper_id int(5) not null auto_increment,
camper_first_name varchar(15) not null,
camper_last_name varchar(15) not null,
camper_birthday date not null,
camper_gender enum('male','female'),
camper_street varchar(20),
camper_street_number varchar(5),
camper_postal_code int(5),

PRIMARY KEY (camper_id)


);

alter table camper 
add camper_now boolean not null default 0;




create table is_parent (
is_parent_id int(5) not null auto_increment,
kids_id int(5) not null,
parent_id int(5) not null,

camper_birthday date not null,
camper_gender enum('male','female'),
camper_street varchar(20),
camper_street_number varchar(5),
camper_postal_code int(5),

PRIMARY KEY (is_parent_id),
constraint gurdian foreign key (parent_id) 
	references user(user_id) 
	on update cascade on delete no action,
constraint child foreign key (kids_id) 
	references camper(camper_id) 
	on update cascade on delete cascade
);

create table message (
message_id int(5) not null auto_increment,
message_time timestamp not null default current_timestamp,
message_user_from int(5) not null,
message_user_to int(5) not null,
message_from_flag boolean not null default 0,
message_to_flag boolean not null default 0,
message_read_time timestamp default null,
message_parrent_id int(5) default null,
message_header tinytext not null,
message_main text(3000) not null, 

PRIMARY KEY (message_id),
constraint sender foreign key (message_user_from) 
	references user(user_id) 
	on update cascade on delete no action,
constraint recipient foreign key (message_user_to) 
	references user(user_id) 
	on update cascade on delete no action,
constraint reply_message foreign key (message_parrent_id) 
	references message(message_id) 
	on update cascade on delete no action
);

create table camping_periods (
c_p_id int(5) not null auto_increment ,
c_p_start date not null,
c_p_end date not null,
PRIMARY KEY (c_p_id)

);
create table insurer (
insurer_id int(5) not null auto_increment ,
insurer_name date not null,
insurer_no_kids int(3) not null default 0,
insurer_basic_discount int(2) not null default 0,
insurer_medium_discount int(2) not null default 0,
insurer_high_discount int(2) not null default 0,
insurer_bank_account int(16) not null,
PRIMARY KEY (insurer_id)

);


create table application (
apps_id int(5) not null auto_increment,
apps_time timestamp not null default current_timestamp,
apps_parrent int(5) not null,
apps_cost float(4,2) not null,
apps_insurance int(5) default null,
apps_insurance_id int(11) default null,
apps_read boolean not null default 0,
apps_period_id int(5) not null,
apps_status enum('declined','accepted','pending') default 'pending',

PRIMARY KEY (apps_id),
constraint apps_from foreign key (apps_parrent) 
	references user(user_id) 
	on update cascade on delete cascade,
constraint apps_period foreign key (apps_period_id) 
	references camping_periods(c_p_id) 
	on update cascade on delete no action,
constraint insurer_is foreign key (apps_insurance) 
	references insurer(insurer_id) 
	on update cascade on delete set null
);
//enwnei application me camper
create table apps_kid (
application_id int(5) not null,
application_kid_id int(5) not null,


constraint pk_app PRIMARY KEY (application_kid_id,application_id)
	
);