CREATE DATABASE CONGTY_GAY
GO
USE CONGTY_GAY
GO

CREATE TABLE PHONGBAN (
    MaPB varchar(10) NOT NULL,
    TenPB nvarchar(50) NOT NULL,
    Trg_PB varchar(10),
    NgayNC datetime,
    CONSTRAINT PK_PB PRIMARY KEY (MaPB)
);
GO

INSERT INTO PHONGBAN (MaPB, TenPB, NgayNC) VALUES
('QL', N'Quản Lý', '2000-05-22'),
('DH', N'Điều Hành', '2002-10-10'),
('NC', N'Nghiên Cứu', '2002-03-15');
GO

CREATE TABLE NHANVIEN (
    MaNV varchar(10) NOT NULL,
    HoNV nvarchar(30) NOT NULL,
    TenLot nvarchar(30) NOT NULL,
    TenNV nvarchar(30) NOT NULL,
    NgSinh datetime,
    Phai nvarchar(3) NOT NULL,
    DChi nvarchar(100),
    MaNQL varchar(10),
    Phg varchar(10),
    Luong float,
    CONSTRAINT PK_NV PRIMARY KEY (MaNV),
    CONSTRAINT FK_NV_PB FOREIGN KEY (Phg) REFERENCES PHONGBAN(MaPB),
    CONSTRAINT FK_NV_NQL FOREIGN KEY (MaNQL) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT CHK_Phai CHECK (Phai IN (N'nam', N'nữ'))
);
GO

ALTER TABLE PHONGBAN
ADD CONSTRAINT FK_PB_NV FOREIGN KEY (Trg_PB) REFERENCES NHANVIEN(MaNV);
GO

INSERT INTO NHANVIEN (MaNV, HoNV, TenLot, TenNV, NgSinh, Phai, DChi, MaNQL, Phg, Luong) VALUES
('001', N'VUONG', N'NGOC', N'QUYEN', '1957-10-10', N'nữ', N'HA NOI', NULL, 'QL', 3000000),
('002', N'NGUYEN', N'THANH', N'TUNG', '1955-09-01', N'nam', N'TPHCM', '001', 'NC', 2500000),
('003', N'LE', N'THI', N'NHAN', '1960-10-12', N'nữ', N'TPHCM', '001', 'DH', 2500000),
('004', N'DINH', N'BA', N'TIEN', '1968-09-01', N'nam', N'DONG THAP', '002', 'NC', 2200000),
('005', N'BUI', N'THUY', N'VU', '1973-08-06', N'nữ', N'TRA VINH', '003', 'DH', 2200000),
('006', N'NGUYEN', N'MANH', N'HUNG', '1981-10-08', N'nam', N'DONG NAI', '002', 'NC', 2000000),
('007', N'TRAN', N'HONG', N'VAN', '1976-02-08', N'nữ', N'VINH LONG', '004', 'NC', 1800000);
GO


UPDATE PHONGBAN SET Trg_PB = '001' WHERE MaPB = 'QL';
UPDATE PHONGBAN SET Trg_PB = '003' WHERE MaPB = 'DH';
UPDATE PHONGBAN SET Trg_PB = '002' WHERE MaPB = 'NC';
GO


CREATE TABLE DIADIEMPHONG (
    MaPB varchar(10) NOT NULL,
    DiaDiem nvarchar(50) NOT NULL,
    CONSTRAINT PK_DIADIEM PRIMARY KEY (MaPB, DiaDiem),
    CONSTRAINT FK_DD_PB FOREIGN KEY (MaPB) REFERENCES PHONGBAN(MaPB)
);
GO

CREATE TABLE DEAN (
    MaDA varchar(10) NOT NULL,
    TenDA nvarchar(50) NOT NULL,
    DdiemDA nvarchar(50),
    Phg varchar(10),
    NgayBD datetime,
    NgayKT datetime,
    CONSTRAINT PK_DEAN PRIMARY KEY (MaDA),
    CONSTRAINT FK_DEAN_PB FOREIGN KEY (Phg) REFERENCES PHONGBAN(MaPB)
);
GO

INSERT INTO DEAN (MaDA, TenDA, DdiemDA, Phg, NgayBD, NgayKT) VALUES
('TH001', N'Tin hoc hoa 1', N'Ha Noi', 'NC', '2003-02-01', '2004-02-01'),
('TH002', N'Tin hoc hoa 2', N'TPHCM', 'NC', '2003-06-04', '2004-02-04'),
('TH003', N'Tin hoc hoa 3', N'Da Lat', 'QL', '2006-12-01', '2006-12-01'),
('DT001', N'Dao tao 1', N'Nha Trang', 'DH', '2002-02-04', '2006-02-04'),
('DT002', N'Dao tao 2', N'Da Nang', 'DH', '2006-02-01', '2006-12-02');
GO

CREATE TABLE THANNHAN (
    MaTN int NOT NULL,
    TenTN nvarchar(50) NOT NULL,
    Phai nvarchar(3),
    NgSinh datetime,
    CONSTRAINT PK_THANNHAN PRIMARY KEY (MaTN)
);
GO

INSERT INTO THANNHAN (MaTN, TenTN, Phai, NgSinh) VALUES
(1, N'Tran Minh Tien', N'Nam', '1990-12-11'),
(2, N'Tran Ngoc Linh', N'Nữ', '1993-03-10'),
(3, N'Tran Minh Long', N'Nam', '1957-10-10'),
(4, N'Le Nhat Minh', N'Nam', '1955-04-27'),
(5, N'Le Hoai Thuong', N'Nữ', '1960-12-05'),
(6, N'Le Phi Phung', N'Nữ', '1960-12-24');
GO

CREATE TABLE NV_TNHAN (
    MaNV varchar(10) NOT NULL,
    MaTN int NOT NULL,
    QuanHe nvarchar(30),
    CONSTRAINT PK_NV_TN PRIMARY KEY (MaNV, MaTN),
    CONSTRAINT FK_NVTN_NV FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV),
    CONSTRAINT FK_NVTN_TN FOREIGN KEY (MaTN) REFERENCES THANNHAN(MaTN)
);
GO

INSERT INTO NV_TNHAN (MaNV, MaTN, QuanHe) VALUES
('003', 1, N'Con'),
('003', 2, N'Con'),
('003', 3, N'Vợ Chồng'),
('001', 1, N'Vợ Chồng'),
('002', 1, N'Vợ Chồng'),
('004', 1, N'Vợ Chồng'),
('005', 1, N'Vợ Chồng');
GO

SELECT *
FROM PHONGBAN, NHANVIEN
GO