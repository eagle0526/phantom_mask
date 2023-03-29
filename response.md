# Response
> Current content is an example; please edit it to fit your style.
## A. Required Information
### A.1. Completed tasks
- [] List all pharmacies open at a specific time and on a day of the week if requested.
  - Implemented at xxx API.
- [x] List all masks sold by a given pharmacy, sorted by mask name or price.
  - Implemented at xxx API.
- [x] List all pharmacies with more or less than x mask products within a price range.
  - Implemented at xxx API.
- [] The top x users by total transaction amount of masks within a date range.
  - Implemented at xxx API.
- [] The total number of masks and dollar value of transactions within a date range.
  - Implemented at xxx API.
- [x] Search for pharmacies or masks by name, ranked by relevance to the search term.
  - Implemented at xxx API.
- [] Process a user purchases a mask from a pharmacy, and handle all relevant data changes in an atomic transaction.
  - Implemented at xxx API.


### A.2. Database Introduction

(1) 一個藥局有賣很多口罩   
(2) 一個口罩在很多藥局也會在很多藥局被賣   
(3) 因此兩者的關係是多對多，並且因為口罩的價格會變動，所以把價格紀錄在第三張表格   
(4) 一個使用者會有很多購買紀錄    
(5) 購買紀錄要跟使用者、藥局、口罩簽關聯，都是一對多的關係   
(6) 營業時間裡面會存禮拜一~禮拜日的時間 ex. Mon: 12:00 - 14:00, Tue: "未營業" (每一間藥局會有一個固定營業時間，所以是一對一)   

```shell
$ rails g model Pharmacy name cash_balance:float opening_hours
$ rails g model Mask name
$ rails g model MaskPharmacy price:float mask:references pharmacy:references
$ rails g model User name cash_balance:float
$ rails g model PurchaseHistory pharmacy_name mask_name transaction_amount:float transaction_date user:references mask:references pharmacy:references
$ rails g model OpeningTime Mon Tue Wed Thur Fri Sat Sun pharmacy:references  
```

### A.3. API Document

> [API文件](https://hackmd.io/@BNE3ZSQ9QRW2ChNzpkH3mw/SkFKD2xZ2)

使用方式，把此檔案拉下來之後，把json資料匯入資料庫(下面有匯入資料庫的指令)，再來打開rails s，最後開啟 postman，根據上面給的API文件，照著步驟使用路徑，就可以得到相應的數據。


### A.4. Import Data Commands

先創造表單
```bash
$ rails db:migrate
```

把json檔案的數據匯入資料庫裡面
```bash
$ rake create_pharmacies_and_masks 
$ rake create_user_and_purchase_histories  
$ rake create_pharmacies_openings
```




