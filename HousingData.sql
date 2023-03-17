Select *
From PortfolioProject..NashvileHousing

--Standardize Data format

Select SaledateConverted, Convert(Date,SaleDate)
From PortfolioProject..NashvileHousing


Update NashvileHousing
SET SaleDate = Convert(Date,SaleDate)

ALTER TABLE NashvileHousing
Add SaleDateConverted Date;

Update NashvileHousing
SET SaleDateDateConverted = Convert(Date,SaleDate)

--Populate Property Address Data

Select *
From PortfolioProject..NashvileHousing
--Where PropertyAddress is Null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvileHousing a
JOIN PortfolioProject..NashvileHousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress IS NULL

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject..NashvileHousing a
JOIN PortfolioProject..NashvileHousing b
     on a.ParcelID = b.ParcelID
	 AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress IS NULL


--Breaking out address into Individual Columns (Address, City, State)

Select PropertyAddress
From PortfolioProject..NashvileHousing
--Where PropertyAddress is Null
--order by ParcelID

Select
Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
,Substring(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

From PortfolioProject..NashvileHousing

ALTER TABLE NashvileHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvileHousing
SET PropertySplitAddress = Substring(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

ALTER TABLE NashvileHousing
Add PropertySplitCity  Nvarchar(255);

Update NashvileHousing
SET PropertySplitCity = Substring(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN (PropertyAddress))

Select *
From PortfolioProject..NashvileHousing



Select OwnerAddress
From PortfolioProject..NashvileHousing


Select
PARSENAME(REPLACE(OwnerAddress,',', '.') ,3)
,PARSENAME(REPLACE(OwnerAddress,',', '.') ,2)
,PARSENAME(REPLACE(OwnerAddress,',', '.') ,1)
From PortfolioProject..NashvileHousing



ALTER TABLE PortfolioProject.dbo.NashvileHousing
Add OwnerSplitAddress Nvarchar(255);

Update PortfolioProject..NashvileHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.') ,3)

ALTER TABLE PortfolioProject..NashvileHousing
Add OwenerSplitCity  Nvarchar(255);

Update PortfolioProject..NashvileHousing
SET OwenrSplitCity = PARSENAME(REPLACE(OwnerAddress,',', '.') ,2)

ALTER TABLE PortfolioProject..NashvileHousing
Add OwnerSplitState Nvarchar(255);

Update PortfolioProject..NashvileHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', '.') ,1)


Select *
From PortfolioProject..NashvileHousing


--Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.dbo.NashvileHousing
Group by SoldAsVacant
Order by 2


Select SoldAsVacant
, Case When SoldAsVacant = 'Y' Then 'Yes'
       When SoldAsVacant = 'N' THEN 'No'
	   Else SoldAsVacant
	   END
From PortfolioProject..NashvileHousing


Update PortfolioProject.dbo.NashvileHousing
SET SoldAsVacant = Case When SoldAsVacant = 'Y' THEN 'Yes'
       When SoldAsVacant = 'N' THEN 'No'
	   Else SoldAsVacant
	   END



--Remove Duplicates

WITH RowNumCTE AS(
Select*,
     Row_number()Over(
	 PARTITION BY ParcelID,
	              PropertyAddress,
				  SalePrice,
				  SaleDate,
				  LegalReference
				  ORDER by
				       UniqueID
					   ) Row_num


FROM PortfolioProject..NashvileHousing
--Order by ParcelID
)
SELECT *
FROM RowNumCTE
Where row_num > 1
Order by PropertyAddress


--Delete Unused Columns


SELECT *
FROM PortfolioProject..NashvileHousing


ALTER TABLE PortfolioProject..NashvileHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


ALTER TABLE PortfolioProject..NashvileHousing
DROP COLUMN SaleDate