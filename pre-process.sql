-- PREPROCESSING

-- checking the number of missing values in each column


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
from machine_without_missing_values;	

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
	
-- Duplicates
create view remove_duplicates as (
select 
	count(distinct date) as date_count,
	count(distinct Machine_ID) as id_count,
	count(distinct assembly_line_no) as assembly_line_no_values,
    count(distinct hydraulic_pressure) as hydraulic_pressure,
	count(distinct coolant_pressure) as coolant_pressure_values,
	count(distinct air_system_pressure) as air_system_values,
	count(distinct coolant_temperature) as coolant_temp_values,
	count(distinct hydraulic_oil_temperature) as hydraulic_oil_temp_values,
	count(distinct spindle_bearing_temperature) as spindle_bear_values,
	count(distinct spindle_vibration) as spindle_vibration_values,
	count(distinct tool_vibration) as tool_vibration_values,
	count(distinct spindle_speed) as spindle_speed_values,
	count(distinct voltage) as voltage_values,
	count(distinct torque) as torque_values,
	count(distinct cutting) as cutting_values
from machine);

select * from remove_duplicates; 


-- Deleting missing values
create view removed_missing_values as(
delete from machine where 
date is null or
machine_id is null or
assembly_line_no is null or
hydraulic_pressure is null or
coolant_pressure is null or
air_system_pressure is null or
coolant_temperature is null or
hydraulic_oil_temperature is null or
spindle_bearing_temperature is null or
spindle_vibration is null or
tool_vibration is null or
spindle_speed is null or
voltage is null or
torque is null or
cutting is null);

CREATE TABLE machine_without_missing_values AS
SELECT *
FROM machine
WHERE
  date IS NOT NULL AND
  machine_id IS NOT NULL AND
  assembly_line_no IS NOT NULL AND
  hydraulic_pressure IS NOT NULL AND
  coolant_pressure IS NOT NULL AND
  air_system_pressure IS NOT NULL AND
  coolant_temperature IS NOT NULL AND
  hydraulic_oil_temperature IS NOT NULL AND
  spindle_bearing_temperature IS NOT NULL AND
  spindle_vibration IS NOT NULL AND
  tool_vibration IS NOT NULL AND
  spindle_speed IS NOT NULL AND
  voltage IS NOT NULL AND
  torque IS NOT NULL AND
  cutting IS NOT NULL;

select * from machine_without_missing_values;


-- Checking for outliers in each numerical column

WITH iqr_data AS (
  SELECT *,
         (SELECT percentile_cont(0.25) WITHIN GROUP (ORDER BY hydraulic_pressure) FROM machine_without_missing_values) AS q1,
         (SELECT percentile_cont(0.75) WITHIN GROUP (ORDER BY hydraulic_pressure) FROM machine_without_missing_values) AS q3
  FROM machine_without_missing_values
)
SELECT hydraulic_pressure
FROM iqr_data
WHERE hydraulic_pressure < q1 - 1.5 * (q3 - q1) OR hydraulic_pressure > q3 + 1.5 * (q3 - q1);


-- Create a common table expression (CTE) to calculate quartiles and IQR


WITH quartiles AS (
  SELECT hydraulic_pressure,coolant_pressure,air_system_pressure,
	coolant_temperature,hydraulic_oil_temperature,spindle_bearing_temperature
	spindle_vibration,tool_vibration,spindle_speed,voltage,torque,cutting,
    (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY hydraulic_pressure)from machine_without_missing_values) AS q1_hydraulic_pressure,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY hydraulic_pressure) FROM machine_without_missing_values) AS q3_hydraulic_pressure,
    (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY coolant_pressure) FROM machine_without_missing_values) AS q1_coolant_pressure,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY coolant_pressure) FROM machine_without_missing_values) AS q3_coolant_pressure,
    (SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY air_system_pressure) FROM machine_without_missing_values) AS q1_air_system_pressure,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY air_system_pressure) FROM machine_without_missing_values) AS q3_air_system_pressure,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY coolant_temperature) FROM machine_without_missing_values) AS q1_coolant_temperature,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY coolant_temperature) FROM machine_without_missing_values) AS q3_coolant_temperature,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY hydraulic_oil_temperature) FROM machine_without_missing_values) AS q1_hydraulic_oil_temperature,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY hydraulic_oil_temperature) FROM machine_without_missing_values) AS q3_hydraulic_oil_temperature,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY spindle_bearing_temperature) FROM machine_without_missing_values) AS q1_spindle_bearing_temperature,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY spindle_bearing_temperature) FROM machine_without_missing_values) AS q3_spindle_bearing_temperature,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY spindle_vibration) FROM machine_without_missing_values) AS q1_spindle_vibration,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY spindle_vibration) FROM machine_without_missing_values) AS q3_spindle_vibration,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY tool_vibration) FROM machine_without_missing_values) AS q1_tool_vibration,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY tool_vibration) FROM machine_without_missing_values) AS q3_tool_vibration,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY spindle_speed) FROM machine_without_missing_values) AS q1_spindle_speed,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY spindle_speed) FROM machine_without_missing_values) AS q3_spindle_speed,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY voltage) FROM machine_without_missing_values) AS q1_voltage,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY voltage) FROM machine_without_missing_values) AS q3_voltage,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY torque) FROM machine_without_missing_values) AS q1_torque,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY torque) FROM machine_without_missing_values) AS q3_torque,
	(SELECT PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY cutting) FROM machine_without_missing_values) AS q1_cutting,
    (SELECT PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY cutting) FROM machine_without_missing_values) AS q3_cutting
  FROM machine_without_missing_values
)
-- CREATE view cleaned_data AS
-- create table cleaned as
SELECT *
FROM quartiles
WHERE
  (hydraulic_pressure >= q1_hydraulic_pressure - 1.5 * (q3_hydraulic_pressure - q1_hydraulic_pressure)
   AND hydraulic_pressure <= q3_hydraulic_pressure + 1.5 * (q3_hydraulic_pressure - q1_hydraulic_pressure))
  AND
  (coolant_pressure >= q1_coolant_pressure - 1.5 * (q3_coolant_pressure - q1_coolant_pressure)
   AND coolant_pressure <= q3_coolant_pressure + 1.5 * (q3_coolant_pressure - q1_coolant_pressure))
  AND
  (air_system_pressure >= q1_air_system_pressure - 1.5 * (q3_air_system_pressure - q1_air_system_pressure)
   AND air_system_pressure <= q3_air_system_pressure + 1.5 * (q3_air_system_pressure - q1_air_system_pressure))
  AND
  (coolant_temperature >= q1_coolant_temperature - 1.5 * (q3_coolant_temperature - q1_coolant_temperature)
   AND coolant_temperature <= q3_coolant_temperature + 1.5 * (q3_coolant_temperature - q1_coolant_temperature))
  AND
  (hydraulic_oil_temperature >= q1_hydraulic_oil_temperature - 1.5 * (q3_hydraulic_oil_temperature - q1_hydraulic_oil_temperature)
   AND hydraulic_oil_temperature <= q3_hydraulic_oil_temperature + 1.5 * (q3_hydraulic_oil_temperature - q1_hydraulic_oil_temperature))
  AND
  (spindle_bearing_temperature >= q1_spindle_bearing_temperature - 1.5 * (q3_spindle_bearing_temperature - q1_spindle_bearing_temperature)
   AND spindle_bearing_temperature <= q3_spindle_bearing_temperature + 1.5 * (q3_spindle_bearing_temperature - q1_spindle_bearing_temperature))
  AND
  (spindle_vibration >= q1_spindle_vibration - 1.5 * (q3_spindle_vibration - q1_spindle_vibration)
   AND spindle_vibration <= q3_spindle_vibration + 1.5 * (q3_spindle_vibration - q1_spindle_vibration))
  AND
  (tool_vibration >= q1_tool_vibration - 1.5 * (q3_tool_vibration - q1_tool_vibration)
   AND tool_vibration <= q3_tool_vibration + 1.5 * (q3_tool_vibration - q1_tool_vibration))
  AND
  (voltage >= q1_voltage - 1.5 * (q3_voltage - q1_voltage)
   AND voltage <= q3_voltage + 1.5 * (q3_voltage - q1_voltage))
  AND
  (torque >= q1_torque - 1.5 * (q3_torque - q1_torque)
   AND torque <= q3_torque + 1.5 * (q3_torque - q1_torque))
  AND
  (cutting >= q1_cutting - 1.5 * (q3_cutting - q1_cutting)
   AND cutting <= q3_cutting + 1.5 * (q3_cutting - q1_cutting))
  AND
  (spindle_speed >= q1_spindle_speed - 1.5 * (q3_spindle_speed - q1_spindle_speed)
   AND spindle_speed <= q3_spindle_speed + 1.5 * (q3_spindle_speed - q1_spindle_speed));


WITH quartiles AS (
  SELECT
    (PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY hydraulic_pressure) FROM machine_without_missing_values) AS q1_hydraulic_pressure,
    (PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY hydraulic_pressure) FROM machine_without_missing_values) AS q3_hydraulic_pressure,
    -- Define quartiles for other variables here
  FROM machine_without_missing_values
)
CREATE TABLE cleaned_data AS
SELECT *
FROM machine_without_missing_values
WHERE
  (hydraulic_pressure >= q1_hydraulic_pressure - 1.5 * (q3_hydraulic_pressure - q1_hydraulic_pressure)
   AND hydraulic_pressure <= q3_hydraulic_pressure + 1.5 * (q3_hydraulic_pressure - q1_hydraulic_pressure));
  -- Add conditions for other variables here


-- Since there is a possibility of haing duplicate
-- values for numerical columns we are not removing duplicates for numerical column
	
	
	
select distinct(hydraulic_pressure) from machine_without_missing_values;	
	
	
	
	
	
	
	
	
	
	