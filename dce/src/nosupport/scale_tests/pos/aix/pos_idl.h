/* Generated by IDL compiler version OSF DCE T1.1.0-03 */
#ifndef PointOfSale_v0_0_included
#define PointOfSale_v0_0_included
#ifndef IDL_DOUBLE_USED
#define IDL_DOUBLE_USED
#endif
#ifndef IDLBASE_H
#include <dce/idlbase.h>
#endif
#include <dce/rpc.h>

#ifdef __cplusplus
    extern "C" {
#endif

#ifndef nbase_v0_0_included
#include <dce/nbase.h>
#endif
#ifndef pos_def_v0_0_included
#include <pos_def.h>
#endif
extern void rpc_PTQ(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_long_int in_key,
    /* [in] */ idl_ushort_int ptq_len,
    /* [out] */ idl_long_int *appl_time,
    /* [out] */ ITEM_ROW_IDL *ptq_buf
#endif
);
extern void rpc_CAT(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int catalog_code,
    /* [in] */ idl_ushort_int sizname,
    /* [in] */ idl_ushort_int maxname,
    /* [in] */ idl_byte filename[],
    /* [in, out] */ idl_ushort_int *cat_len,
    /* [out] */ idl_long_int *appl_time,
    /* [out] */ idl_byte *cat_buf
#endif
);
extern void rpc_CMR(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_long_int in_area_code,
    /* [in] */ idl_long_int in_phone_no,
    /* [in] */ idl_ushort_int cmr_len,
    /* [out] */ idl_long_int *appl_time,
    /* [out] */ CUST_DATA_IDL *cmr_buf,
    /* [out] */ idl_long_int *new_think_time,
    /* [out] */ idl_ulong_int *new_auth_lvl,
    /* [out] */ idl_ushort_int *flag_1,
    /* [out] */ idl_ushort_int *flag_2,
    /* [out] */ idl_ushort_int *flag_3,
    /* [out] */ idl_ushort_int *flag_4,
    /* [out] */ idl_ushort_int *flag_5,
    /* [out] */ idl_ushort_int *flag_6,
    /* [out] */ idl_ushort_int *flag_7,
    /* [out] */ idl_ushort_int *flag_8
#endif
);
extern void rpc_SAV(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int in_len,
    /* [in] */ idl_ushort_int sendmax,
    /* [out] */ idl_long_int *appl_time,
    /* [in] */ SAVE_DATA_IDL *sendbuf,
    /* [out] */ idl_ulong_int *ret_code
#endif
);
extern void file_tran(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int sizname,
    /* [in] */ idl_ushort_int maxname,
    /* [in] */ idl_byte filename[],
    /* [in] */ idl_ushort_int in_len,
    /* [in] */ idl_ushort_int sendmax,
    /* [in] */ idl_byte sendbuf[]
#endif
);
extern void char_op(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int in_len,
    /* [in] */ idl_char *sendbuf,
    /* [in] */ idl_ushort_int out_len,
    /* [out] */ idl_char *recvbuf
#endif
);
extern void suicide(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding
#endif
);
extern void pos_CNTRL(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int flag_1,
    /* [in] */ idl_ushort_int flag_2,
    /* [in] */ idl_ushort_int flag_3,
    /* [in] */ idl_ushort_int flag_4,
    /* [in] */ idl_ushort_int flag_5,
    /* [in] */ idl_ushort_int flag_6,
    /* [in] */ idl_ushort_int flag_7,
    /* [in] */ idl_ushort_int flag_8,
    /* [in] */ idl_long_int think_time,
    /* [in] */ idl_ulong_int auth_lvl,
    /* [out] */ idl_long_float *CSPM
#endif
);
typedef struct PointOfSale_v0_0_epv_t {
void (*rpc_PTQ)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_long_int in_key,
    /* [in] */ idl_ushort_int ptq_len,
    /* [out] */ idl_long_int *appl_time,
    /* [out] */ ITEM_ROW_IDL *ptq_buf
#endif
);
void (*rpc_CAT)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int catalog_code,
    /* [in] */ idl_ushort_int sizname,
    /* [in] */ idl_ushort_int maxname,
    /* [in] */ idl_byte filename[],
    /* [in, out] */ idl_ushort_int *cat_len,
    /* [out] */ idl_long_int *appl_time,
    /* [out] */ idl_byte *cat_buf
#endif
);
void (*rpc_CMR)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_long_int in_area_code,
    /* [in] */ idl_long_int in_phone_no,
    /* [in] */ idl_ushort_int cmr_len,
    /* [out] */ idl_long_int *appl_time,
    /* [out] */ CUST_DATA_IDL *cmr_buf,
    /* [out] */ idl_long_int *new_think_time,
    /* [out] */ idl_ulong_int *new_auth_lvl,
    /* [out] */ idl_ushort_int *flag_1,
    /* [out] */ idl_ushort_int *flag_2,
    /* [out] */ idl_ushort_int *flag_3,
    /* [out] */ idl_ushort_int *flag_4,
    /* [out] */ idl_ushort_int *flag_5,
    /* [out] */ idl_ushort_int *flag_6,
    /* [out] */ idl_ushort_int *flag_7,
    /* [out] */ idl_ushort_int *flag_8
#endif
);
void (*rpc_SAV)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int in_len,
    /* [in] */ idl_ushort_int sendmax,
    /* [out] */ idl_long_int *appl_time,
    /* [in] */ SAVE_DATA_IDL *sendbuf,
    /* [out] */ idl_ulong_int *ret_code
#endif
);
void (*file_tran)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int sizname,
    /* [in] */ idl_ushort_int maxname,
    /* [in] */ idl_byte filename[],
    /* [in] */ idl_ushort_int in_len,
    /* [in] */ idl_ushort_int sendmax,
    /* [in] */ idl_byte sendbuf[]
#endif
);
void (*char_op)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int in_len,
    /* [in] */ idl_char *sendbuf,
    /* [in] */ idl_ushort_int out_len,
    /* [out] */ idl_char *recvbuf
#endif
);
void (*suicide)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding
#endif
);
void (*pos_CNTRL)(
#ifdef IDL_PROTOTYPES
    /* [in] */ handle_t hBinding,
    /* [in] */ idl_ushort_int flag_1,
    /* [in] */ idl_ushort_int flag_2,
    /* [in] */ idl_ushort_int flag_3,
    /* [in] */ idl_ushort_int flag_4,
    /* [in] */ idl_ushort_int flag_5,
    /* [in] */ idl_ushort_int flag_6,
    /* [in] */ idl_ushort_int flag_7,
    /* [in] */ idl_ushort_int flag_8,
    /* [in] */ idl_long_int think_time,
    /* [in] */ idl_ulong_int auth_lvl,
    /* [out] */ idl_long_float *CSPM
#endif
);
} PointOfSale_v0_0_epv_t;
extern rpc_if_handle_t PointOfSale_v0_0_c_ifspec;
extern rpc_if_handle_t PointOfSale_v0_0_s_ifspec;

#ifdef __cplusplus
    }
#endif

#endif
