/* Generated by IDL compiler version OSF DCE T1.1.0-03 */
#ifdef VMS
#pragma nostandard
#endif
#include <cmr_idl.h>
#include <dce/idlddefs.h>
static idl_ulong_int IDL_offset_vec[] = {
0,
sizeof(CUST_DATA_IDL ),
offsetof(CUST_DATA_IDL , area_code),
offsetof(CUST_DATA_IDL , phone_no),
offsetof(CUST_DATA_IDL , extn),
offsetof(CUST_DATA_IDL , acct_id),
offsetof(CUST_DATA_IDL , cust_last_name),
offsetof(CUST_DATA_IDL , cust_first_name),
offsetof(CUST_DATA_IDL , cust_MI),
offsetof(CUST_DATA_IDL , ship_addr),
offsetof(CUST_DATA_IDL , mail_addr),
offsetof(CUST_DATA_IDL , state),
offsetof(CUST_DATA_IDL , city),
offsetof(CUST_DATA_IDL , zip_code),
offsetof(CUST_DATA_IDL , cust_type),
offsetof(CUST_DATA_IDL , disc_pcnt),
offsetof(CUST_DATA_IDL , tax_pcnt),
offsetof(CUST_DATA_IDL , drv_lic),
offsetof(CUST_DATA_IDL , drv_lic_state),
offsetof(CUST_DATA_IDL , date_last_purch),
offsetof(CUST_DATA_IDL , cust_ref),
offsetof(CUST_DATA_IDL , cust_filler),
0
};

static void (*IDL_rtn_vec[])() = {
(void (*)())NULL,
(void (*)())NULL
};

static idl_byte IDL_type_vec[] = {
0xff,0xff,0xff,0xff,
1,
0,
0xff,0xff,
0x03,0x00,
0x01,0x00,
0x00,0x00,
0x00,0x00,
0x24,0x2e,0x4a,0x33,
0x00,0x00,
0x00,0x00,
0x0d,
0x00,
0x37,0x98,0x34,0x00,0x00,0x03,
0x00,0x00,0x00,0x00,
0x04,0x00,0x00,0x00,
0xa0,0x03,0x00,0x00,
0xff,0xff,0xff,0xff,
0xff,0xff,0xff,0xff,
0xff,0xff,0xff,0xff,
0xff,0xff,0xff,0xff,
0x03,0x00,0x00,0x00,
0x02,0x00,0x00,0x00,
0x11,0x00,0x00,0x00,
0x03,0x00,0x00,0x00,
0x88,0x00,0x00,0x00,
0x0c,0x00,0x00,0x00,
0xa0,0x00,0x00,0x00,
0x02,0x00,0x00,0x00,
0x02,0x00,0x00,0x00,
0x00,0x00,0x00,0x00,
0xff,0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
0xff,0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
0x0d,0x00,0x00,0x00,
0x0a,0x00,0x00,0x00,
0x08,0x01,0x00,0x00,
0x01,0x00,0x00,0x00,
0x58,0x01,0x00,0x00,
0x02,0x00,0x00,0x00,
IDL_DT_LONG,
IDL_DT_EOL,
0xff,0xff,
0x03,0x00,0x00,0x00,
IDL_DT_LONG,
IDL_DT_EOL,
0xff,0xff,
0x04,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x05,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_LONG,
IDL_DT_EOL,
0xff,
0x06,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_FIXED_STRUCT,
0|IDL_PROP_DEP_CHAR|IDL_PROP_DEP_FLOAT|IDL_PROP_DEP_INT,
0xff,
0x60,0x01,0x00,0x00,
IDL_DT_EOL,
0xff,0xff,0xff,
0x07,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_LONG,
IDL_DT_EOL,
0xff,
0x08,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_ULONG,
IDL_DT_EOL,
0xff,
0x09,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x0a,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x0b,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x0c,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x0d,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x0e,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x0f,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x10,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,
0x02,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x03,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x04,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x05,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x06,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x07,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x08,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x09,0x00,0x00,0x00,
IDL_DT_USHORT,
IDL_DT_EOL,
0xff,0xff,
0x0a,0x00,0x00,0x00,
IDL_DT_LONG,
IDL_DT_EOL,
0xff,0xff,
0x0b,0x00,0x00,0x00,
IDL_DT_ULONG,
IDL_DT_EOL,
0xff,0xff,
0x0c,0x00,0x00,0x00,
IDL_DT_PASSED_BY_REF,
IDL_DT_DOUBLE,
IDL_DT_EOL,
0xff,
0x01,0x00,0x00,0x00,
IDL_DT_NDR_ALIGN_8,
IDL_DT_LONG,
IDL_DT_LONG,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,0xff,
0x83,0x03,0x00,0x00,
0x83,0x03,0x00,0x00,
IDL_DT_LONG,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0x67,0x03,0x00,0x00,
0x67,0x03,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0x4b,0x03,0x00,0x00,
0x4b,0x03,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0x2f,0x03,0x00,0x00,
0x2f,0x03,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0x13,0x03,0x00,0x00,
0x13,0x03,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0xf7,0x02,0x00,0x00,
0xf7,0x02,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0xdb,0x02,0x00,0x00,
0xdb,0x02,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0xbf,0x02,0x00,0x00,
0xbf,0x02,0x00,0x00,
IDL_DT_LONG,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xa3,0x02,0x00,0x00,
0xa3,0x02,0x00,0x00,
IDL_DT_DOUBLE,
IDL_DT_DOUBLE,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,0xff,0xff,
0x87,0x02,0x00,0x00,
0x87,0x02,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0x6b,0x02,0x00,0x00,
0x6b,0x02,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0x4f,0x02,0x00,0x00,
0x4f,0x02,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0x33,0x02,0x00,0x00,
0x33,0x02,0x00,0x00,
IDL_DT_STRING,
IDL_DT_VARYING_ARRAY,
0|IDL_PROP_DEP_CHAR,
0xff,
0x17,0x02,0x00,0x00,
0x17,0x02,0x00,0x00,
IDL_DT_EOL,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x53,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x47,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x0b,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x03,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x17,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x03,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x2f,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x03,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x47,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x47,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x03,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x17,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x2f,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,
1,
0x00,0x00,0x00,0x00,
0x07,0x00,0x00,0x00,
IDL_LIMIT_FIXED,
0xff,0xff,0xff,
0x00,0x00,0x00,0x00,
IDL_LIMIT_STRING,
1,
0xff,0xff,
0xff,0xff,0xff,0xff,
IDL_DT_CHAR,
0xff,0xff,0xff,
0x10,0x00,0x00,0x00,
0
};


static POS_CMR_v0_0_epv_t IDL_manager_epv = {
CMR_STUB
,KILL_CMR
,CNTRL_STUB
};

static void DCEAPI op0_ssr
#ifdef IDL_PROTOTYPES
(
 handle_t hBinding,
 rpc_call_handle_t IDL_call_h,
 rpc_iovector_elt_p_t IDL_elt_p,
 ndr_format_p_t IDL_drep_p,
 rpc_transfer_syntax_p_t IDL_transfer_syntax_p,
 rpc_mgr_epv_t IDL_mgr_epv,
 error_status_t *IDL_status_p
)
#else
(hBinding, IDL_call_h, IDL_elt_p, IDL_drep_p, IDL_transfer_syntax_p, IDL_mgr_epv, IDL_status_p)
 handle_t hBinding;
 rpc_call_handle_t IDL_call_h;
 rpc_iovector_elt_p_t IDL_elt_p;
 ndr_format_p_t IDL_drep_p;
 rpc_transfer_syntax_p_t IDL_transfer_syntax_p;
 rpc_mgr_epv_t IDL_mgr_epv;
 error_status_t *IDL_status_p;
#endif
{
IDL_ms_t IDL_ms;
volatile ndr_boolean IDL_manager_entered = ndr_false;
volatile RPC_SS_THREADS_CANCEL_STATE_T IDL_general_cancel_state;
idl_byte IDL_stack_packet[IDL_STACK_PACKET_SIZE];
rpc_void_p_t IDL_param_vec[17];
idl_long_int in_area_code;
idl_long_int in_phone_no;
idl_ushort_int cmr_len;
idl_long_int appl_time;
CUST_DATA_IDL cmr_buf;
idl_long_int new_think_time;
idl_ulong_int new_auth_lvl;
idl_ushort_int flag_1;
idl_ushort_int flag_2;
idl_ushort_int flag_3;
idl_ushort_int flag_4;
idl_ushort_int flag_5;
idl_ushort_int flag_6;
idl_ushort_int flag_7;
idl_ushort_int flag_8;
RPC_SS_INIT_SERVER
rpc_ss_init_marsh_state(IDL_type_vec, &IDL_ms);
IDL_ms.IDL_stack_packet_status = IDL_stack_packet_unused_k;
IDL_ms.IDL_stack_packet_addr = IDL_stack_packet;
TRY
IDL_ms.IDL_offset_vec = IDL_offset_vec;
IDL_ms.IDL_rtn_vec = IDL_rtn_vec;
IDL_ms.IDL_call_h = (volatile rpc_call_handle_t)IDL_call_h;
IDL_ms.IDL_drep = *IDL_drep_p;
IDL_ms.IDL_elt_p = IDL_elt_p;
IDL_param_vec[1] = (rpc_void_p_t)&hBinding;
IDL_param_vec[2] = (rpc_void_p_t)&in_area_code;
IDL_param_vec[3] = (rpc_void_p_t)&in_phone_no;
IDL_param_vec[4] = (rpc_void_p_t)&cmr_len;
IDL_param_vec[5] = (rpc_void_p_t)&appl_time;
IDL_param_vec[6] = (rpc_void_p_t)&cmr_buf;
IDL_param_vec[7] = (rpc_void_p_t)&new_think_time;
IDL_param_vec[8] = (rpc_void_p_t)&new_auth_lvl;
IDL_param_vec[9] = (rpc_void_p_t)&flag_1;
IDL_param_vec[10] = (rpc_void_p_t)&flag_2;
IDL_param_vec[11] = (rpc_void_p_t)&flag_3;
IDL_param_vec[12] = (rpc_void_p_t)&flag_4;
IDL_param_vec[13] = (rpc_void_p_t)&flag_5;
IDL_param_vec[14] = (rpc_void_p_t)&flag_6;
IDL_param_vec[15] = (rpc_void_p_t)&flag_7;
IDL_param_vec[16] = (rpc_void_p_t)&flag_8;
IDL_ms.IDL_param_vec = IDL_param_vec;
IDL_ms.IDL_side = IDL_server_side_k;
IDL_ms.IDL_language = IDL_lang_c_k;
rpc_ss_ndr_unmar_interp(
    3,
    136,
    IDL_param_vec, &IDL_ms);

/* manager call */
IDL_manager_entered = ndr_true;
RPC_SS_THREADS_ENABLE_GENERAL(IDL_general_cancel_state);
(*((POS_CMR_v0_0_epv_t *)IDL_mgr_epv)->CMR_STUB)(hBinding,
    in_area_code,
    in_phone_no,
    cmr_len,
    &appl_time,
    &cmr_buf,
    &new_think_time,
    &new_auth_lvl,
    &flag_1,
    &flag_2,
    &flag_3,
    &flag_4,
    &flag_5,
    &flag_6,
    &flag_7,
    &flag_8);
RPC_SS_THREADS_RESTORE_GENERAL(IDL_general_cancel_state);
{
rpc_ss_ndr_marsh_interp(
    12,
    160,
    IDL_param_vec, &IDL_ms);
if (IDL_ms.IDL_iovec.num_elt != 0)
  rpc_call_transmit((rpc_call_handle_t)IDL_ms.IDL_call_h,(rpc_iovector_p_t)&IDL_ms.IDL_iovec,
  (unsigned32*)&IDL_ms.IDL_status);  /* Send remaining outs */

}
IDL_closedown: ;
CATCH_ALL
rpc_ss_ndr_clean_up(&IDL_ms);
if (!RPC_SS_EXC_MATCHES(THIS_CATCH,&rpc_x_ss_pipe_comm_error))
{
if ( ! IDL_manager_entered )
{
}
{
rpc_ss_send_server_exception_2(IDL_call_h,THIS_CATCH,0,NULL,&IDL_ms);
IDL_ms.IDL_status = error_status_ok;
}
}
ENDTRY
if (IDL_ms.IDL_mem_handle.memory)
{
 rpc_ss_mem_free(&IDL_ms.IDL_mem_handle);
}
if (IDL_ms.IDL_status != error_status_ok)
{
if (IDL_ms.IDL_status == rpc_s_call_cancelled)
{
rpc_ss_send_server_exception(IDL_call_h,&RPC_SS_THREADS_X_CANCELLED);
IDL_ms.IDL_status = error_status_ok;
}
else
{
{
rpc_ss_send_server_exception(IDL_call_h,&rpc_x_ss_remote_comm_failure);
IDL_ms.IDL_status = error_status_ok;
}
}
}
*IDL_status_p = IDL_ms.IDL_status;
}

static void DCEAPI op1_ssr
#ifdef IDL_PROTOTYPES
(
 handle_t hBinding,
 rpc_call_handle_t IDL_call_h,
 rpc_iovector_elt_p_t IDL_elt_p,
 ndr_format_p_t IDL_drep_p,
 rpc_transfer_syntax_p_t IDL_transfer_syntax_p,
 rpc_mgr_epv_t IDL_mgr_epv,
 error_status_t *IDL_status_p
)
#else
(hBinding, IDL_call_h, IDL_elt_p, IDL_drep_p, IDL_transfer_syntax_p, IDL_mgr_epv, IDL_status_p)
 handle_t hBinding;
 rpc_call_handle_t IDL_call_h;
 rpc_iovector_elt_p_t IDL_elt_p;
 ndr_format_p_t IDL_drep_p;
 rpc_transfer_syntax_p_t IDL_transfer_syntax_p;
 rpc_mgr_epv_t IDL_mgr_epv;
 error_status_t *IDL_status_p;
#endif
{
IDL_ms_t IDL_ms;
volatile ndr_boolean IDL_manager_entered = ndr_false;
volatile RPC_SS_THREADS_CANCEL_STATE_T IDL_general_cancel_state;
idl_byte IDL_stack_packet[IDL_STACK_PACKET_SIZE];
rpc_void_p_t IDL_param_vec[2];
RPC_SS_INIT_SERVER
rpc_ss_init_marsh_state(IDL_type_vec, &IDL_ms);
IDL_ms.IDL_stack_packet_status = IDL_stack_packet_unused_k;
IDL_ms.IDL_stack_packet_addr = IDL_stack_packet;
TRY
IDL_ms.IDL_offset_vec = IDL_offset_vec;
IDL_ms.IDL_rtn_vec = IDL_rtn_vec;
IDL_ms.IDL_call_h = (volatile rpc_call_handle_t)IDL_call_h;
IDL_ms.IDL_drep = *IDL_drep_p;
IDL_ms.IDL_elt_p = IDL_elt_p;
IDL_param_vec[1] = (rpc_void_p_t)&hBinding;
IDL_ms.IDL_param_vec = IDL_param_vec;
IDL_ms.IDL_side = IDL_server_side_k;
IDL_ms.IDL_language = IDL_lang_c_k;
rpc_ss_ndr_unmar_interp(
    0,
    0,
    IDL_param_vec, &IDL_ms);

/* manager call */
IDL_manager_entered = ndr_true;
RPC_SS_THREADS_ENABLE_GENERAL(IDL_general_cancel_state);
(*((POS_CMR_v0_0_epv_t *)IDL_mgr_epv)->KILL_CMR)(hBinding);
RPC_SS_THREADS_RESTORE_GENERAL(IDL_general_cancel_state);
{
rpc_ss_ndr_marsh_interp(
    0,
    0,
    IDL_param_vec, &IDL_ms);
if (IDL_ms.IDL_iovec.num_elt != 0)
  rpc_call_transmit((rpc_call_handle_t)IDL_ms.IDL_call_h,(rpc_iovector_p_t)&IDL_ms.IDL_iovec,
  (unsigned32*)&IDL_ms.IDL_status);  /* Send remaining outs */

}
IDL_closedown: ;
CATCH_ALL
rpc_ss_ndr_clean_up(&IDL_ms);
if (!RPC_SS_EXC_MATCHES(THIS_CATCH,&rpc_x_ss_pipe_comm_error))
{
if ( ! IDL_manager_entered )
{
}
{
rpc_ss_send_server_exception_2(IDL_call_h,THIS_CATCH,0,NULL,&IDL_ms);
IDL_ms.IDL_status = error_status_ok;
}
}
ENDTRY
if (IDL_ms.IDL_mem_handle.memory)
{
 rpc_ss_mem_free(&IDL_ms.IDL_mem_handle);
}
if (IDL_ms.IDL_status != error_status_ok)
{
if (IDL_ms.IDL_status == rpc_s_call_cancelled)
{
rpc_ss_send_server_exception(IDL_call_h,&RPC_SS_THREADS_X_CANCELLED);
IDL_ms.IDL_status = error_status_ok;
}
else
{
{
rpc_ss_send_server_exception(IDL_call_h,&rpc_x_ss_remote_comm_failure);
IDL_ms.IDL_status = error_status_ok;
}
}
}
*IDL_status_p = IDL_ms.IDL_status;
}

static void DCEAPI op2_ssr
#ifdef IDL_PROTOTYPES
(
 handle_t hBinding,
 rpc_call_handle_t IDL_call_h,
 rpc_iovector_elt_p_t IDL_elt_p,
 ndr_format_p_t IDL_drep_p,
 rpc_transfer_syntax_p_t IDL_transfer_syntax_p,
 rpc_mgr_epv_t IDL_mgr_epv,
 error_status_t *IDL_status_p
)
#else
(hBinding, IDL_call_h, IDL_elt_p, IDL_drep_p, IDL_transfer_syntax_p, IDL_mgr_epv, IDL_status_p)
 handle_t hBinding;
 rpc_call_handle_t IDL_call_h;
 rpc_iovector_elt_p_t IDL_elt_p;
 ndr_format_p_t IDL_drep_p;
 rpc_transfer_syntax_p_t IDL_transfer_syntax_p;
 rpc_mgr_epv_t IDL_mgr_epv;
 error_status_t *IDL_status_p;
#endif
{
IDL_ms_t IDL_ms;
volatile ndr_boolean IDL_manager_entered = ndr_false;
volatile RPC_SS_THREADS_CANCEL_STATE_T IDL_general_cancel_state;
idl_byte IDL_stack_packet[IDL_STACK_PACKET_SIZE];
rpc_void_p_t IDL_param_vec[13];
idl_ushort_int flag_1;
idl_ushort_int flag_2;
idl_ushort_int flag_3;
idl_ushort_int flag_4;
idl_ushort_int flag_5;
idl_ushort_int flag_6;
idl_ushort_int flag_7;
idl_ushort_int flag_8;
idl_long_int think_time;
idl_ulong_int auth_lvl;
idl_long_float CSPM;
RPC_SS_INIT_SERVER
rpc_ss_init_marsh_state(IDL_type_vec, &IDL_ms);
IDL_ms.IDL_stack_packet_status = IDL_stack_packet_unused_k;
IDL_ms.IDL_stack_packet_addr = IDL_stack_packet;
TRY
IDL_ms.IDL_offset_vec = IDL_offset_vec;
IDL_ms.IDL_rtn_vec = IDL_rtn_vec;
IDL_ms.IDL_call_h = (volatile rpc_call_handle_t)IDL_call_h;
IDL_ms.IDL_drep = *IDL_drep_p;
IDL_ms.IDL_elt_p = IDL_elt_p;
IDL_param_vec[1] = (rpc_void_p_t)&hBinding;
IDL_param_vec[2] = (rpc_void_p_t)&flag_1;
IDL_param_vec[3] = (rpc_void_p_t)&flag_2;
IDL_param_vec[4] = (rpc_void_p_t)&flag_3;
IDL_param_vec[5] = (rpc_void_p_t)&flag_4;
IDL_param_vec[6] = (rpc_void_p_t)&flag_5;
IDL_param_vec[7] = (rpc_void_p_t)&flag_6;
IDL_param_vec[8] = (rpc_void_p_t)&flag_7;
IDL_param_vec[9] = (rpc_void_p_t)&flag_8;
IDL_param_vec[10] = (rpc_void_p_t)&think_time;
IDL_param_vec[11] = (rpc_void_p_t)&auth_lvl;
IDL_param_vec[12] = (rpc_void_p_t)&CSPM;
IDL_ms.IDL_param_vec = IDL_param_vec;
IDL_ms.IDL_side = IDL_server_side_k;
IDL_ms.IDL_language = IDL_lang_c_k;
rpc_ss_ndr_unmar_interp(
    10,
    264,
    IDL_param_vec, &IDL_ms);

/* manager call */
IDL_manager_entered = ndr_true;
RPC_SS_THREADS_ENABLE_GENERAL(IDL_general_cancel_state);
(*((POS_CMR_v0_0_epv_t *)IDL_mgr_epv)->CNTRL_STUB)(hBinding,
    flag_1,
    flag_2,
    flag_3,
    flag_4,
    flag_5,
    flag_6,
    flag_7,
    flag_8,
    think_time,
    auth_lvl,
    &CSPM);
RPC_SS_THREADS_RESTORE_GENERAL(IDL_general_cancel_state);
{
rpc_ss_ndr_marsh_interp(
    1,
    344,
    IDL_param_vec, &IDL_ms);
if (IDL_ms.IDL_iovec.num_elt != 0)
  rpc_call_transmit((rpc_call_handle_t)IDL_ms.IDL_call_h,(rpc_iovector_p_t)&IDL_ms.IDL_iovec,
  (unsigned32*)&IDL_ms.IDL_status);  /* Send remaining outs */

}
IDL_closedown: ;
CATCH_ALL
rpc_ss_ndr_clean_up(&IDL_ms);
if (!RPC_SS_EXC_MATCHES(THIS_CATCH,&rpc_x_ss_pipe_comm_error))
{
if ( ! IDL_manager_entered )
{
}
{
rpc_ss_send_server_exception_2(IDL_call_h,THIS_CATCH,0,NULL,&IDL_ms);
IDL_ms.IDL_status = error_status_ok;
}
}
ENDTRY
if (IDL_ms.IDL_mem_handle.memory)
{
 rpc_ss_mem_free(&IDL_ms.IDL_mem_handle);
}
if (IDL_ms.IDL_status != error_status_ok)
{
if (IDL_ms.IDL_status == rpc_s_call_cancelled)
{
rpc_ss_send_server_exception(IDL_call_h,&RPC_SS_THREADS_X_CANCELLED);
IDL_ms.IDL_status = error_status_ok;
}
else
{
{
rpc_ss_send_server_exception(IDL_call_h,&rpc_x_ss_remote_comm_failure);
IDL_ms.IDL_status = error_status_ok;
}
}
}
*IDL_status_p = IDL_ms.IDL_status;
}

static rpc_v2_server_stub_proc_t IDL_epva[] = 
{
 (rpc_v2_server_stub_proc_t)op0_ssr,
 (rpc_v2_server_stub_proc_t)op1_ssr,
 (rpc_v2_server_stub_proc_t)op2_ssr
};

static rpc_syntax_id_t IDL_transfer_syntaxes[1] = {
{
{0x8a885d04, 0x1ceb, 0x11c9, 0x9f, 0xe8, {0x8, 0x0, 0x2b, 0x10, 0x48, 0x60}},
2}};

static rpc_if_rep_t IDL_ifspec = {
  1, /* ifspec rep version */
  3, /* op count */
  0, /* if version */
  {0x334a2e24, 0x0000, 0x0000, 0x0d, 0x00, {0x37, 0x98, 0x34, 0x0, 0x0, 0x3}},
  2, /* stub/rt if version */
  {0, NULL}, /* endpoint vector */
  {1, IDL_transfer_syntaxes} /* syntax vector */
,IDL_epva /* server_epv */
,(rpc_mgr_epv_t)&IDL_manager_epv /* manager epv */
};
/* global */ rpc_if_handle_t POS_CMR_v0_0_s_ifspec = (rpc_if_handle_t)&IDL_ifspec;
#ifdef VMS
#pragma standard
#endif