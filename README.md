# HousingData


In this SQL project, I demonstrated my ability to effectively manipulate and clean data, ensuring its consistency and reliability for analysis.
The project involved the following tasks:

1. Retrieving all data from the NashvilleHousing table.
2. Standardizing the date format by converting the SaleDate column to the DATE data type, creating a new SaleDateConverted column, and updating it with the 
   standardized dates.
3. Identifying and populating missing property address data by finding NULL values in the PropertyAddress column and updating them with corresponding non-null 
   values from the same ParcelID.
4. Breaking property address data into individual columns, including Address, City, and State, by extracting substrings and updating the NashvilleHousing table 
   with the new columns and extracted values.
5. Parsing owner address data into separate columns for Address, City, and State, and updating the NashvilleHousing table with the parsed values.
6. Updating the "Sold as Vacant" field to replace 'Y' and 'N' with 'Yes' and 'No' for better readability.
7. Identifying and removing duplicate records using a common table expression (CTE) with ROW_NUMBER() function.
8. Removing unused columns from the NashvilleHousing table to optimize data storage and analysis.
9. These tasks showcase my expertise in SQL data manipulation, data cleaning, and data consistency management, essential skills for a data professional.



