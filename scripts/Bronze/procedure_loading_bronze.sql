/*

Stored procedure to load bronze layer
=======================================================
This SQL script defines a stored procedure named bronze.load_bronze for a data warehouse project. Its primary purpose is to orchestrate the Data Ingestion process for the Bronze Layer (the raw staging area of a data warehouse).
=========================================================
*/
Create or alter procedure bronze.load_bronze as

Begin
Declare @start_time DATETIME, @end_time DATETIME;
Begin try	
print'==================================';
print 'loading bronze layer';
print '=================================';

print 'LOADING CRM TABLES';
PRINT '---------------------------------'

SET @start_time = GETDATE();
TRUNCATE table bronze.crm_cust_info;

Bulk insert bronze.crm_cust_info
FROM 'D:\warehouse\source_crm\cust_info.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
SET @end_time = GETDATE();
PRINT '>> LOAD DURATION' + CAST(DATEDIFF(second , @start_time , @end_time) as NVARCHAR) + 'SECONDS';
PRINT '--------------------------------------------------';

SELECT COUNT(*) FROM bronze.crm_cust_info

SET @start_time = GETDATE();

TRUNCATE table bronze.crm_prd_info;
Bulk INSERT bronze.crm_prd_info
FROM 'D:\warehouse\source_crm\prd_info.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
	
);
SET @end_time = GETDATE();
PRINT '>> LOAD DURATION' + CAST(DATEDIFF(second , @start_time , @end_time) as NVARCHAR) + 'SECONDS';
PRINT '--------------------------------------------------';

SELECT COUNT(*) FROM bronze.crm_prd_info

SET @start_time = GETDATE();
TRUNCATE table bronze.crm_sales_details;
Bulk INSERT bronze.crm_sales_details
FROM 'D:\warehouse\source_crm\sales_details.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK	
);
SET @end_time = GETDATE();
PRINT '>> LOAD DURATION' + CAST(DATEDIFF(second , @start_time , @end_time) as NVARCHAR) + 'SECONDS';
PRINT '--------------------------------------------------';

SELECT COUNT(*) FROM bronze.crm_sales_details

PRINT 'LOADING ERP TABLES'
PRINT '---------------------------------------'

SET @start_time = GETDATE();
TRUNCATE table bronze.erp_CUST_AZ12;
Bulk INSERT bronze.erp_CUST_AZ12
FROM 'D:\warehouse\source_erp\CUST_AZ12.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK	
);
SET @end_time = GETDATE();
PRINT '>> LOAD DURATION' + CAST(DATEDIFF(second , @start_time , @end_time) as NVARCHAR) + 'SECONDS';
PRINT '--------------------------------------------------';

SELECT COUNT(*) FROM bronze.erp_CUST_AZ12

SET @start_time = GETDATE();
TRUNCATE table bronze.erp_LOC_A101;
Bulk INSERT bronze.erp_LOC_A101
FROM 'D:\warehouse\source_erp\LOC_A101.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK	
);
SET @end_time = GETDATE();
PRINT '>> LOAD DURATION' + CAST(DATEDIFF(second , @start_time , @end_time) as NVARCHAR) + 'SECONDS';
PRINT '--------------------------------------------------';

SELECT COUNT(*) FROM bronze.erp_LOC_A101

SET @start_time = GETDATE();
TRUNCATE table bronze.erp_PX_CAT_G1V2;
Bulk INSERT bronze.erp_PX_CAT_G1V2
FROM 'D:\warehouse\source_erp\PX_CAT_G1V2.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK	
);
SET @end_time = GETDATE();
PRINT '>> LOAD DURATION' + CAST(DATEDIFF(second , @start_time , @end_time) as NVARCHAR) + 'SECONDS';
PRINT '--------------------------------------------------';

SELECT COUNT(*) FROM bronze.erp_PX_CAT_G1V2


End try
Begin Catch
	print 'ERROR OCCURED DURING LOADING OF BRONZE LAYER'
	PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
END catch
end
