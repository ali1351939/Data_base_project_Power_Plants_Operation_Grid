create schema power_plants;
set search_path to power_plants;

create table country
(
    country_id    integer generated by default as identity primary key,
    name           text           not null,
    pick_demand_Gw numeric(10, 2) not null,
    check (pick_demand_Gw>0),
    pick_supply_Gw numeric(10, 2) not null,
     check (pick_supply_Gw>0)
);


create table power_plant_type
(
    t_id                     integer generated by default as identity primary key,
    name                     text        not null,
    installation_cost_$PerMw numeric(12, 2) not null,
    tax_return_$PerGw        numeric(12, 2),
    CO_tonPerGw             numeric(12, 2),
    CO2_tonPerGw             numeric(12, 2),
    SO2_tonPerGw             numeric(12, 2),
    NOX_tonPerGw             numeric(12, 2),
    steam_tonPerGw           numeric(12, 2)
);

create table power_plant
(
    p_id        integer generated by default as identity primary key,
    name        text                                       not null,
    country_id  integer references country (country_id) not null,
    capacity_Mw numeric(6, 2)                              not null,
    t_id        integer references power_plant_type (t_id) not null
);



create table country_powerplant
(
    country_pp_id integer generated by default as identity primary key,
    powerplant_id integer references power_plant (p_id)   not null,
    country_id    integer references country (country_id) not null
);

create table demand_hourly
(
    hourly_id  integer generated by default as identity primary key,
    country_id integer references country (country_id) not null,
    local_time integer                                 not null,
    utc_time   integer                                 not null,
    demand_Gw  numeric(10, 2)                          not null

);



create table tax_pollution
(
    tax_pollution_id integer generated always as identity primary key,
    name             text           not null,
    tax_$perton      numeric(10, 2)  default (0) not null

);

create table powerplant_type_tax
(
    pptt_id  integer generated by default as identity primary key,
    t_id     integer references power_plant_type (t_id)   not null,
    tax_pollution_id integer references tax_pollution (tax_pollution_id)
);

create table powerplant_conversion_cost
(
    base_type text                                       not null,
    next_type text                                       not null,
    base_id   integer references power_plant_type (t_id) not null,
    next_id   integer references power_plant_type (t_id) not null,
    conversion_cos_$perGw numeric(12, 2),
    primary key (base_id, next_id)
);





