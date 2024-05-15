-- portfolio project 


--cleanning data


select * from NashvilleHousing

--standardize date format


select SaleDate,convert (date,SaleDate)
from NashvilleHousing
 ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;
Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)





-- Populate Property Address data
 select UniqueID , ParcelID, PropertyAddress 

 from NashvilleHousing
 where PropertyAddress  is null
order by ParcelID

 select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress,isnull(a.PropertyAddress,b.PropertyAddress)
 from NashvilleHousing a join NashvilleHousing b 
 on a.ParcelID=b.ParcelID
 and a.[UniqueID ]<> b.[UniqueID ]
-- where a.PropertyAddress is null


  update a
   set PropertyAddress =isnull(a.PropertyAddress,b.PropertyAddress)

   from NashvilleHousing a join NashvilleHousing b 
 on a.ParcelID=b.ParcelID
 and a.[UniqueID ]<> b.[UniqueID ]
 where a.PropertyAddress is null
 





 -- Breaking out Address into Individual Columns (Address, City, State)


 -- first the PropertyAddress
 
Select PropertyAddress
From NashvilleHousing

--Where PropertyAddress is null
--order by ParcelID


SELECT 
    PropertyAddress,
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
    SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1 , LEN(PropertyAddress)) AS RemainingAddress
FROM 
    NashvilleHousing;

	alter table NashvilleHousing
	add PropertyspiltAddress nvarchar(300)


	update NashvilleHousing
	 set PropertyspiltAddress =SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)
	 



	alter table NashvilleHousing
	add Propertycity nvarchar(300) 


	update NashvilleHousing
	set  Propertycity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1 , LEN(PropertyAddress))
	 

	 select * from NashvilleHousing


	 --second ownername
	 select   ownername ,
	  parsename(replace(ownername ,',','.'),3),
	  parsename(replace(ownername ,',','.'),2),
	  parsename(replace(ownername ,',','.'),1)

	  from NashvilleHousing



	  alter table NashvilleHousing
      add ownersplitadress nvarchar (300)

	  update NashvilleHousing
	  set ownersplitadress = parsename(replace(ownername ,',','.'),3)





	  alter table NashvilleHousing
      add ownersplitstate nvarchar (300)

	  update NashvilleHousing
	  set ownersplitstate = parsename(replace(ownername ,',','.'),2)





	   alter table NashvilleHousing
      add ownersplitcity nvarchar (300)

	  update NashvilleHousing
	  set ownersplitcity = parsename(replace(ownername ,',','.'),1)


	  select * from NashvilleHousing



	   


	   -- Change Y and N to Yes and No in "Sold as Vacant" field



	   Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant
order by 2



select SoldAsVacant,
case 
when SoldAsVacant = 'y' then 'yes'
when SoldAsVacant = 'n' then 'no'
else  SoldAsVacant 
end
from NashvilleHousing

update NashvilleHousing 
 set SoldAsVacant = 
 case 
when SoldAsVacant = 'y' then 'yes'
when SoldAsVacant = 'n' then 'no'
else  SoldAsVacant 
end

	   select * from NashvilleHousing




	   -- remove duplicate

	   WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From NashvilleHousing
--order by ParcelID
)
delete
From RowNumCTE
Where row_num > 1
--Order by PropertyAddress






-- Delete Unused Columns



--Select *
--From PortfolioProject.dbo.NashvilleHousing


--ALTER TABLE NashvilleHousing
--DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate





