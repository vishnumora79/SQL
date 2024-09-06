create table machine(Date varchar,Machine_ID varchar,Assembly_Line_No varchar,
					 Hydraulic_Pressure float,Coolant_Pressure float,
					 Air_System_Pressure float,Coolant_Temperature float,
					 Hydraulic_Oil_Temperature FLOAT,Spindle_Bearing_Temperature float,
					 Spindle_Vibration float,Tool_Vibration float,Spindle_Speed int,
					 Voltage int,Torque float,Cutting float,Downtime varchar);
					 		
select * from machine;		

-- Exploratory data analysis on raw data
-- 1.checking datatype of each column

create view datatype as (
select column_name,data_type 
from information_schema.columns
where table_name = 'machine' and column_name in ('date','machine_id','assembly_line_no',
												 'hydraulic_pressure','coolent_pressure','air_system_pressure','coolent_temperature',
												 'hydraulic_oil_temperature','splindle_bearing_temperature','splindle_vibration',
												 'tool_vibration','spindle_speed','voltage','torque','cutting','downtime'
												));
select * from datatype;												
												
												
-- 2.Calculating mode for categorical variable

SELECT date AS mode_product, COUNT(date) AS mode_count
FROM machine
GROUP BY date
ORDER BY mode_count DESC
LIMIT 1;

select machine_id as mode_item ,count(machine_id) as mode_count
from machine
group by machine_id
order by mode_count desc limit 1;

select Assembly_line_no ,count(Assembly_line_no) 
from machine
group by Assembly_line_no
order by count(Assembly_line_no) desc limit 1;
			
-- Calculate mean & median for contineous variables

-- mean of hydraulic-pressure
select avg(Hydraulic_Pressure)
from machine;

-- mean of coolant-pressure
select avg(Coolant_pressure)
from machine;

-- mean of air-system-pressure
select avg(air_system_pressure)
from machine;

-- mean of coolant-temperature
select avg(coolant_temperature)
from machine;

-- mean of Hydraulic_oil_temperature
select avg(Hydraulic_oil_temperature) 
from machine;

-- mean of spindle_bearing_temperature 
select avg(spindle_bearing_temperature)
from machine;

-- mean of spindle-vibration
select avg(spindle_vibration)
from machine;

-- mean of tool-vibration
select avg(Tool_vibration) 
from machine;

-- mean of spindle-speed
select avg(spindle_speed) 
from machine;

-- mean of voltage
select avg(voltage) from machine;

-- mean of torque
select avg(torque) from machine;

-- mean of cutting
select avg(cutting) from machine;  

-- median of cutting
select median from (
  select cutting as median
  from machine
  order by cutting
  limit 1 offset 1250) as middle_value;

-- median of torque
select median from (
  select torque as median
  from machine
  order by torque
  limit 1 offset 1250) AS middle_value;  

-- median of voltage
select median from (select voltage as median
					from machine
					order by voltage
					limit 1 offset 1250) as median_value;

-- median of spindle-speed					
select median from (select spindle_speed as median
				   from machine
				   order by spindle_speed
				   limit 1 offset 1250)as median_value;	
				   
-- median of tool-vibration				   
select median from (select tool_vibration as median
				   from machine
				   order by tool_vibration
				   limit 1 offset 1250) as median_value;	
				   
-- median of spindle vibration
select median from (select spindle_vibration as median
				   from machine
				   order by spindle_vibration
				   limit 1  offset 1250) as median_value;

-- median of spindle-bearing-temperature
select median from (select spindle_bearing_temperature as median
				   from machine
				   order by spindle_bearing_temperature
				   limit 1 offset 1250) as median_value;
				   
-- median of hydraulic oil temperature
select median from (select hydraulic_oil_temperature as median
				   from machine
				   order by hydraulic_oil_temperature
				   limit 1 offset 1250) as median_value;

-- median of coolant temperature
select median from (select coolant_temperature
				   as median from machine
				   order by coolant_temperature
				   limit 1 offset 1250) as median_a;
				   
-- median of air system pressure				   
select median from (select air_system_pressure as median
				   from machine order by air_system_pressure
					limit 1 offset 1250) as m;
					
select percentile_cont(0.5) 
within group (order by air_system_pressure) as median
from machine;
					
					
-- median of coolant pressure
select median from (select coolant_pressure
				   as median from machine
				   order by coolant_pressure
				   limit 1 offset 1250) as m;
				   
SELECT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY coolant_pressure) AS median
FROM
  machine;				   
				   
-- median of hydraulic pressure
select median from (select hydraulic_pressure
				   as median from machine
				   order by hydraulic_pressure
				   limit 1 offset 1250) as m;
				   
SELECT
  PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY hydraulic_pressure) AS median
FROM
  machine;		
  
-- standard deviation of contineous data

select 
   stddev(hydraulic_pressure) as sd1,
   stddev(coolant_pressure) as sd2,
   stddev(air_system_pressure) as sd3,
   stddev(coolant_temperature) as sd4,
   stddev(hydraulic_oil_temperature) as sd5,
   stddev(spindle_bearing_temperature) as sd6,
   stddev(spindle_vibration) as sd7,
   stddev(tool_vibration) as sd8,
   stddev(spindle_speed) as sd9,
   stddev(voltage) as sd10,
   stddev(torque) as sd11,
   stddev(cutting) as sd12
from machine; 

-- range of continuous variables

select 
  max(hydraulic_pressure) - min(hydraulic_pressure) as range1 ,
  max(coolant_pressure) - min(coolant_pressure) as range2,
  max(air_system_pressure) - min(air_system_pressure) as range3,
  max(coolant_temperature) - min(coolant_temperature) as range4,
  max(hydraulic_oil_temperature) - min(hydraulic_oil_temperature) as range5,
  max(spindle_bearing_temperature) - min(spindle_bearing_temperature) as range6,
  max(spindle_vibration) - min(spindle_vibration) as range7,
  max(tool_vibration) -min(tool_vibration) as range8,
  max(spindle_speed) - min(spindle_speed) as range9,
  max(voltage) - min(voltage) as range10,
  max(torque) - min(torque) as range11,
  max(cutting) - min(cutting) as range12
from machine;  
		
-- PREPROCESSING

-- checking the number of missing values in each column

create view count_data as (
select 
	count(date) as date_count,
	count(Machine_ID) as id_count,
	count(assembly_line_no) as assembly_line_no_values,
    count(hydraulic_pressure) as hydraulic_pressure,
	count(coolant_pressure) as coolant_pressure_values,
	count(air_system_pressure) as air_system_values,
	count(coolant_temperature) as coolant_temp_values,
	count(hydraulic_oil_temperature) as hydraulic_oil_temp_values,
	count(spindle_bearing_temperature) as spindle_bear_values,
	count(spindle_vibration) as spindle_vibration_values,
	count(tool_vibration) as tool_vibration_values,
	count(spindle_speed) as spindle_speed_values,
	count(voltage) as voltage_values,
	count(torque) as torque_values,
	count(cutting) as cutting_values
from machine);	

select * from count_data;

create view missing as (
  SELECT
    SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS c1,
    SUM(CASE WHEN machine_id IS NULL THEN 1 ELSE 0 END) AS c2,
    SUM(CASE WHEN assembly_line_no IS NULL THEN 1 ELSE 0 END) AS c3,
	SUM(CASE WHEN hydraulic_pressure IS NULL THEN 1 ELSE 0 END) AS c4,
	SUM(CASE WHEN coolant_pressure IS NULL THEN 1 ELSE 0 END) AS c5,
	    SUM(CASE WHEN air_system_pressure IS NULL THEN 1 ELSE 0 END) AS c6,
	    SUM(CASE WHEN coolant_temperature IS NULL THEN 1 ELSE 0 END) AS c7,
	    SUM(CASE WHEN hydraulic_oil_temperature IS NULL THEN 1 ELSE 0 END) AS c8,
	    SUM(CASE WHEN spindle_bearing_temperature IS NULL THEN 1 ELSE 0 END) AS c9,
	    SUM(CASE WHEN spindle_vibration IS NULL THEN 1 ELSE 0 END) AS c10,
	SUM(CASE WHEN tool_vibration IS NULL THEN 1 ELSE 0 END) AS c11,
	SUM(CASE WHEN spindle_speed IS NULL THEN 1 ELSE 0 END) AS c12,
	SUM(CASE WHEN voltage IS NULL THEN 1 ELSE 0 END) AS c13,
	SUM(CASE WHEN torque IS NULL THEN 1 ELSE 0 END) AS c14,
	SUM(CASE WHEN cutting IS NULL THEN 1 ELSE 0 END) AS c15
FROM machine);

select * from missing;
);
					 
-- set datestyle = 'ISO,DMY';					 


-- UPDATE machine
-- SET Date = TO_DATE(TO_CHAR(Date, 'YYYY-MM-DD'), 'YYYY-MM-DD');

-- show datestyle;