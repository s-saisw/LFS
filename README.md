# LFS
codes for cleaning Labor Force Survey

## WORKFLOW
- Rename .sav files and convert to .csv (Original file names contain space) **LFS_cleanscript.R**
- Rename columns to make it consistent within a year (Column names are mostly consistent within a year) **colname.R**
- Merge quarterly data to year data **colname.R**
- Filter individuals under 15 out (To reduce RAM's load) **filterage.R**
- Delete variables that NSO mistakenly supplied (To reduce RAM's load) **selectvar.R**
- Make column names consistent across years **LFS_outputdta.R**
- Select only necessary variables (To reduce the workload of stata) **LFS_outputdta.R**
- Recode industry variable according to the concordance table (see below) **LFS_outputdta.R**
- Merge year data from 2001-2018 and output as .dta **LFS_outputdta.R**

## INDUSTRY CONCORDANCE
| LFS        | industry code system         | Notes  |
| ------------- |:-------------:| -----|
| 2001-2010      | ISIC Rev.3.0 |  |
| 2011     | *ambiguous*      |   First 4 digits of TSIC 2009 |
| 2012-2018 | TSIC 2009      |    |

### Details on construction of the industry concordance
- I matched the original codes to a foreign set of industry codes (See below)
- Some correspondences are deleted to avoid one to many matches

| Foreign code      | Description  |       
| -----------|-------------|
|1	|เกษตรกรรม การป่าไม้ การประมง การล่าสัตว์|
|2	|การทำเหมืองแร่และเหมืองหิน|
|3	|การผลิต|
|4	|การไฟฟ้า ก๊าซ ไอน้ำ การประปา ระบบปรับอากาศ การจัดหาน้ำ การจัดการ การบำบัดน้ำเสียและสิงปฏิกูล|
|5	|การก่อสร้าง |
|6	|การขายส่ง การขายปลีก การซ่อมแซมยานยนต์ จักรยานยนต์ ของใช้ส่วนบุคคล และของใช้ในครัวเรือน|
|7	|การขนส่งและสถานที่เก็บสินค้า|
|8	|ที่พักแรมและบริการด้านอาหาร|
|9	|ข้อมูลข่าวสารและการสื่อสาร ศิลปะ ความบันเทิง และนันทนาการ การท่องเที่ยว|
|10	|กิจกรรมทางการเงินและประกันภัย การดูแลทรัพย์สินทางปัญญา|
|11	|กิจกรรมด้านอสังหาริมรัพย์ การให้เช่า|
|12	|กิจกรรมทางวิชาชีพ วิทยาศาสตร์ และเทคนิค|
|13	|การบริหารราชการและการป้องกันประเทศ|
|14	|การศึกษา|
|15	|กิจการด้านสุขภาพและงานสังคมสงเคราะห์|
|16	|กิจกรรมการจ้างงานในครัวเรือนส่วนบุคคล กิจกรรมการผลิตสินค้าและบริการที่ทำขึ้นเองเพื่อใช้ในครัวเรือน|
|17	|กิจกรรมขององค์การระหว่างประเทศ|
|18	|กิจกรรมการบริหารและการบริการสนับสนุน บริการด้านอื่นๆ|

For details see **LFS_concordance.xlsx**\
Source:\
[Description](http://statstd.nso.go.th/classification/search.aspx?class=1&act=change) of every industry code\
[Original concordance table](http://statstd.nso.go.th/classification/correspondencedetail.aspx?id=10) between ISIC Rev.3.0 and TSIC 2009

## FILES
- LFS_cleanscript.R : add year and quarter column, remove space in .sav file names
- colname.R : rename columns of quarterly data and merge by year *Codes here can be improved with for loops and automated*
- filterage.R : remove individuals under 15 since they are not asked about occupation
- selectvar.R : delete variables after 'quarter' or 'MONTH' (in thecase of year 2003)
- LFS_outputdta.R : *Codes here can be automated*

## ISSUES
- No month data for LFS 2003q1 but this is negligible (for now) since there is no policy change during 2003q1
