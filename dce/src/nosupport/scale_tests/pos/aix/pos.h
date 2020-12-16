/******************************************
 * Definitions for Price Lookup
 ******************************************/
/*#define DEBUGIT */
#define MAX_ITEMS 100000
#define INX_PG_ROWS 64
#define DAT_PG_ROWS 3
#define LVL_0_PGS 1
#define LVL_1_PGS 9
#define CMR_0_PGS 2
#define CMR_1_PGS 57
#define CMR_INX_PG_ROWS 42
#define CMR_DAT_PG_ROWS 1
#define MAX_AREA_CODE 49
#define MAX_EXCHANGE 39
#define MAX_EXTENSION 49
#ifdef IBMOS2
#define BACK_SLASH "\\"
#else
#define BACK_SLASH "/"
#endif
#define SENDMAX 8192
#define NAMEMAX 14
#define CAT_BUFF 16384
#define MAX_PAGES 999
#define MAX_CATALOGS 5
#define CAT_BUFF 16384
#define CAT_NAME_LEN 40
#define CELL_NAME "/.:/"


/* prototypes */
unsigned long sinker(void);
void hari_kari(void);
void NotFound(long dice);
void prtf(int r,int c,char v[74],int l);


 typedef struct _INX_HEADER
 {
   long   num_rows;                     /* total row count */
   long   levl_0_pages;
   long   levl_1_pages;
   long   levl_2_pages;
   long   data_pages;
   long   max_item_no;
   long   min_item_no;
   char   filler[484];
 } INX_HEADER;

 typedef struct _INX_ROW
 {
   long   item_no;
   long   page_no;
 } INX_ROW;

 typedef struct _INX_PAGE
 {
   INX_ROW      inx_data[64];                         /* 512 byte pages */
 } INX_PAGE;

 typedef struct _ITEM_ROW
 {
   long       item_no       ;
   long       upc_no        ;
   char       descr[36]     ;
   char       dept_no[4]    ;
   long       qty_on_hand   ;
   char       inv_unit[8]   ;
   long       ord_at_qty    ;
   long       qty_to_ord    ;
   long       inv_cnt       ;
   char       inv_date[12]  ;
   long       qty_on_ord    ;
   char       lst_ord_dt[12];
   double     price_1       ;
   char       eff_dt_1[12]  ;
   double     price_2       ;
   char       eff_dt_2[12]  ;
   double     price_3       ;
   char       eff_dt_3[12]  ;
/*   char       taxable_cd[2] ; */
   double     unit_cost     ;
 } ITEM_ROW;

 typedef struct _ITEM_PAGE
 {
   long          itm_page_no;
   char          filler[4];
   ITEM_ROW      data[3];
 } ITEM_PAGE;

 typedef struct _LOCKS
 {
   long         page_no[64];
   short        page_type[64];
   short        lock_cnt[64];
 } LOCKS;

 typedef struct _CUS_INX_HEADER
 {
   long   num_rows;                     /* total row count */
   long   levl_0_pages;
   long   levl_1_pages;
   long   levl_2_pages;
   long   data_pages;
   long   min_area_code;
   long   max_area_code;
   long   min_phone_no;
   long   max_phone_no;
   char   filler[476];
 } CUS_INX_HEADER;

typedef struct _CUS_INX_ROW
{
  long       area_code;
  long       phone_no;
  long       page_no;
} CUS_INX_ROW;

typedef struct _CUS_INX_PAGE
{
  long         cus_inx_page_no;
  long         cus_inx_filler;
  CUS_INX_ROW  cus_inx_data[42];
} CUS_INX_PAGE;

typedef struct _CUST_DATA
{
  long       area_code;
  long       phone_no;
  char       extn[8];
  long       acct_id;
  char       cust_last_name[48];
  char       cust_first_name[24];
  char       cust_MI[4];
  char       ship_addr[72];
  char       mail_addr[72];
  char       state[4];
  char       city[48];
  long       zip_code;
  char       cust_type[4];
  double     disc_pcnt;
  double     tax_pcnt;
  char       drv_lic[24];
  char       drv_lic_state[4];
  char       date_last_purch[12];
  char       cust_ref[72];
  char       cust_filler[84];
} CUST_DATA;      /* 512 bytes */

/***** TRANSACTION STRUCTURES ******/

 typedef struct _TRANS_NO
 {
   char       dept_no[4]    ;
   char       trans_date[9] ;
   char       trans_time[9] ;
   long       reg_no        ;
 } TRANS_NO;

 typedef struct _TRANS_HEADER
 {
   long       acct_id       ;
   long       line_item_cnt ;
   long       item_cnt      ;
   char       trans_type[8] ;
   char       paymt_type[8] ;
   long       employee_no   ;
   char       cust_ref[72]  ;
   char       padding[152]  ;
 } TRANS_HEADER;

 typedef struct _LINE_ITEM
 {
   long       item_no       ;
   long       qty           ;
   double     price_each    ;
   double     price_total   ;
   char       descr[36]     ;
   char       padding[20]   ;
 } LINE_ITEM;

 typedef struct _SAVE_DATA
 {
     TRANS_NO      trans_no;
     TRANS_HEADER  trans_header;
     LINE_ITEM     line_item[4];
 } SAVE_DATA;
