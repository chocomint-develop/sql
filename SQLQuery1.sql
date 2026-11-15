CREATE DATABASE QLDUAN 
GO
USE QLDUAN 
GO

CREATE TABLE PHONGBAN (
    MaPB int NOT NULL,
    TenPB nvarchar(50) NOT NULL,
    Trg_PB char(9),
    NgayNC datetime,
    CONSTRAINT PK_PB PRIMARY KEY (MaPB)
);

CREATE TABLE NHANVIEN (
    MaNV char(9) NOT NULL,
    HoNV nvarchar(15) NOT NULL,
    TenDem nvarchar(15) NOT NULL,
    TenNV nvarchar(15) NOT NULL,
    NgSinh datetime,
    DChi nvarchar(100),
    GTinh nvarchar(3) NOT NULL, 
    Luong float,
    MaGSat char(9),
    Phong int,
    
    CONSTRAINT PK_NV PRIMARY KEY (MaNV),
    CONSTRAINT FK_NV_PB FOREIGN KEY (Phong) REFERENCES PHONGBAN(MaPB),
    CONSTRAINT FK_NV_NQL FOREIGN KEY (MaGSat) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT CHK_Phai CHECK (GTinh IN (N'nam', N'nữ'))
);

CREATE TABLE THANNHAN 
(
    MaNV char (9) NOT NULL,
    TenNV nvarchar(15) NOT NULL,
    GTinh nvarchar(3) NOT NULL, 
    NgSinh datetime,
    QuanHe nvarchar(10),
    CONSTRAINT TN_MaNV_TenNV_PK PRIMARY KEY (MaNV, TenNV),
    CONSTRAINT TN_MaNV_FK FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)

CREATE TABLE DIADIEMPHONG (
    MaPB INT NOT NULL,
    DiaDiem nvarchar(50) NOT NULL,
    CONSTRAINT PK_DIADIEM PRIMARY KEY (MaPB, DiaDiem),
    CONSTRAINT FK_DD_PB FOREIGN KEY (MaPB) REFERENCES PHONGBAN(MaPB)
);
GO

ALTER TABLE PHONGBAN
ADD CONSTRAINT FK_PB_NV FOREIGN KEY (Trg_PB) REFERENCES NHANVIEN(MaNV);
GO

-- 3.4 THUC HANH ALTER VA EXEC
SELECT *
FROM THANNHAN 
GO

ALTER TABLE PHONGBAN 
ADD NamTL int
GO

ALTER TABLE PHONGBAN 
ALTER COLUMN NamTL smallint 
GO

ALTER TABLE NHANVIEN 
ALTER COLUMN GTinh nvarchar(3) 
GO

EXEC sp_rename 'PHONGBAN.NamTL', 'NamThanhLap'
GO

ALTER TABLE PHONGBAN 
ADD CONSTRAINT PB_NamThanhLap_CK CHECK (NamThanhLap >= 1990)
GO

ALTER TABLE PHONGBAN 
DROP PB_NamThanhLap_CK 
GO

ALTER TABLE PHONGBAN
DROP COLUMN NamThanhLap
GO
--

-- INSERT DATA

INSERT INTO PHONGBAN (MaPB, TenPB, Trg_PB, NgayNC) VALUES
('5', N'Quản Lý',NULL, '06/22/1988'),
('4', N'Điều Hành',NULL, '01/01/1995'),
('1', N'Nghiên Cứu',NULL, '06/19/1981');

INSERT INTO NHANVIEN VALUES
('888665555', 'Le', 'Van', 'Bo', '11/10/1937', '45 Ho Van Hue, Phu Nhuan, TPHCM', N'nam', 55000, NULL, 1),
('333445555', 'Phan', 'Van', 'Nghia', '12/08/1955', '63 Tran Huy Lieu, Phu Nhuan, TPHCM', N'nam', 40000, '888665555', 5),
('123456789', 'Nguyen', 'Bao', 'Hung', '01/09/1965', '73 Phan Dang Luu, Phu Nhuan, TPHCM', N'nam', 30000, '333445555', 5),
('666884444', 'Tran', 'Van', 'Nam', '09/15/1962', '97 Dien Bien Phu, Binh Thanh, TPHCM', N'nam', 38000, '333445555', 5),
('453453453', 'Hoang', 'Kim', 'Yen', '07/31/1972', '56 Thich Quang Duc, Phu Nhuan, TPHCM', N'nữ', 25000, '333445555', 5),
('987654321', 'Du', 'Thi', 'Hau', '06/20/1941', '29 Bach Dang, Tan Binh, TPHCM', N'nữ', 43000, '888665555', 4),
('999887777', 'Au', 'Thi', 'Vuong', '01/19/1968', '32 Cao Ba Nha, Q1, TPHCM', N'nữ', 25000, '987654321', 4),
('987987987', 'Nguyen', 'Van', 'Giap', '03/29/1969', '98 Huynh Van Banh, Phu Nhuan, TPHCM', N'nam', 25000, '987654321', 4);


INSERT INTO DIADIEMPHONG VALUES 
(1, 'Phu Nhuan'),
(4, 'Go Vap'),
(5, 'Tan Binh'),
(5, 'Thu Duc'),
(5, 'Phu Nhuan')

INSERT INTO THANNHAN VALUES
('333445555','Anh','Nu','04/05/1986','Con gai'),
('333445555','The','Nam','10/25/1983','Con trai'),
('333445555','Loi','Nu','05/03/1958','Vo'),
('987654321','An','Nam','02/28/1942','Chong'),
('123456789','Minh','Nam','01/04/1988','Con trai'),
('123456789','Anh','Nu','12/30/1988','Con gai'),
('123456789','Yen','Nu','05/05/1967','Vo')
GO

UPDATE PHONGBAN
SET Trg_PB = '333445555'
WHERE MaPB = 5

UPDATE PHONGBAN
SET Trg_PB = '987654321'
WHERE MaPB = 4

UPDATE PHONGBAN
SET Trg_PB = '888665555'
WHERE MaPB = 1