# Data_base_project_Power_Plants_Operation_Grid
These days, Energy – Environment-Economic Impact (EEEI) is a critical subject. Human activity, especially in industry, residential and transportation sectors need energy carriers. The most important energy carrier is electricity. Electricity is produced at power plants. We can divide power plants into two overall kinds: Fossil and Green power plants. In fossil power plants, it is possible to use one of the fossils fuels which coal, oil and gas have the most application. This kind of power plant produces tons of greenhouse gases which lead to earth pollution and global warming. According to international agreements and protocols (i.e., Kyoto 1997 and Paris 2015), countries must do a lot of activities to reduce greenhouse gases production. The most important of such activities should apply to power plants. The final goal is converting all fossil power plants to green power plants using the new technologies and innovative methods. The most important green power plants are: Solar, Wind and Geothermal. To encourage countries to apply these protocols there are some rules about taxes according to ton/year production of green house gases and tax return according to Mw/year production of green electricity.
In this project according to the data base of power plants in the world, we are going to find the current condition in the point of EEEI view and prediction essential factors to improve future condition.   
Some of the most important questions which can be answered, using this project, are listed below:
1-	How much green and fossil electricity is produced in each country and all the world?
2-	How much greenhouse gas emissions are produced in each country and all the world?
3-	How much is net tax for each country? 
4-	How much money each country should investigate to convert all (or part) of its fossil power plants to green one?
5-	How much is the percentage contribution for each country in greenhouse production?
6-	Which countries are the greenest countries?
7-	How much money each country earns because of its green power plants?
…
One abstract of data which will be needed for this project is given below:

-	 “Power Plants" list  . Main columns:(p_id, power plant name, name of country, power plant type, capacity (Mw…). A table containing information about the power plants. For example country, capacity, type …
-	 “Demand and Supply Energy list”. Main columns:(e_id, demand, supply…). A table containing information about demand and supply of energy for each country.
-	“Power Plant Type list”. Main columns:(t_id, type…). In this table one id is assigned to each type of power plant.
-	“Pollution Power Plant list”. Main columns:(po_id, CO2, CO, SO2, NOX …[Ton/Mw]…). Fossil power plants produce greenhouse gases. This table propose average quantity of these gases for each type of power plant.
-	“Tax-pollution list”. Main columns:( po_id, CO2, CO, SO2, NOX …,[$/ton]…). Using this table, we can find the tax for each greenhouse gas.
-	“Tax Return list”. Main columns:( p_id, tax return[$]…). According to international protocols, production of electricity using green energies lead to tax-return and this table gives us information in this regard.
-	“Power Plant Installation Cost”. Main columns:( p_id, cost [$/ton]…). Using this table, we can find the cost for installation each type of power plant.
-	 “Power Plant Conversion Cost”. Main columns:( p_id, cost [$/ton…). Using the exist power plants we can decrease the cost for converting fossil to green power plants. This table propose the information in this regard
