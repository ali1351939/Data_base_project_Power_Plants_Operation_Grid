
### Physical Diagram
```
@startuml

entity Power_plant{
*p_id: integer <<generated>> <<pk>> 
--
*name:text
*capacity(Mw):numeric(6,2)
--
*t_id: integer <<fk>>
}


entity Power_plant_type{
*t_id:integer <<generated>> <<pk>>
--
*name: integer
*CO(ton/Gw)per_year:numeric(10,2) 
*CO2(ton/Gw)per_year:numeric(10,2) 
*SO2(ton/Gw)per_year:numeric(10,2) 
*NOX(ton/Gw)per_year:numeric(10,2) 
*steam(ton/Gw)per_year:numeric(10,2) 
*installation_cost($/Gw)::numeric(10,2) 
tax_return($/Gw):numeric(10,2) 
}

entity Tax_pollution {
*tax_pollution_id:integer <<generated>> <<pk>>
--
*name:text
*$per_ton: numeric(6,2)
}

entity Power_plant_conversion_cost{
*base_type: text 
*next_type text   
*conversion_cos_$perGw numeric(12, 2) <<default 0>>
*base_id: integer <<type_id>> <<fk>>
*next_id: integer  <<type_id>> <<fk>>
--
<<pk(base_id,next_id)>>
}

entity Country{
*country_id:integer <<generated>> <<pk>>
--
*name:text
*pick_demand_Gw:numeric(10,2)
*pick_supply_Gw:numeric(10,2)
}

entity Demand_hourly{
*hourly_id:integer <<generated>> <<pk>>
--
*local_time: integer
*utc_time: integer
*demand(Gw):numeric(10,2)
--
*country_id:integer <<fk>>
}
entity Country_PowerPlant{
* country_pp_id <<generated>> <<pk>>
--
*p_id: integer <<fk>>
*country_id: integer <<fk>>
}
entity PowerPlantType_Tax{
pptt_id: <<generated>> <<pk>>
--
*tax_pollution_id:integer <<fk>>
*t_id:integer <<fk>>
}
Power_plant " *   "-- " 1  " Power_plant_type

Power_plant_type " 1  "--"*" PowerPlantType_Tax
PowerPlantType_Tax" * "-"     1     "Tax_pollution

Power_plant_type " 1 "- " *"Power_plant_conversion_cost: from <
Power_plant_type " 1 "- " *"Power_plant_conversion_cost: to <
Power_plant"1"-"*"Country_PowerPlant
Country_PowerPlant"*"-"1"Country
Country "1"--"    24" Demand_hourly

@enduml
```
