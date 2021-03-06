/*
 * @OSF_COPYRIGHT@
 * COPYRIGHT NOTICE
 * Copyright (c) 1990, 1991, 1992, 1993, 1994, 1996 Open Software Foundation, Inc.
 * ALL RIGHTS RESERVED (DCE).  See the file named COPYRIGHT.DCE for
 * the full copyright text.
 */
/*
 * HISTORY
 * $Log: sec_pwd_mgmt_strength_chk_prvcy.c,v $
 * Revision 1.1.4.2  1996/02/17  23:11:42  marty
 * 	Update OSF copyright year
 * 	[1996/02/17  22:33:18  marty]
 *
 * Revision 1.1.4.1  1995/12/11  19:53:17  root
 * 	Submit OSF/DCE 1.2.1
 * 	[1995/12/11  19:27:09  root]
 * 
 * Revision 1.1.2.2  1994/10/06  20:36:11  agd
 * 	expand copyright
 * 	[1994/10/06  14:30:06  agd]
 * 
 * Revision 1.1.2.1  1994/08/04  16:15:54  mdf
 * 	Initial checkin
 * 	[1994/08/03  19:20:55  mdf]
 * 
 * $EndLog$
 */
/*
 * Copyright (c) Hewlett-Packard Company 1994
 * Unpublished work. All Rights Reserved.
 *
 * Provide the tests needed to verify that the local sec_pwd_mgmt_strength_chk_prvcy
 * function is functioning correctly.
 *
 * This test case makes the following assumptions :
 *
 *    1) Machine is a DCE client
 *    2) The Password Strength Server is running and exporting the
 *       sec_pwd_mgmt_strength_chk_prvcy operation.
 *    3) The Password Strength Server running is the sample server
 *       (pwd_strengthd) provided with DCE 1.1
 *    4) The tester is dce logged in as 'cell_admin'.
 *    5) The PWD_STRENGTHD_STRING_BINDING TET configuration variable
 *       has been set correctly.
 */

#include <tet_api.h>

#include <macros.h>
#include <string.h>

#include <dce/acct.h>
#include <dce/binding.h>
#include <dce/dce_error.h>
#include <dce/rpc.h>
#include <dce/sec_login.h>
#include <dce/sec_pwd_mgmt.h>

static void sec_pwd_mgmt_startup(void);
static void sec_pwd_mgmt_cleanup(void);
static void tp1(void);
static void tp2(void);
static void tp3(void);

void (*tet_startup)() = sec_pwd_mgmt_startup;
void (*tet_cleanup)() = sec_pwd_mgmt_cleanup;

struct tet_testlist tet_testlist[] = {
    {tp1, 1},
    {tp2, 2},
    {tp3, 3},
    {NULL, 0}
};

/* global variables */
unsigned_char_p_t     user = (unsigned_char_p_t)"dce-rgy";
sec_login_handle_t    login_h;
unsigned char         unexpected[dce_c_error_string_len];
unsigned char         expected[dce_c_error_string_len];
int                   dce_status;
rpc_binding_handle_t  pwd_strength_h;

#define CHECK_STARTUP_RESULT(T, FUNC, RETURNED_ST_P, EXPECTED_ST)               \
    if (STATUS_EQUAL(RETURNED_ST_P, EXPECTED_ST)) {                             \
        if ((T)) mtet_infoline("PASSED %s()\n", FUNC);                          \
    } else {                                                                    \
        int test_no;                                                            \
        dce_error_inq_text(*(RETURNED_ST_P), unexpected, &dce_status);          \
        dce_error_inq_text(EXPECTED_ST, expected, &dce_status);                 \
        mtet_infoline("FAILED %s()\nresult: \t%s\nexpected: \t%s\n\n",          \
                FUNC, unexpected, expected);                                    \
        for (test_no=0; tet_testlist[test_no++].testfunc != NULL;)              \
            tet_delete(test_no,  "startup() has failed");                       \
        return;                                                                 \
    }


#define CHECK_RESULT(T, MSG, RETURNED_ST_P, EXPECTED_ST)                        \
    if (STATUS_EQUAL(RETURNED_ST_P, EXPECTED_ST)) {                             \
        if ((T)) mtet_infoline("PASSED %s\n", MSG);                             \
    } else {                                                                    \
        dce_error_inq_text(*(RETURNED_ST_P), unexpected, &dce_status);          \
        dce_error_inq_text(EXPECTED_ST, expected, &dce_status);                 \
        mtet_infoline("FAILED %s\nresult: \t%s\nexpected: \t%s\n\n",            \
                MSG, unexpected, expected);                                     \
        tet_result(TET_FAIL);                                                   \
        return;                                                                 \
    }


/*
 * This startup attempts to login as dce-rgy because the password
 * strength server requires that all requests come from dce-rgy.
 * It first must change the password of dce-rgy to a plaintext passwd.
 */
static void sec_pwd_mgmt_startup(void)
{
    error_status_t st;
    sec_passwd_rec_t prec;
    boolean32 reset_passwd;
    sec_login_auth_src_t    auth_src;
    sec_rgy_login_name_t    dce_rgy;
    sec_passwd_rec_t        new_key;
    sec_passwd_rec_t        caller_key;
    sec_passwd_version_t    new_key_version;
    char*                   string_binding;

    mtet_infoline("Startup for sec_pwd_mgmt_strength_chk_prvcy() tests\n");
    CLEAR_STATUS(&st);

    /* change the password of dce-rgy */
    (void) strcpy((char *)dce_rgy.pname, "dce-rgy");
    (void) strcpy((char *)dce_rgy.gname, "none");
    (void) strcpy((char *)dce_rgy.oname, "none");
    caller_key.key.key_type = new_key.key.key_type = sec_passwd_plain;
    caller_key.key.tagged_union.plain = new_key.key.tagged_union.plain = (unsigned_char_p_t)"-dce-";
    caller_key.pepper = new_key.pepper = NULL;
    caller_key.version_number = new_key.version_number = sec_passwd_c_version_none;

    sec_rgy_acct_passwd(NULL, &dce_rgy, &caller_key, &new_key,
        sec_passwd_des, &new_key_version, &st);
    CHECK_STARTUP_RESULT(false, "sec_pwd_mgmt_strength_chk_prvcy setup: sec_rgy_acct_passwd ",
        &st, error_status_ok);

    /* set up and validate dce-rgy login context */
    if (sec_login_setup_identity(user, sec_login_no_flags, &login_h, &st)) {
        prec.key.key_type = sec_passwd_plain;
        prec.key.tagged_union.plain = (unsigned_char_p_t)"-dce-";
        prec.pepper = NULL;
        prec.version_number = sec_passwd_c_version_none;

        if (! sec_login_validate_identity(login_h, &prec, &reset_passwd,
            &auth_src, &st)) {
            CHECK_STARTUP_RESULT(false,
                "sec_pwd_mgmt_strength_chk_prvcy setup: sec_login_validate_identity ", &st,
                error_status_ok);
        }
    } else {
        CHECK_STARTUP_RESULT(false,
            "sec_pwd_mgmt_strength_chk_prvcy setup: sec_login_setup_identity ", &st,
            error_status_ok);
    }

    /* set context */
    sec_login_set_context(login_h, &st);
    CHECK_STARTUP_RESULT(false,
        "sec_pwd_mgmt_strength_chk_prvcy setup: sec_login_set_context ", &st, error_status_ok);

    /* 
     * get binding handle to password strength server 
     * this must be a string binding handle defined in tetexec.cfg as 
     * PWD_STRENGTHD_STRING_BINDING
     */
    string_binding = tet_getvar("PWD_STRENGTHD_STRING_BINDING");
    if (string_binding == NULL) {
        int test_no;
        mtet_infoline("FAILED: PWD_STRENGTHD_STRING_BINDING not defined in tetexec.cfg\n");
        for (test_no=0; tet_testlist[test_no++].testfunc != NULL;)
            tet_delete(test_no, "startup() has failed");
        return;
    }
    rpc_binding_from_string_binding((unsigned_char_p_t) string_binding, &pwd_strength_h, &st);
    CHECK_STARTUP_RESULT(false, 
        "sec_pwd_mgmt_strength_chk_prvcy setup: rpc_binding_from_string_binding",
        &st, error_status_ok);

    /* authenticate client */
    rpc_binding_set_auth_info(pwd_strength_h, (unsigned_char_p_t)"pwd_strength",
        rpc_c_protect_level_pkt_privacy, rpc_c_authn_dce_secret, NULL,
        rpc_c_authz_name, &st);
    CHECK_STARTUP_RESULT(false,
        "sec_pwd_mgmt_strength_chk_prvcy setup: rpc_binding_set_auth_info",
        &st, error_status_ok);
}

/*
 * the purpose of the first test is to test some good passwords
 */
static void tp1(void)
{
    sec_attr_t           attrs[2];
    sec_passwd_rec_t     test_pwd;
    error_status_t       st;
    boolean32            valid;
    sec_rgy_name_t       princ = "cell_admin";

    mtet_infoline("sec_pwd_mgmt_strength_chk_prvcy, test purpose 1, good passwords\n");

    test_pwd.key.key_type = sec_passwd_plain;
    test_pwd.pepper = NULL;
    test_pwd.version_number = sec_passwd_c_version_none;

    /* first entry is password min length */
    attrs[0].attr_value.attr_encoding = sec_attr_enc_integer;
    attrs[0].attr_value.tagged_union.signed_int = 2;

    /* second entry is whether password can be alphanumeric or all spaces */
    attrs[1].attr_value.attr_encoding = sec_attr_enc_integer;
    attrs[1].attr_value.tagged_union.signed_int = 0;

    /* try password with length 2 */
    test_pwd.key.tagged_union.plain = (unsigned_char_p_t) "c$";
    valid = sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(false, "sec_pwd_mgmt_strength_chk_prvcy - good password of length 2",
        &st, error_status_ok);
    if (!valid) {
        mtet_infoline("FAILED sec_pwd_mgmt_strength_chk_prvcy - good password of length 2\n");
        tet_result(TET_FAIL);
        return;
    } else {
        mtet_infoline("PASSED sec_pwd_mgmt_strength_chk_prvcy - good password of length 2\n");
    }

    /* try password with all spaces */
    test_pwd.key.tagged_union.plain = (unsigned_char_p_t) "   ";
    valid = sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(false, "sec_pwd_mgmt_strength_chk_prvcy - good password of all spaces",
        &st, error_status_ok);
    if (!valid) {
        mtet_infoline("FAILED sec_pwd_mgmt_strength_chk_prvcy - good password of all spaces\n");
        tet_result(TET_FAIL);
        return;
    } else {
        mtet_infoline("PASSED sec_pwd_mgmt_strength_chk_prvcy - good password of all spaces\n");
    }

    /* try password with all alphanumeric */
    test_pwd.key.tagged_union.plain = (unsigned_char_p_t) "abc123";
    valid = sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(false, "sec_pwd_mgmt_strength_chk_prvcy - good password of alphanumeric",
        &st, error_status_ok);
    if (!valid) {
        mtet_infoline("FAILED sec_pwd_mgmt_strength_chk_prvcy - good password of alphanumeric\n");
        tet_result(TET_FAIL);
        return;
    } else {
        mtet_infoline("PASSED sec_pwd_mgmt_strength_chk_prvcy - good password of alphanumeric\n");
    }

    tet_result(TET_PASS);
}


/* 
 * the purpose of the second test is to test some bad passwords
 */
static void tp2(void)
{
    sec_attr_t           attrs[2];
    sec_passwd_rec_t     test_pwd;
    error_status_t       st;
    boolean32            valid;
    sec_rgy_name_t       princ = "cell_admin";

    mtet_infoline("sec_pwd_mgmt_strength_chk_prvcy, test purpose 2, bad passwords\n");

    test_pwd.key.key_type = sec_passwd_plain;
    test_pwd.pepper = NULL;
    test_pwd.version_number = sec_passwd_c_version_none;

    /* first entry is password min length */
    attrs[0].attr_value.attr_encoding = sec_attr_enc_integer;
    attrs[0].attr_value.tagged_union.signed_int = 8;

    /* second entry says that password can't be alphanumeric or all spaces */
    attrs[1].attr_value.attr_encoding = sec_attr_enc_integer;
    SET(attrs[1].attr_value.tagged_union.signed_int, sec_rgy_plcy_pwd_no_spaces);
    SET(attrs[1].attr_value.tagged_union.signed_int, sec_rgy_plcy_pwd_non_alpha);

    /* try password with length 2 */
    test_pwd.key.tagged_union.plain = (unsigned_char_p_t) "c$";
    valid = sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(false, "sec_pwd_mgmt_strength_chk_prvcy - bad password of length 2",
        &st, error_status_ok);
    if (valid) {
        mtet_infoline("FAILED sec_pwd_mgmt_strength_chk_prvcy - bad password of length 2\n");
        tet_result(TET_FAIL);
        return;
    } else {
        mtet_infoline("PASSED sec_pwd_mgmt_strength_chk_prvcy - bad password of length 2\n");
    }

    /* try password with all spaces */
    test_pwd.key.tagged_union.plain = (unsigned_char_p_t) "          ";
    valid = sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(false, "sec_pwd_mgmt_strength_chk_prvcy - bad password of all spaces",
        &st, error_status_ok);
    if (valid) {
        mtet_infoline("FAILED sec_pwd_mgmt_strength_chk_prvcy - bad password of all spaces\n");
        tet_result(TET_FAIL);
        return;
    } else {
        mtet_infoline("PASSED sec_pwd_mgmt_strength_chk_prvcy - bad password of all spaces\n");
    }

    /* try password with all alphanumeric */
    test_pwd.key.tagged_union.plain = (unsigned_char_p_t) "abcde12345";
    valid = sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(false, "sec_pwd_mgmt_strength_chk_prvcy - bad password of alphanumeric",
        &st, error_status_ok);
    if (valid) {
        mtet_infoline("FAILED sec_pwd_mgmt_strength_chk_prvcy - bad password of alphanumeric\n");
        tet_result(TET_FAIL);
        return;
    } else {
        mtet_infoline("PASSED sec_pwd_mgmt_strength_chk_prvcy - bad password of alphanumeric\n");
    }

    tet_result(TET_PASS);
}

/*
 * the purpose of this test is to call the password strength server with
 * a level of security that is not satisfactory, and make sure it fails.
 */
static void tp3(void)
{
    error_status_t   st;
    sec_passwd_rec_t test_pwd;
    sec_attr_t       attrs[2];
    sec_rgy_name_t   princ = "cell_admin";

    mtet_infoline("sec_pwd_mgmt_strength_chk_prvcy, test purpose 3, bad authentication/authorization\n");

    test_pwd.key.key_type = sec_passwd_plain;
    test_pwd.pepper = NULL;
    test_pwd.version_number = sec_passwd_c_version_none;
    test_pwd.key.tagged_union.plain = (unsigned_char_p_t) "c$";

    /* first entry is password min length */
    attrs[0].attr_value.attr_encoding = sec_attr_enc_integer;
    attrs[0].attr_value.tagged_union.signed_int = 2;

    /* second entry is whether password can be alphanumeric or all spaces */
    attrs[1].attr_value.attr_encoding = sec_attr_enc_integer;
    attrs[1].attr_value.tagged_union.signed_int = 0;

    /* set bogus protection level */
    rpc_binding_set_auth_info(pwd_strength_h, (unsigned_char_p_t)"pwd_strength",
        rpc_c_protect_level_pkt_integ, rpc_c_authn_dce_secret, NULL,
        rpc_c_authz_name, &st);
    CHECK_RESULT(false, "tp3: rpc_binding_set_auth_info",
        &st, error_status_ok);

    (void) sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(true, "sec_pwd_mgmt_strength_chk_prvcy - bad protection level",
        &st, sec_pwd_not_authorized);

    /*
     * set bogus authentication service 
     * XXX - this cannot be tested right now, since there is only one
     * authentication service available (rpc_c_authn_dce_secret) and
     * the server accepts it.
     */

    /* set bogus authorization service */
    rpc_binding_set_auth_info(pwd_strength_h, (unsigned_char_p_t)"pwd_strength",
        rpc_c_protect_level_pkt_privacy, rpc_c_authn_dce_secret, NULL,
        rpc_c_authz_dce, &st);
    CHECK_RESULT(false, "tp3: rpc_binding_set_auth_info",
        &st, error_status_ok);

    (void) sec_pwd_mgmt_strength_chk_prvcy(pwd_strength_h, princ,
        &test_pwd, 2, attrs, &st);
    CHECK_RESULT(true, "sec_pwd_mgmt_strength_chk_prvcy - bad authorization service",
        &st, sec_pwd_not_authorized);

    /* call from bogus client principal */
    /* XXX - to be done, requires logging in as different principal */

    tet_result(TET_PASS);
}

/* Cleanup of data needed for each of the test cases */
static void sec_pwd_mgmt_cleanup(void)
{
    error_status_t st;
    if (login_h != NULL) sec_login_purge_context(&login_h, &st);
}
