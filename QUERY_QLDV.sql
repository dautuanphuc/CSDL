use QUAN_LY_DOAN_VIEN
--Cho biết danh sách đoàn viên có mã sinh viên, họ tên, giới tính có địa chỉ ở quảng nam.
SELECT MASV, HOTEN AS N'Họ Tên', GIOITINH AS N'Giới Tính'
FROM DOANVIEN
WHERE DIACHI= N'Quảng Nam';
--Hiển thị thông tin của chi đoàn công nghệ thông tin.
SELECT *
FROM CHIDOAN
WHERE TENCHIDOAN = N'Công Nghệ Thông Tin'
--Hiển thị danh sách đoàn viên lớn hơn 20 tuổi.
SELECT *
FROM DOANVIEN
WHERE YEAR(GETDATE())-YEAR(NGSINH) >20
--Đếm số lượng đoàn viên
SELECT COUNT(*) AS N'Số lượng đoàn viên'
FROM DOANVIEN
--Đếm số lượng đoàn viên nhỏ hơn 20 tuổi.
SELECT COUNT(*) AS N'Số lượng Đoàn Viên Nhỏ Hơn 20 Tuổi'
FROM DOANVIEN
WHERE YEAR(GETDATE())-YEAR(NGSINH) <=20
--Xuất ra đoàn viên có người quản lý.
SELECT DV1.*
FROM DOANVIEN DV1, DOANVIEN DV2
WHERE DV1.DOANVIEN_QL=DV2.MASV
--Xuất ra đoàn viên có tên kết thúc bằng chữ 'H'.
SELECT *
FROM DOANVIEN
WHERE HOTEN LIKE N'%H'
--Xuất ra họ tên đoàn viên đạt loại xuất sắc.
SELECT DV.HOTEN
FROM DOANVIEN DV, SODOAN SD, DANHGIA DG
WHERE DV.MASV = SD.MASV
AND SD.MASODOAN = DG.MASODOAN
AND DG.XEPLOAI= N'Xuất Sắc'
--Xuất ra mã sinh viên, họ tên và tên hoạt động mà đoàn viên đó tham gia.
SELECT DV.MASV, DV.HOTEN, HD.TENHOATDONG
FROM DOANVIEN DV, ĐV_THAMGIA TG, HOATDONG HD
WHERE DV.MASV= TG.MASV
AND TG.MAHOATDONG=HD.MAHOATDONG 
--Xuất ra mã sinh viên, họ tên và số lần tham gia hoạt động mà đoàn viên đó tham gia nhiều hơn 1 hoạt động
SELECT DV.MASV, DV.HOTEN, COUNT(*) AS N'Số lần tham gia hoạt động'
FROM DOANVIEN DV, ĐV_THAMGIA TG
WHERE DV.MASV= TG.MASV
GROUP BY DV.MASV, DV.HOTEN
HAVING COUNT(*)>=2
--Xuất ra họ tên, mã sinh viên, địa chỉ và số lượng số điện thoiaj mà đoàn viên đó có nhiều hơn 1 số điện thoại
SELECT  DV.HOTEN, DV.MASV, DV.DIACHI, COUNT(*) AS N'Số Lượng SDT'
FROM  DOANVIEN DV, SODIENTHOAI SDT
WHERE DV.MASV= SDT.MASV
GROUP BY DV.HOTEN, DV.MASV, DV.DIACHI
HAVING COUNT(*)>1
--Xuất ra đoàn viên có nhiều điện thoại nhất.
SELECT TOP(1) DV.HOTEN, DV.MASV, DV.DIACHI, COUNT(*) AS SOLUONG
FROM  DOANVIEN DV, SODIENTHOAI SDT
WHERE DV.MASV= SDT.MASV
GROUP BY DV.HOTEN, DV.MASV, DV.DIACHI
ORDER BY SOLUONG DESC 
--Xuất ra họ tên, số điện thoại mà đoàn viên đó có.
SELECT  DV.HOTEN, SDT.SODIENTHOAI
FROM  DOANVIEN DV, SODIENTHOAI SDT
WHERE DV.MASV= SDT.MASV
GROUP BY DV.HOTEN, SDT.SODIENTHOAI 
--Cho biết tên chi đoàn và số lường của chi đoàn có nhiều đoàn viên nhất.
SELECT TENCHIDOAN, COUNT(*) AS N'Số Lượng đoàn viên'
FROM CHIDOAN 
GROUP BY TENCHIDOAN
--Xuất ra MSV, họ tên và số lượng lần tham gia hoạt động của đoàn viên đó.
SELECT DV.MASV, DV.HOTEN, COUNT(*) AS N'Số Lần Tham Gia'
FROM DOANVIEN DV, ĐV_THAMGIA TG
WHERE DV.MASV= TG.MASV
GROUP BY DV.MASV, DV.HOTEN
--xuất ra tên hoạt động ở quận 9
SELECT  HD.TENHOATDONG
FROM HOATDONG HD, DIADIEM DD
WHERE HD.MAHOATDONG = DD.MAHOATDONG
AND DD.DIADIEM= N'Quận 9'
--Xuất ra ngay tham gia theo thứ tự giảm dần.
SELECT NGAYTHAMGIA
FROM HOATDONG
ORDER BY NGAYTHAMGIA DESC --DESC SAP XEP GIAM, NGUOC LAI(MAC DINH)
--Sắp xếp số lượng đoàn viên tham gia từng hoạt động giảm dần
SELECT HD.SOLUONG, HD.TENHOATDONG
FROM HOATDONG HD
ORDER BY  HD.SOLUONG DESC
--Xuất ra số lượng, tên hoạt động, mã hoạt động mà có số lượng ĐV tham gia nhiều nhất
SELECT TOP(1) HD.SOLUONG AS N'SỐ LƯỢNG MAX', HD.TENHOATDONG AS N'TÊN HOẠT ĐỘNG'
FROM HOATDONG HD, ĐV_THAMGIA TG
WHERE HD.MAHOATDONG= TG.MAHOATDONG
ORDER BY HD.SOLUONG DESC
--Xuất ra số lượng đoàn viên của mỗi chi đoàn.
SELECT CD.TENCHIDOAN, COUNT(*) AS N'Số Lượng'
FROM CHIDOAN CD, DOANVIEN DV, DOANCOSO DCS
WHERE DCS.MADOANCOSO = CD.MADOANCOSO
AND CD.MACHIDOAN = DV.MACHIDOAN
GROUP BY CD.TENCHIDOAN
--Xuất ra tên đoàn viên không có số điện thoại
SELECT *
FROM DOANVIEN DV
WHERE DV.MASV NOT IN ( 
    SELECT MASV
    FROM SODIENTHOAI 
)
--tim nhũng hoạt động có đoàn viên họ Võ tham gia
SELECT TENHOATDONG
FROM HOATDONG
WHERE MAHOATDONG IN( 
    SELECT TG.MAHOATDONG
    FROM DOANVIEN DV, ĐV_THAMGIA TG 
    WHERE DV.MASV = TG.MASV
    AND DV.HOTEN LIKE '%Võ%'
)
--Cho biết họ tên những đoàn viên nào có nhiều hơn 1 số điện thoại.
SELECT  DV.HOTEN
FROM  DOANVIEN DV
WHERE EXISTS( 
    SELECT SDT.MASV, COUNT(*) AS TONG
    FROM SODIENTHOAI SDT
    WHERE DV.MASV = SDT.MASV
    GROUP BY SDT.MASV
    HAVING COUNT(*)>1
)
--Các hoạt động đã diễn ra cho đến thời điểm hiện tạị.
SELECT HD.*
FROM HOATDONG HD, ĐV_THAMGIA TG
--Where HD.NGAYTHAMGIA = '2020-11-20'
WHERE YEAR(GETDATE())> HD.NGAYTHAMGIA 
--WHERE HD.MAHOATDONG = TG.MAHOATDONG
--Cho biết tên hoạt động có số lượng đoàn viên tham gia lớn hơn số lượng đoàn viên tham gia trung bình của tất cả các hoạt động.
SELECT HD1.TENHOATDONG
FROM HOATDONG HD1
WHERE HD1.SOLUONG > ( 
    SELECT AVG(HD2.SOLUONG)
    FROM HOATDONG HD2
    WHERE HD2.MAHOATDONG = HD2.MAHOATDONG
)
--Cho biết thông tin đoàn viên có tuổi cao nhất.
SELECT *
FROM DOANVIEN DV
WHERE YEAR(GETDATE()) - YEAR(DV.NGSINH) >= ALL( 
    SELECT YEAR(GETDATE()) - YEAR(NGSINH)
    FROM DOANVIEN
)
--Cho biết họ tên và ngày tham gia của đoàn viên tham gia Thủ lĩnh sinh viên.
SELECT DV.HOTEN, HD.NGAYTHAMGIA
FROM  DOANVIEN DV, HOATDONG HD, ĐV_THAMGIA TG
WHERE DV.MASV= TG.MASV 
AND TG.MAHOATDONG = HD.MAHOATDONG
AND HD.TENHOATDONG = N'Thủ lĩnh sinh viên'
--Cách lồng
SELECT DV.MASV,DV.HOTEN 
FROM DOANVIEN DV
WHERE DV.MASV IN (
    SELECT TG.MASV
    FROM ĐV_THAMGIA TG 
    WHERE TG.MAHOATDONG IN( 
        SELECT HD.MAHOATDONG
        FROM HOATDONG HD 
        WHERE HD.TENHOATDONG = N'Thủ lĩnh sinh viên'
    )
)
            --TRUY VAN DUNG CAC PHEP TAP HOP
--Cho biết họ tên đoàn viên tham một trong 2 hoạt đông “HD001”, “HD003”.
SELECT  DV.HOTEN, DV.MASV
FROM DOANVIEN DV, ĐV_THAMGIA TG
WHERE MAHOATDONG = 'HD001' AND TG.MASV = DV.MASV 
UNION( 
   SELECT HOTEN, DOV.MASV
    FROM DOANVIEN DOV, ĐV_THAMGIA TGI
    WHERE MAHOATDONG = 'HD003' AND TGI.MASV = DOV.MASV
)
--Xuat ra HOTEN doan vien VUA tham gia hoat dong "HD001" vua tham gia hoat dong "HD009"
SELECT  DV.HOTEN
FROM DOANVIEN DV, ĐV_THAMGIA TG
WHERE MAHOATDONG = 'HD001' AND TG.MASV = DV.MASV 
INTERSECT ( 
   SELECT HOTEN
    FROM DOANVIEN DOV, ĐV_THAMGIA TGI
    WHERE MAHOATDONG = 'HD009' AND TGI.MASV = DOV.MASV
)
--Xuất ra họ tên sinh viên không tham gia hoạt động nào.
SELECT  DV.HOTEN, DV.DIACHI
FROM DOANVIEN DV, ĐV_THAMGIA TG
EXCEPT ( 
   SELECT HOTEN, DIACHI
    FROM DOANVIEN DOV, ĐV_THAMGIA TGI
    WHERE TGI.MASV = DOV.MASV
)
                --Inner join- right/left join/ outer join.
--Cho biết thông tin đoàn viên có thời gian niên khoá từ 2018-2023.
SELECT SD.*
FROM DOANVIEN DV INNER JOIN SODOAN SD ON DV.MASV = SD.MASV
WHERE SD.NIENKHOA = '2018-2023'
--Xuất ra mã sinh viên, họ tên đoàn viên tham gia hoạt động 'HD006'.
SELECT DV.MASV, DV.HOTEN
FROM ĐV_THAMGIA TG INNER JOIN DOANVIEN DV ON DV.MASV = TG.MASV 
WHERE TG.MAHOATDONG = 'HD006'
--Cho biết hoạt động nào có địa điểm ở quận 1.
SELECT HD.TENHOATDONG
FROM HOATDONG HD INNER JOIN DIADIEM DD ON HD.MAHOATDONG = DD.MAHOATDONG
WHERE DD.DIADIEM LIKE N'%Quận 1'
--Xuất ra họ tên, tên lớp thuộc chi đoàn 'CD1.1'
SELECT DV.HOTEN, SD.TENLOP
FROM DOANVIEN DV LEFT JOIN SODOAN SD ON DV.MASV = SD.MASV
WHERE DV.MACHIDOAN = 'CD1.1'

SELECT DV.HOTEN, SD.TENLOP
FROM DOANVIEN DV RIGHT JOIN SODOAN SD ON DV.MASV = SD.MASV
WHERE DV.MACHIDOAN = 'CD1.1'

--Xuất ra danh sách thông tin đoàn viên tốt nghiệp đúng thời hạn.
SELECT *
FROM DOANVIEN DV 
WHERE DV.MASV IN(
    SELECT SD.MASV
    FROM SODOAN SD
    WHERE SD.NIENKHOA LIKE '%2020'
)
--NHUNG DOAN VIEN KO CO SO DOAN
SELECT DV.MASV, DV.HOTEN
FROM DOANVIEN DV
WHERE DV.MASV NOT IN( 
    SELECT MASV
    FROM SODOAN
)
--Tổng số lượng đoàn viên tham gia hoạt động trong học kì 1.



SELECT *
FROM CHIDOAN
SELECT *
FROM DANHGIA
SELECT *
FROM DIADIEM
SELECT *
FROM DOANCOSO
SELECT *
FROM DOANVIEN
SELECT *
FROM ĐV_THAMGIA
SELECT *
FROM SODIENTHOAI
SELECT *
FROM DIADIEM
SELECT *
FROM SODOAN
SELECT *
FROM HOATDONG

