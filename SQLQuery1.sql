create database DA_hackathon;

use DA_hackathon;

select count(*) from Booking;

select top 3 * from invoice;


SELECT 
    a.Agency_Invoice_Number,
    a.Agency_Name,
    a.PNR AS Agency_PNR,
    a.Ticket_Number AS Agency_Ticket,
    a.Transaction_Amount_INR,
    a.Transaction_Date,
    a.Vendor AS Agency_Vendor,
    a.Transaction_Type,

    b.Supplier_GSTIN,
    b.Invoice_Number,
    b.Invoice_Date,
    b.PNR AS Supplier_PNR,
    b.Ticket_Number AS Supplier_Ticket,
    b.Invoice_Total_Amount,
    b.Vendor AS Supplier_Vendor

INTO Booking_Invoice   

FROM Booking a
LEFT JOIN Invoice b
ON 
    
    (
        a.[Ticket_PNR] = b.[Ticket_PNR]
        OR a.PNR = b.PNR
        OR a.Ticket_Number = b.Ticket_Number
    )
	 
    AND a.Vendor = b.Vendor
    AND a.Transaction_Type = b.Transaction_Type  
    AND LEFT(a.Origin_City, 3) = b.Origin;

	select top 5 * from _2A_2B;

 ALTER TABLE Booking_Invoice
ADD Invoice_Status VARCHAR(20);


UPDATE Booking_Invoice
SET Invoice_Status =
    CASE 
        WHEN Supplier_PNR IS NOT NULL 
             OR Supplier_Ticket IS NOT NULL 
        THEN 'Invoice received'
        ELSE 'Not received'
    END;

ALTER TABLE Booking_Invoice
ADD GSTDifference float;

update Booking_Invoice set 
   
   GSTDifference= (b.K3 - ISNULL(i.Invoice_Total_GST, 0))
FROM Booking b
LEFT JOIN Invoice i
ON 
    LTRIM(RTRIM(b.PNR)) = LTRIM(RTRIM(i.PNR))


    OR LTRIM(RTRIM(b.Ticket_Number)) = LTRIM(RTRIM(i.Ticket_Number));



	Select top 5 * from Booking_Invoice;


	ALTER TABLE Booking_Invoice
ADD [2A_2B_Status] VARCHAR(30);


UPDATE bi
SET [2A_2B_Status] =
    CASE 
        WHEN g._2A_2B_Invoice_Note_Number IS NOT NULL 
        THEN 'Available in 2A/2B'
        ELSE 'Not in 2A/2B'
    END
FROM Booking_Invoice bi
LEFT JOIN _2A_2B g
    ON bi.Invoice_Number = g._2A_2B_Invoice_Note_Number
    AND bi.Transaction_Type = g.Transaction_Type;


	select vendor,sum(k3) from booking
	group by vendor;

