/* Generated by IDL compiler version OSF DCE T1.1.0-03 */
#ifndef DCEAPI 
# include <dce/dcedef.h> 
#endif 
#ifndef pos_def_v0_0_included
#define pos_def_v0_0_included
#ifndef IDL_DOUBLE_USED
#define IDL_DOUBLE_USED
#endif
#ifndef IDLBASE_H
#include <dce/idlbase.h>
#endif

#ifdef __cplusplus
    extern "C" {
#endif

#ifndef nbase_v0_0_included
#include <dce/nbase.h>
#endif
typedef struct _ITEM_ROW_IDL {
idl_long_int item_no;
idl_long_int upc_no;
idl_char descr[36];
idl_char dept_no[4];
idl_long_int qty_on_hand;
idl_char inv_unit[8];
idl_long_int ord_at_qty;
idl_long_int qty_to_ord;
idl_long_int inv_cnt;
idl_char inv_date[12];
idl_long_int qty_on_ord;
idl_char lst_ord_dt[12];
idl_long_float price_1;
idl_char eff_dt_1[12];
idl_long_float price_2;
idl_char eff_dt_2[12];
idl_long_float price_3;
idl_char eff_dt_3[12];
idl_long_float unit_cost;
} ITEM_ROW_IDL;
typedef struct _CUST_DATA_IDL {
idl_long_int area_code;
idl_long_int phone_no;
idl_char extn[8];
idl_long_int acct_id;
idl_char cust_last_name[48];
idl_char cust_first_name[24];
idl_char cust_MI[4];
idl_char ship_addr[72];
idl_char mail_addr[72];
idl_char state[4];
idl_char city[48];
idl_long_int zip_code;
idl_char cust_type[4];
idl_long_float disc_pcnt;
idl_long_float tax_pcnt;
idl_char drv_lic[24];
idl_char drv_lic_state[4];
idl_char date_last_purch[12];
idl_char cust_ref[72];
idl_char cust_filler[84];
} CUST_DATA_IDL;
typedef struct _TRANS_NO_IDL {
idl_char dept_no[4];
idl_char trans_date[9];
idl_char trans_time[9];
idl_long_int reg_no;
} TRANS_NO_IDL;
typedef struct _TRANS_HEADER_IDL {
idl_long_int acct_id;
idl_long_int line_item_cnt;
idl_long_int item_cnt;
idl_char trans_type[8];
idl_char paymt_type[8];
idl_long_int employee_no;
idl_char cust_ref[72];
idl_char padding[152];
} TRANS_HEADER_IDL;
typedef struct _LINE_ITEM_IDL {
idl_long_int item_no;
idl_long_int qty;
idl_long_float price_each;
idl_long_float price_total;
idl_char descr[36];
idl_char padding[20];
} LINE_ITEM_IDL;
typedef struct _SAVE_DATA_IDL {
TRANS_NO_IDL trans_no;
TRANS_HEADER_IDL trans_header;
LINE_ITEM_IDL line_item[4];
} SAVE_DATA_IDL;

#ifdef __cplusplus
    }
#endif

#endif
