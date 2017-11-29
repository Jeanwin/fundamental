/*==============================================================*/
/* ���������                                           */
/*==============================================================*/
create table dm_sffund.fund_profit 
(
   fund_account_no    number(16)         not null,
   fund_comp_code     varchar2(32)         not null,
   fund_comp_prod_code varchar2(32)         not null,
   total_share        NUMBER(16,2)         not null,
   income             NUMBER(16,2)         not null,
   cumu_income        NUMBER(16,2)         not null,
   create_time        TIMESTAMP            not null,
   update_time        TIMESTAMP,
   constraint PK_FUND_PROFIT primary key (fund_account_no, fund_comp_code, fund_comp_prod_code)
);

comment on table dm_sffund.fund_profit is
'���������,ÿ��һ����������';

comment on column dm_sffund.fund_profit.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.fund_profit.fund_comp_code is
'����˾����';

comment on column dm_sffund.fund_profit.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.fund_profit.total_share is
'�ܷݶ��������';

comment on column dm_sffund.fund_profit.income is
'����';

comment on column dm_sffund.fund_profit.cumu_income is
'�ۼ�����';

comment on column dm_sffund.fund_profit.create_time is
'����ʱ��';

comment on column dm_sffund.fund_profit.update_time is
'����ʱ��';

/*==============================================================*/
/* ���˵���ҵ��������ϸ��                                    */
/*==============================================================*/
create table dm_sffund.CLEAR_BUSI_DETAIL 
(
   out_system_business_no VARCHAR2(32)         not null,
   pay_time           DATE                 not null,
   fund_trade_no      VARCHAR2(32)         not null,
   fund_trd_type      VARCHAR2(16)         not null,
   fund_account_no    number(16),
   fund_comp_code     VARCHAR2(32),
   fund_comp_prod_code VARCHAR2(32),
   amt                NUMBER(16)           not null,
   status             VARCHAR2(20)         not null,
   trade_date         DATE,
   fund_order_no      VARCHAR2(32),
   pay_channel        varchar2(32),
   pay_order_no       varchar2(32),
   busi_code          VARCHAR2(12),
   busi_desc          VARCHAR2(128),
   remark             VARCHAR2(500),
   create_time        TIMESTAMP            not null,
   update_time        TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CLEAR_BUSI_DETAIL is
'���˵���ҵ��������ϸ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.out_system_business_no is
'ҵ��ϵͳ��ˮ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.pay_time is
'֧�����ʱ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_trade_no is
'����ƽ̨��ˮ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_trd_type is
'���������ͣ�APPLY���깺��SOON_REDEEM��������� ; REDEEM: ��ͨ���;';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_comp_code is
'����˾����';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_comp_prod_code is
'�����Ʒ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.amt is
'���';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.status is
'����״̬��INIT����ʼ����DOING�������У�APPLY_SUCCESS��ʵʱ�ɹ�; FAIL:ʵʱʧ�ܣ�SUCCESS:�ɹ���';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.trade_date is
'����˾�����������ڣ�����˾����';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_order_no is
'����˾������ˮ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.pay_channel is
'֧��ͨ��:������������ͨ����';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.pay_order_no is
'֧����˾��ˮ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.busi_code is
'ҵ�����ͱ���';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.busi_desc is
'ҵ��������������ҵ��ϵͳ���룬���˵�����ʾҵ��������������ҵ��ϵͳ���룬���˵�����ʾ';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.remark is
'��ע';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.create_time is
'����ʱ��';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.update_time is
'����ʱ��';


/*==============================================================*/
/* Table: ������˲����                                  */
/*==============================================================*/
create table dm_sffund.CLEAR_ACCOUNT_DIFF 
(
   out_system_business_no VARCHAR2(32),
   pay_time           DATE                 not null,
   fund_trade_no      VARCHAR2(32)         not null,
   fund_trd_type      VARCHAR2(16)         not null,
   clear_date         DATE                 not null,
   fund_account_no    VARCHAR2(32),
   fund_comp_code     VARCHAR2(32),
   busi_code          VARCHAR2(16),
   diff_type          VARCHAR2(20)         not null,
   original_amt       NUMBER(16),
   final_amt          NUMBER(16)           not null,
   business_status    VARCHAR2(16),
   trade_status       VARCHAR2(16),
   final_status       VARCHAR2(20),
   process_status     VARCHAR2(20)         not null,
   is_notify          NUMBER(1),
   remark             VARCHAR2(500),
   create_time        TIMESTAMP            not null,
   update_time        TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CLEAR_ACCOUNT_DIFF is
'������˲����';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.out_system_business_no is
'ҵ��ϵͳ��ˮ��';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.pay_time is
'֧�����ʱ��';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_trade_no is
'����ƽ̨��ˮ��';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_trd_type is
'���������ͣ�APPLY���깺��SOON_REDEEM��������� ;REDEEM:��ͨ���;';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.clear_date is
'��������';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_comp_code is
'����˾����';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.busi_code is
'ҵ��ϵͳ����';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.diff_type is
'��������(STATUS-״̬���죬MORE-�ⲿ�����࣬FEW-�ⲿ�����٣�AMT-������)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.original_amt is
'ԭʼ�������(��)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.final_amt is
'���ն������(��)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.business_status is
'ҵ�񶩵�״̬';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.trade_status is
'���񶩵�״̬(����ƽ̨����״̬)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.final_status is
'���ն���״̬SUCCESS-�ɹ���FAIL-ʧ��)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.process_status is
'����״̬(INIT-��ʼ����PROCESSING-�����У�SUCCESS-�ɹ���FAIL-ʧ��)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.is_notify is
'�Ƿ���Ҫ֪ͨҵ����,0-����Ҫ,1-��Ҫ';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.remark is
'��ע';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.create_time is
'����ʱ��';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.update_time is
'����ʱ��';


/*==============================================================*/
/* D��������ܱ�                                     */
/*==============================================================*/
create table dm_sffund.TRADE_CLEAR_TOTAL 
(
   CLEAR_DATE           DATE                 not null,
   FUND_COMP_CODE       VARCHAR2(32)         not null,
   TOTAL_BUY_NUM        NUMBER(16)           not null,
   TOTAL_SOON_REDEEM_NUM NUMBER(16)           not null,
   TOTAL_REDEEM_NUM     NUMBER(16)           not null,
   TOTAL_BUY_AMT        NUMBER(16)           not null,
   TOTAL_SOON_REDEEM_AMT NUMBER(16)           not null,
   TOTAL_REDEEM_AMT     NUMBER(16)           not null,
   DIFF_AMT             NUMBER(16)           not null,
   CREATE_TIME          TIMESTAMP            not null,
   UPDATE_TIME          TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.TRADE_CLEAR_TOTAL is
'D��������ܱ�';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.CLEAR_DATE is
'��������';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.FUND_COMP_CODE is
'����˾����';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_BUY_NUM is
'�깺�ܶ�����';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_SOON_REDEEM_NUM is
'�����ܶ�����';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_REDEEM_NUM is
'��ͨ��ض�����';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_BUY_AMT is
'�깺�ܶ�(��)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_SOON_REDEEM_AMT is
'�����ܶ�(��)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_REDEEM_AMT is
'��ͨ����ܶ�(��)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.DIFF_AMT is
'���������(��)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.CREATE_TIME is
'����ʱ��';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.UPDATE_TIME is
'����ʱ��';


/*==============================================================*/
/* ����������ϸ��                                    */
/*==============================================================*/
create table dm_sffund.TRADE_CLEAR_DETAIL 
(
   out_system_business_no VARCHAR2(32),
   fund_trade_no      VARCHAR2(32)         not null,
   fund_trd_type      VARCHAR2(20)         not null,
   pay_time           DATE                 not null,
   clear_date         DATE                 not null,
   fund_account_no    number(16),
   busi_code          VARCHAR2(32),
   busi_desc          VARCHAR2(500),
   fund_comp_code     VARCHAR2(32),
   fund_comp_prod_code VARCHAR2(30),
   fund_order_no      VARCHAR2(32)         not null,
   trade_date         DATE,
   amt                NUMBER(16)           not null,
   pay_channel        VARCHAR2(32),
   STATUS               VARCHAR2(20)         not null,
   AUTID_STATUS         VARCHAR2(20),
   DIFF_PROCESS_STATUS  VARCHAR2(20),
   ORIGINAL_ACCOUNT_RESULT VARCHAR2(120),
   REMARK               VARCHAR2(500),
   OPERATOR             VARCHAR2(30),
   AUDITOR              VARCHAR2(30),
   CREATE_TIME          TIMESTAMP            not null,
   UPDATE_TIME          TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.TRADE_CLEAR_DETAIL is
'����������ϸ������ҵ������������˺����ɴ˱�����';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.out_system_business_no is
'ҵ��ϵͳ��ˮ��';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_trade_no is
'����ƽ̨��ˮ��';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_trd_type is
'���������ͣ�APPLY���깺��SOON_REDEEM��������� ; REDEEM: ��ͨ���;';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.pay_time is
'֧�����ʱ��';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.clear_date is
'��������';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_account_no is
'����ƽ̨�˻�(��Ա��)';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.busi_code is
'ҵ�����ͱ��룺��ҵ��ϵͳ����';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.busi_desc is
'ҵ����������';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_comp_code is
'����˾�̻���';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_order_no is
'����˾������ˮ��';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.trade_date is
'����˾������������';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.amt is
'���';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.pay_channel is
'֧��ͨ��:������������ͨ���ã���ҵ��ϵͳ����';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.pay_order_no is
'֧����˾��ˮ��';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.STATUS is
'����״̬(SUCCESS-�ɹ���FAIL-ʧ�ܣ�EXCEPTION-�쳣)(ƽ̨�ֽ���״̬)';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.AUTID_STATUS is
'�����״̬(������Ա�޸Ķ���״̬����Ҫ�������Ա��ˣ������¼�ľ��Ǵ����״̬)';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.DIFF_PROCESS_STATUS is
'�����״̬,INIT-δ����,SUCCESS-����ɹ�';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.ORIGINAL_ACCOUNT_RESULT is
'ԭҵ����˽��';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.REMARK is
'��ע';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.OPERATOR is
'������';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.AUDITOR is
'�����';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.CREATE_TIME is
'����ʱ��';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.UPDATE_TIME is
'����ʱ��';


/*==============================================================*/
/* ����˾ȷ���ļ�������ϸ��                         */
/*==============================================================*/
create table dm_sffund.FUND_CONFIRMDATA_DETAIL 
(
   FUND_TRADE_NO        VARCHAR2(32),
   FUND_ORDER_NO        VARCHAR2(32)          not null,
   APPLY_DATE           VARCHAR2(30),
   CONFIRM_DATE         VARCHAR2(30),
   PAY_TIME             VARCHAR2(30),
   FUND_ACCOUNT_NO      VARCHAR2(32),
   FUND_TRD_TYPE        VARCHAR2(20)         not null,
   PRODUCT_NO           VARCHAR2(20),
   AMT                  NUMBER(16)           not null,
   LOT                  NUMBER(16)           not null,
   RESULT               VARCHAR2(20),
   CHECK_STATUS         VARCHAR2(16)         not null,
   MSG                  VARCHAR2(500),
   CREATE_TIME          TIMESTAMP            not null,
   UPDATE_TIME          TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.FUND_CONFIRMDATA_DETAIL is
'����˾ȷ���ļ�������ϸ���˱�������Դ�ڻ���˾�ṩ��ת�롢ת��ȷ���ļ�';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_TRADE_NO is
'ҵ�񶩵���';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_ORDER_NO is
'����˾������';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.APPLY_DATE is
'�����գ�yyyymmdd���ڼ���˳������һ������';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.CONFIRM_DATE is
'�����գ�yyyymmdd������ݶ�ȷ�����ڣ�ͬʱҲ���ʽ�������';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.PAY_TIME is
'�û�����֧��ʱ�䣬��ʽΪyyyymmddhhmmss';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_ACCOUNT_NO is
'�û��ں�������ר���ڻ����׵��ڲ��˺ţ�����˾���û��Ĳ�����ʹ�ø��˺�';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_TRD_TYPE is
'����ҵ������(01-�깺��02-���꣬04-��ͨ���)';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.PRODUCT_NO is
'ҵ��ϵͳ����';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.AMT is
'��λΪԪ����λС����
����100.01�ݣ�����100.01��
��λΪԪ����λС��';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.LOT is
'��λС����';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.RESULT is
'ȷ�Ͻ��';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.CHECK_STATUS is
'����״̬(INIT-��ʼ��,FINISH-���)';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.MSG is
'������Ϣ';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.CREATE_TIME is
'����ʱ��';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.UPDATE_TIME is
'����ʱ��';


/*==============================================================*/
/* T�ս�����ܱ�                                    */
/*==============================================================*/
create table dm_sffund.TRADE_SETTLE_TOTAL 
(
   SETTLE_DATE          DATE                 not null,
   FUND_COMPY_CODE      VARCHAR2(32)         not null,
   TOTAL_BUY_NUM        NUMBER(16)           not null,
   TOTAL_SOON_REDEEM_NUM NUMBER(16)           not null,
   TOTAL_REDEEM_NUM     NUMBER(16)           not null,
   TOTAL_BUY_AMT        NUMBER(16)           not null,
   TOTAL_SOON_REDEEM_AMT NUMBER(16)           not null,
   TOTAL_REDEEM_AMT     NUMBER(16)           not null,
   DIFF_AMT             NUMBER(16)           not null,
   TRANSFER_STATUS      VARCHAR2(20),
   CREATE_TIME          TIMESTAMP,
   UPDATE_TIME          TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.TRADE_SETTLE_TOTAL is
'T�ս�����ܱ�';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.SETTLE_DATE is
'��������';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.FUND_COMPY_CODE is
'����˾����';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_BUY_NUM is
'�깺�ܶ�����';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_SOON_REDEEM_NUM is
'�����ܶ�����';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_REDEEM_NUM is
'��ͨ��ض�����';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_BUY_AMT is
'�깺�ܶ�(��)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_SOON_REDEEM_AMT is
'�����ܶ�(��)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_REDEEM_AMT is
'��ͨ����ܶ�(��)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.DIFF_AMT is
'��������(��)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TRANSFER_STATUS is
'����״̬((INIT-��ʼ����SUCCESS-�ɹ���FAIL-ʧ�ܣ��ϴ������ļ���֪ͨ����ж��ˣ�����ж�����ɣ�RECHARGED-��ֵ�Ǽǣ�DEBOURS_RETURN-���ʻؿ�������)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.CREATE_TIME is
'����ʱ��';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.UPDATE_TIME is
'����ʱ��';


/*==============================================================*/
/* ����֧��ָ���                                     */
/*==============================================================*/
create table PAYMENT_SETTLE 
(
   SETTLE_DATE          DATE,
   PAY_NO               VARCHAR2(32)         not null,
   PAY_ORDER            VARCHAR2(20)         not null,
   BIND_CARD_NO         VARCHAR2(30),
   PAYER                VARCHAR2(30),
   PAYEE                VARCHAR2(30),
   BEGIN_TIME           TIMESTAMP,
   END_TIME             TIMESTAMP,
   AMT                  NUMBER(16)           not null,
   PAY_STATUS           VARCHAR2(20)         not null,
   CREATE_TIME          TIMESTAMP            not null,
   UPDATE_TIME          TIMESTAMP
);

comment on table PAYMENT_SETTLE is
'����֧��ָ���';

comment on column PAYMENT_SETTLE.SETTLE_DATE is
'��������';

comment on column PAYMENT_SETTLE.PAY_NO is
'֧����ˮ��';

comment on column PAYMENT_SETTLE.PAY_ORDER is
'֧��ָ��(RECHARGE-��ֵ��TRANSFER-ת�ˣ�WITHDRAW-����)';

comment on column PAYMENT_SETTLE.BIND_CARD_NO is
'˳�ָ����а󿨺�(����ʱ��)';

comment on column PAYMENT_SETTLE.PAYER is
'���(���֡�ת����)';

comment on column PAYMENT_SETTLE.PAYEE is
'�տ(��ֵ��ת�����տ)';

comment on column PAYMENT_SETTLE.BEGIN_TIME is
'��ʼʱ��';

comment on column PAYMENT_SETTLE.END_TIME is
'����ʱ��';

comment on column PAYMENT_SETTLE.AMT is
'֧�����(��)';

comment on column PAYMENT_SETTLE.PAY_STATUS is
'֧��״̬(INIT-��ʼ��PAYING-�����У�SUCCESS-������ɣ�FAIL-����ʧ��)';

comment on column PAYMENT_SETTLE.CREATE_TIME is
'����ʱ��';

comment on column PAYMENT_SETTLE.UPDATE_TIME is
'����ʱ��';


/*==============================================================*/
/* ������������                                      */
/*==============================================================*/
create table dm_sffund.SYS_CLEAR_CONFIG 
(
   ID                   NUMBER(16)           not null,
   TRADE_DATE           DATE                 not null,
   CLEAR_DATE           DATE,
   LAST_TRADE_DATE      DATE,
   STATUS               VARCHAR2(500),
   DBSTATUS             TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.SYS_CLEAR_CONFIG is
'������������';

comment on column dm_sffund.SYS_CLEAR_CONFIG.ID is
'����';

comment on column dm_sffund.SYS_CLEAR_CONFIG.TRADE_DATE is
'��������';

comment on column dm_sffund.SYS_CLEAR_CONFIG.CLEAR_DATE is
'��������';

comment on column dm_sffund.SYS_CLEAR_CONFIG.LAST_TRADE_DATE is
'��һ��������';

comment on column dm_sffund.SYS_CLEAR_CONFIG.STATUS is
'''0'' ��������,''1''  ������,''2''�������';

comment on column dm_sffund.SYS_CLEAR_CONFIG.DBSTATUS is
'''0'' ��������,''1'' ���ڱ���,''2'' ���ڻָ�';


/*==============================================================*/
/* �ļ���������Ϣ��                                        */
/*==============================================================*/
create table dm_sffund.SYS_FILESERVER 
(
   SERVERID             VARCHAR2(30)         not null,
   SERVER_TYPE          VARCHAR2(30),
   IP                   VARCHAR2(50)         not null,
   PORT                 NUMBER(6),
   USERNAME             VARCHAR2(30),
   PASSWORD             VARCHAR2(30),
   REMARK               VARCHAR2(30)
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.SYS_FILESERVER is
'�ļ���������Ϣ��';

comment on column dm_sffund.SYS_FILESERVER.SERVERID is
'����ID����ʹ���̻���';

comment on column dm_sffund.SYS_FILESERVER.SERVER_TYPE is
'����������';

comment on column dm_sffund.SYS_FILESERVER.IP is
'�ļ�������IP��ַ';

comment on column dm_sffund.SYS_FILESERVER.PORT is
'�ļ��������˿ں�';

comment on column dm_sffund.SYS_FILESERVER.USERNAME is
'�ļ��������û���';

comment on column dm_sffund.SYS_FILESERVER.PASSWORD is
'�ļ�����������';

comment on column dm_sffund.SYS_FILESERVER.REMARK is
'��ע';

/*==============================================================*/
/* ���տ��Ʊ�                                    */
/*==============================================================*/
create table dm_sffund.CLR_DAYEND_CONTROL 
(
   CLEAR_DATE           DATE,
   STATUS               NUMBER(1),
   CREATE_TIME          DATE,
   END_TIME             DATE,
   REMARK               VARCHAR2(500)
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CLR_DAYEND_CONTROL is
'�������տ��Ʊ���ֹ��ͬһ���������������';

comment on column dm_sffund.CLR_DAYEND_CONTROL.CLEAR_DATE is
'�������ڣ�ȡ�������������ñ�';

comment on column dm_sffund.CLR_DAYEND_CONTROL.STATUS is
'''0'' ����δ���,''1''�������';

comment on column dm_sffund.CLR_DAYEND_CONTROL.CREATE_TIME is
'����ʱ��';

comment on column dm_sffund.CLR_DAYEND_CONTROL.END_TIME is
'���ս���ʱ��';

comment on column dm_sffund.CLR_DAYEND_CONTROL.REMARK is
'��ע';


/*==============================================================*/
/* ��������̶����                                  */
/*==============================================================*/
create table dm_sffund.CS_FLOWCHART_DEFINE 
(
   STEP_NO              NUMBER(2)            not null,
   STEP_NAME            VARCHAR2(50)         not null,
   NEXT_STEP            NUMBER(2),
   TYPE                 NUMBER(1)            not null,
   GROUPID              NUMBER(1),
   FUND_COMP_CODE       VARCHAR2(32)         not null,
   REDO                 NUMBER(1)            not null,
   ALLOWSKIP            NUMBER(1)            not null,
   LOCKFLAG             NUMBER(1)            not null,
   INTERFACE_NAME       VARCHAR2(200)��
   REMARK               VARCHAR2(500),
   CREATE_TIME          TIMESTAMP,
   UPDATE_TIME          TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CS_FLOWCHART_DEFINE is
'��������̶����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.STEP_NO is
'������ţ���1��ʼ��0Ϊ��Ч����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.STEP_NAME is
'��������';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.NEXT_STEP is
'��һ�����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.TYPE is
'0-����,1-����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.GROUPID is
'Ĭ��0';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.FUND_COMP_CODE is
'����˾����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.REDO is
'0-������,1-����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.ALLOWSKIP is
'0-������,1-����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.LOCKFLAG is
'0-δ����,1-����';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.INTERFACE_NAME is
'�ӿ���(��¼ÿ�����̶�Ӧ�Ľӿ�·��)';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.REMARK is
'��ע';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.CREATE_TIME is
'����ʱ��';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.UPDATE_TIME is
'����ʱ��';


/*==============================================================*/
/* ���������״̬��                                       */
/*==============================================================*/
create table dm_sffund.CS_FLOW_STATUS 
(
   STEP_NO              NUMBER(2)            not null,
   STEP_NAME            VARCHAR2(50)         not null,
   NEXTSTEP             NUMBER(2)            not null,
   FUND_COMP_CODE       VARCHAR2(32)         not null,
   CS_DATE              DATE                 not null,
   TYPE                 NUMBER(1),
   GROUPID              NUMBER(1)            not null,
   REDO                 NUMBER(1),
   ALLOW_SKIP           NUMBER(1),
   IS_LOCK              NUMBER(1),
   INTERFACE_NAME       VARCHAR2(200)��
   STATUS               VARCHAR2(30),
   IS_MONITOR           NUMBER(1),
   BEGINTIME            TIMESTAMP            not null,
   ENDTIME              TIMESTAMP,
   REMARK               VARCHAR2(500),
   CREATETIME           TIMESTAMP,
   UPDATETIME           TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CS_FLOW_STATUS is
'���������б���ÿ���̻�������״̬';

comment on column dm_sffund.CS_FLOW_STATUS.STEP_NO is
'������ţ���1��ʼ��0Ϊ��Ч����';

comment on column dm_sffund.CS_FLOW_STATUS.STEP_NAME is
'��������';

comment on column dm_sffund.CS_FLOW_STATUS.NEXTSTEP is
'��һ����ţ�û����һ��Ϊ��';

comment on column dm_sffund.CS_FLOW_STATUS.FUND_COMP_CODE is
'����˾����';

comment on column dm_sffund.CS_FLOW_STATUS.CS_DATE is
'���������';

comment on column dm_sffund.CS_FLOW_STATUS.TYPE is
'0-����,1-����';

comment on column dm_sffund.CS_FLOW_STATUS.GROUPID is
'Ĭ��0';

comment on column dm_sffund.CS_FLOW_STATUS.REDO is
'�Ƿ��������� 0-������,1-����';

comment on column dm_sffund.CS_FLOW_STATUS.ALLOW_SKIP is
'�Ƿ���������';

comment on column dm_sffund.CS_FLOW_STATUS.IS_LOCK is
'�Ƿ�����v';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.INTERFACE_NAME is
'�ӿ���(��¼ÿ�����̶�Ӧ�Ľӿ�·��)';

comment on column dm_sffund.CS_FLOW_STATUS.STATUS is
'INIT-��ʼ��,SUCCESS-�ɹ�,FAIL-ʧ��';

comment on column dm_sffund.CS_FLOW_STATUS.IS_MONITOR is
'�Ƿ���Ҫ��أ�0-����Ҫ,1-��Ҫ';

comment on column dm_sffund.CS_FLOW_STATUS.BEGINTIME is
'��ʼʱ��';

comment on column dm_sffund.CS_FLOW_STATUS.ENDTIME is
'����ʱ��';

comment on column dm_sffund.CS_FLOW_STATUS.REMARK is
'��ע';

comment on column dm_sffund.CS_FLOW_STATUS.CREATETIME is
'����ʱ��';

comment on column dm_sffund.CS_FLOW_STATUS.UPDATETIME is
'����ʱ��';

/*==============================================================*/
/* ������������                                     */
/*==============================================================*/
create table dm_sffund.CS_TASK_DEFINE 
(
   TASK_ID              NUMBER(2),
   TASK_NAME            VARCHAR2(32),
   STEP_NO              NUMBER(2),
   FUND_COMP_NO         VARCHAR2(32),
   TYPE                 NUMBER(1),
   FILEN_AME            VARCHAR2(60),
   LOCAL_PATH           VARCHAR2(200),
   SFTP_PATH            VARCHAR2(200),
   REMARK               VARCHAR2(500)
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CS_TASK_DEFINE is
'��������̶����';

comment on column dm_sffund.CS_TASK_DEFINE.TASK_ID is
'����ID,��1��ʼ';

comment on column dm_sffund.CS_TASK_DEFINE.TASK_NAME is
'��������';

comment on column dm_sffund.CS_TASK_DEFINE.STEP_NO is
'����㲽����ţ���1��ʼ��0Ϊ��Ч����';

comment on column dm_sffund.CS_TASK_DEFINE.FUND_COMP_NO is
'����˾����';

comment on column dm_sffund.CS_TASK_DEFINE.TYPE is
'0-����,1-����';

comment on column dm_sffund.CS_TASK_DEFINE.FILEN_AME is
'���ɵ��ļ��������������ļ��ֶ�Ϊ��';

comment on column dm_sffund.CS_TASK_DEFINE.LOCAL_PATH is
'�����ļ��ڱ��ش�ŵ�·��';

comment on column dm_sffund.CS_TASK_DEFINE.SFTP_PATH is
'SFTP�ļ�·��';

comment on column dm_sffund.CS_TASK_DEFINE.REMARK is
'��ע';


/*==============================================================*/
/* ���������״̬��                                        */
/*==============================================================*/
create table dm_sffund.CS_TASK_STATUS 
(
   TASKID               NUMBER(2),
   TASKNAME             VARCHAR2(30),
   CS_DATE              DATE,
   STEP_NO              NUMBER(2),
   FUND_COMP_CODE       VARCHAR2(32),
   TYPE                 NUMBER(1),
   FILE_NAME            VARCHAR2(100),
   LOCAL_PATH           VARCHAR2(200),
   SFTP_PATH            VARCHAR2(200),
   STATUS               VARCHAR2(20),
   BEGINTIME            TIMESTAMP,
   ENDTIME              TIMESTAMP,
   REMARK               VARCHAR2(500),
   CREATETIME           TIMESTAMP,
   UPDATETIME           TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CS_TASK_STATUS is
'���������״̬��';

comment on column dm_sffund.CS_TASK_STATUS.TASKID is
'����ID,��1��ʼ';

comment on column dm_sffund.CS_TASK_STATUS.TASKNAME is
'��������';

comment on column dm_sffund.CS_TASK_STATUS.CS_DATE is
'���������';

comment on column dm_sffund.CS_TASK_STATUS.STEP_NO is
'����㲽����ţ���1��ʼ��0Ϊ��Ч����';

comment on column dm_sffund.CS_TASK_STATUS.FUND_COMP_CODE is
'����˾����';

comment on column dm_sffund.CS_TASK_STATUS.TYPE is
'0-����,1-����';

comment on column dm_sffund.CS_TASK_STATUS.FILE_NAME is
'���ɵ��ļ��������������ļ��ֶ�Ϊ��';

comment on column dm_sffund.CS_TASK_STATUS.LOCAL_PATH is
'�����ļ��ڱ��ش�ŵ�·��';

comment on column dm_sffund.CS_TASK_STATUS.SFTP_PATH is
'SFTP�ļ�·��';

comment on column dm_sffund.CS_TASK_STATUS.STATUS is
'INIT-δ����,PROCESSING-������,SUCC-����ɹ�,FAIL-����ʧ��';

comment on column dm_sffund.CS_TASK_STATUS.BEGINTIME is
'��ʼʱ��';

comment on column dm_sffund.CS_TASK_STATUS.ENDTIME is
'����ʱ��';

comment on column dm_sffund.CS_TASK_STATUS.REMARK is
'��ע';

comment on column dm_sffund.CS_TASK_STATUS.CREATETIME is
'����ʱ��';

comment on column dm_sffund.CS_TASK_STATUS.UPDATETIME is
'����ʱ��';
