set search_path to power_plants;

-- Q.1. Find total "Giga watt" power production in Europe for each type of power plant separately.


SELECT ppt.name, sum(pp.capacity_mw) AS total_in_Europe_production_Gw
FROM power_plant pp
         join power_plant_type ppt on pp.t_id = ppt.t_id
group by ppt.t_id
ORDER BY sum(pp.capacity_mw) DESC
;

-- Q.2. How much gas pollutions each country produce per year in owen power plants ?
--      (separately for each gas). Sort result by country name.

SELECT c.name,
       sum((co_tonpergw * pp.capacity_mw))    as ton_co_per_year,
       sum((co2_tonpergw * pp.capacity_mw))   as ton_co2_per_year,
       sum((so2_tonpergw * pp.capacity_mw))   as ton_so2_per_year,
       sum((nox_tonpergw * pp.capacity_mw))   as ton_nox_per_year,
       sum((steam_tonpergw * pp.capacity_mw)) as ton_steam_per_year
FROM country c
         join power_plant pp on c.country_id = pp.country_id
         join power_plant_type ppt on pp.t_id = ppt.t_id
GROUP BY c.name, c.country_id
ORDER BY c.name
;

--Q.3 How much tax each country has to pay because of pollution gas production in it's power plants?
-- (Don't forget tax returns for renewables)

WITH T1 AS (SELECT c.name,
                   ((sum((co_tonpergw * pp.capacity_mw))) * 60
                        + (sum((co2_tonpergw * pp.capacity_mw))) * 40
                        + (sum((so2_tonpergw * pp.capacity_mw))) * 70
                        + (sum((nox_tonpergw * pp.capacity_mw))) * 100
                        + (sum((steam_tonpergw * pp.capacity_mw))) * 10
                       - (ppt.tax_return_$pergw * pp.capacity_mw)) as net_tax
            FROM country c
                     join power_plant pp on c.country_id = pp.country_id
                     join power_plant_type ppt on pp.t_id = ppt.t_id
                     join tax_pollution tp on ppt.t_id = tp.tax_pollution_id
            GROUP BY (c.name), c.country_id, ppt.tax_return_$pergw, pp.capacity_mw
            ORDER BY c.name)
SELECT name, sum(net_tax)
FROM T1
GROUP BY (name);

--Q-4 Find the minimum cost to convert each non_renewable power plant to renewable one for Spain.

WITH T2 As
         (SELECT pp.name                                 as name_of_power_plant,
                 ppt.name                                as base,
                 pcc.next_type                           as next,
                 ((conversion_cos_$pergw) * capacity_mw) as conversion_cost
          FROM power_plant pp
                   join power_plant_type ppt on pp.t_id = ppt.t_id
                   join powerplant_conversion_cost pcc on base_id = pp.t_id
          WHERE pp.country_id = 9
          ORDER BY pp.name)
SELECT base, min(conversion_cost) as min_cost_to_convert_to_renewable
FROM T2
GROUP BY base;


--Q-5 At what time (local and utc time) during a day, Germany produce power more than it,s demand? And how much?

SELECT c.name, utc_time, local_time, demand_gw, (pick_supply_gw - demand_gw) as execss_production
FROM country c
         join demand_hourly dh on c.country_id = dh.country_id
where c.country_id = 5
  AND pick_supply_gw > demand_gw
;

--Q-6 Which countries are connected to power network of Germany?

SELECT distinct c.country_id, c.name
FROM power_plant pp
         JOIN country_powerplant cp ON pp.p_id = cp.powerplant_id
         JOIN country c ON cp.country_id = c.country_id
WHERE pp.country_id = 5;


--Q-7 Which connected countries need to Germany's excess power at over_supply time of Germany?

SELECT demander.name, demander.utc_time
FROM (SELECT c.name, utc_time, local_time, demand_gw, (pick_supply_gw - demand_gw) as execss_production
      FROM country c
               join demand_hourly dh on c.country_id = dh.country_id
      where c.country_id = 5
        AND pick_supply_gw > demand_gw) AS suplier
         JOIN (SELECT c.name, utc_time, local_time, demand_gw, (pick_supply_gw - demand_gw) as execss_production
               FROM country c
                        join demand_hourly dh on c.country_id = dh.country_id
               where c.country_id = 1
                  OR c.country_id = 3
                  OR c.country_id = 4
                  OR c.country_id = 18
                  OR c.country_id = 19 AND pick_supply_gw < demand_gw) AS demander
              on suplier.utc_time = demander.utc_time
ORDER BY demander.name;

