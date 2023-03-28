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

```shell
$ rails g model Pharmacy name cash_balance:float opening_hours
$ rails g model Mask name
$ rails g model MaskPharmacy price:float mask:references pharmacy:references
$ rails g model User name cash_balance:float
$ rails g model PurchaseHistory pharmacy_name mask_name transaction_amount:float transaction_date user:references mask:references pharmacy:references
```

### A.3. API Document
> Please describe how to use the API in the API documentation. You can edit by any format (e.g., Markdown or OpenAPI) or free tools (e.g., [hackMD](https://hackmd.io/), [postman](https://www.postman.com/), [google docs](https://docs.google.com/document/u/0/), or  [swagger](https://swagger.io/specification/)).

Import [this](#api-document) json file to Postman.

> [API文件](https://docs.google.com/document/d/1UoeYmNR7oLEPHW5q9z3-tlmexoDcSmKhPfbYM6VazG0/edit?usp=sharing)

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
```





## B. Bonus Information

>  If you completed the bonus requirements, please fill in your task below.
### B.1. Test Coverage Report

I wrote down the 20 unit tests for the APIs I built. Please check the test coverage report at [here](#test-coverage-report).

You can run the test script by using the command below:

```ruby
bundle exec rspec spec
```

### B.2. Dockerized
Please check my Dockerfile / docker-compose.yml at [here](#dockerized).

On the local machine, please follow the commands below to build it.

```bash
$ docker build --build-arg ENV=development -p 80:3000 -t my-project:1.0.0 .  
$ docker-compose up -d

# go inside the container, run the migrate data command.
$ docker exec -it my-project bash
$ rake import_data:pharmacies[PATH_TO_FILE]
$ rake import_data:user[PATH_TO_FILE]
```

### B.3. Demo Site Url

The demo site is ready on [heroku](#demo-site-url); you can try any APIs on this demo site.

## C. Other Information

### C.1. ERD

My ERD [erd-link](#erd-link).

### C.2. Technical Document

For frontend programmer reading, please check this [technical document](technical-document) to know how to operate those APIs.

- --
