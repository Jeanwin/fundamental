/*==============================================================*/
/* Table: sys_timeout                                           */
/*==============================================================*/
create table dm_sffund.sys_timeout 
(
   fund_trade_no        varchar2(32)         not null,
   request_info         VARCHAR2(1024)       not null,
   error_info           VARCHAR2(1024)       not null,
   create_time          TIMESTAMP            not null
);

comment on table dm_sffund.sys_timeout is
'ͨѶ�쳣��';

comment on column dm_sffund.sys_timeout.fund_trade_no is
'����ƽ̨��ˮ��';

comment on column dm_sffund.sys_timeout.request_info is
'��������';

comment on column dm_sffund.sys_timeout.error_info is
'�쳣��������';

comment on column dm_sffund.sys_timeout.create_time is
'����ʱ��';

/*==============================================================*/
/* Table: base_market_day                                       */
/*==============================================================*/
create table dm_sffund.base_market_day 
(
   natural_date         CHAR(8)              not null,
   transaction_flag     CHAR(1)              not null,
   create_time          TIMESTAMP            not null,
   update_time          TIMESTAMP,
   constraint PK_BASE_MARKET_DAY primary key (natural_date)
);

comment on table dm_sffund.base_market_day is
'�������������ձ�   --- by �ν�(840165)';

comment on column dm_sffund.base_market_day.natural_date is
'��Ȼ��(yyyymmdd) ';

comment on column dm_sffund.base_market_day.transaction_flag is
'�Ƿ��ǻ������� Y:�� N:��';

comment on column dm_sffund.base_market_day.create_time is
'����ʱ��';

comment on column dm_sffund.base_market_day.update_time is
'����ʱ��';

/*==============================================================*/
/* Table: base_comp                                             */
/*==============================================================*/
create table dm_sffund.base_comp 
(
   fund_comp_code       varchar2(32)         not null,
   fund_comp_name       VARCHAR2(256)        not null,
   create_time          TIMESTAMP            not null,
   update_time          TIMESTAMP,
   constraint PK_BASE_COMP primary key (fund_comp_code)
);

comment on table dm_sffund.base_comp is
'����˾��   --- by �ν�(840165)';

comment on column dm_sffund.base_comp.fund_comp_code is
'����˾����: ��������˾��FUND_PH; �󻪻���˾��FUND_DH';

comment on column dm_sffund.base_comp.fund_comp_name is
'����˾��ص��������ݷŵ�zookpeer��ţ���ػ��漰��ʱ���¡�';

comment on column dm_sffund.base_comp.create_time is
'����ʱ��';

comment on column dm_sffund.base_comp.update_time is
'����ʱ��';

/*==============================================================*/
/* Table: base_fund                                             */
/*==============================================================*/
create table dm_sffund.base_fund 
(
   fund_comp_code       varchar2(32)         not null,
   fund_comp_prod_code  varchar2(32)         not null,
   fund_comp_prod_name  VARCHAR2(256)        not null,
   on_sale_flag         char(1),
   create_time          timestamp,
   update_time          timestamp,
   constraint PK_BASE_FUND primary key (fund_comp_code, fund_comp_prod_code)
);

comment on table dm_sffund.base_fund is
'����˾��Ʒ�� --- by �ν�(840165)';

comment on column dm_sffund.base_fund.fund_comp_code is
'����˾����';

comment on column dm_sffund.base_fund.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.base_fund.fund_comp_prod_name is
'�����Ʒ����';

comment on column dm_sffund.base_fund.on_sale_flag is
'�Ƿ��ϼܣ�Y:��  N:��';

comment on column dm_sffund.base_fund.create_time is
'����ʱ��';

comment on column dm_sffund.base_fund.update_time is
'����ʱ��';

/*==============================================================*/
/* Table: fund_account                                          */
/*==============================================================*/
create table dm_sffund.fund_account 
(
   fund_account_no      number(16)         not null,
   member_no            number(14)           not null,
   fund_comp_code       varchar2(32),
   fund_comp_prod_code  varchar2(32),
   create_time          TIMESTAMP            not null,
   update_time          TIMESTAMP,
   constraint PK_FUND_ACCOUNT primary key (fund_account_no)
);

comment on table dm_sffund.fund_account is
'�����˻��� --- by �ν�(840165)';

comment on column dm_sffund.fund_account.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.fund_account.member_no is
'˳�ָ���Ա��';

comment on column dm_sffund.fund_account.fund_comp_code is
'����˾����';

comment on column dm_sffund.fund_account.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.fund_account.create_time is
'����ʱ��';

comment on column dm_sffund.fund_account.update_time is
'����ʱ��';

/*==============================================================*/
/* Index: INX_fund_account_MEMBERNO                             */
/*==============================================================*/
create unique index dm_sffund.INX_fund_account_MEMBERNO on dm_sffund.fund_account (
   member_no ASC
)
tablespace SFFUND_IDX_TS1;

/*==============================================================*/
/* Table: fund_account_ta                                       */
/*==============================================================*/
create table dm_sffund.fund_account_ta 
(
   fund_account_no      number(16)         not null,
   fund_comp_code       varchar2(32)         not null,
   fund_comp_trd_account varchar2(32),
   status               CHAR(1)              default 'Y',
   member_name          VARCHAR2(100)        not null,
   mobile               varchar2(32)         not null,
   cert_type            varchar2(10)         not null,
   cert_no              varchar2(32)         not null,
   bank_no              varchar2(32),
   create_time          timestamp            not null,
   update_time          timestamp,
   constraint PK_FUND_ACCOUNT_TA primary key (fund_account_no, fund_comp_code)
);

comment on table dm_sffund.fund_account_ta is
'�����˺������˾�˻�ӳ���--- by �ν�(840165)';

comment on column dm_sffund.fund_account_ta.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.fund_account_ta.fund_comp_code is
'����˾����';

comment on column dm_sffund.fund_account_ta.fund_comp_trd_account is
'����˾�����˻�';

comment on column dm_sffund.fund_account_ta.status is
'ʹ��״̬: Y��������N������';

comment on column dm_sffund.fund_account_ta.member_name is
'����';

comment on column dm_sffund.fund_account_ta.mobile is
'�ֻ�����';

comment on column dm_sffund.fund_account_ta.cert_type is
'֤�����ͣ�I_CARD:���֤   O_CERT:����֤   PASSPORT:����   HK_M_PASS: ��۾���������½ͨ��֤   MC_PASS:���ž���������½ͨ��֤   TW_PASS:̨�����������½ͨ��֤';

comment on column dm_sffund.fund_account_ta.cert_no is
'֤������';

comment on column dm_sffund.fund_account_ta.bank_no is
'���п���';

comment on column dm_sffund.fund_account_ta.create_time is
'����ʱ��';

comment on column dm_sffund.fund_account_ta.update_time is
'����ʱ��';

/*==============================================================*/
/* Table: monetary_fund_trade                                 */
/*==============================================================*/
create table dm_sffund.monetary_fund_trade 
(
   fund_trade_no      varchar2(32)         not null,
   fund_account_no    number(16)           not null,
   out_system_order_no varchar2(64),
   out_system_business_no varchar2(64)         not null,
   out_system_code    varchar2(16)         not null,
   trd_amt            number(16)           not null,
   status             varchar2(16)         not null,
   pay_time           date                 not null,
   pay_time_date      varchar2(8)          not null,
   pay_time_time      varchar2(6)          not null,
   fund_comp_code     varchar2(32)         not null,
   fund_comp_prod_code varchar2(32)         not null,
   fund_trd_type      varchar2(16)         not null,
   busi_code          varchar2(12)         not null,
   busi_desc          varchar2(128)        not null,
   fund_comp_order_no varchar2(64),
   fund_comp_trade_date date,
   fund_comp_settle_date date,
   remark             varchar2(512),
   create_time        timestamp            not null,
   update_time        timestamp,
   constraint pk_monetary_fund_trade primary key (fund_trade_no)
)
tablespace sffund_dat_ts1;

comment on table dm_sffund.monetary_fund_trade is
'���һ����׶�����--- by �ν�(840165)';

comment on column dm_sffund.monetary_fund_trade.fund_trade_no is
'����ƽ̨��ˮ��,����FTRD+yyyyMMddHHmmssSSS+5λ�ɷ�';

comment on column dm_sffund.monetary_fund_trade.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.monetary_fund_trade.out_system_order_no is
'ҵ��ϵͳ������';

comment on column dm_sffund.monetary_fund_trade.out_system_business_no is
'ҵ��ϵͳ��ˮ��';

comment on column dm_sffund.monetary_fund_trade.out_system_code is
'ҵ��ϵͳ���� : FUND_SELFHELP_SYS:��������ϵͳ��FUND_PAY_SYS:��������ϵͳ��FUND_TRANSFER_SYS���������ϵͳ��';

comment on column dm_sffund.monetary_fund_trade.trd_amt is
'���׽��  �Է�Ϊ��λ';

comment on column dm_sffund.monetary_fund_trade.status is
'����״̬��INIT����ʼ����DOING�������У�APPLY_SUCCESS��ʵʱ�ɹ�; FAIL:ʵʱʧ�ܣ�ADJUST_SUCCESS:���˳ɹ���';

comment on column dm_sffund.monetary_fund_trade.pay_time is
'֧���ɹ�ʱ�䣺���ڼ���������ʼ���ڼ������ļ���ȡ��¼ʱ��';

comment on column dm_sffund.monetary_fund_trade.pay_time_date is
'֧���ɹ�����';

comment on column dm_sffund.monetary_fund_trade.pay_time_time is
'֧���ɹ�����ʱ��';

comment on column dm_sffund.monetary_fund_trade.fund_comp_code is
'����˾����';

comment on column dm_sffund.monetary_fund_trade.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.monetary_fund_trade.fund_trd_type is
'���������ͣ�APPLY���깺��REDEEM_Q��������� ; REDEEM_C: ��ͨ���;';

comment on column dm_sffund.monetary_fund_trade.busi_code is
'ҵ�����ͱ��룺��ҵ��ϵͳ���롣ת�룺BUY;ת����SELL; ���ѣ�PAY;���棺INCOME��ת�ˣ�TRANSFER';

comment on column dm_sffund.monetary_fund_trade.busi_desc is
'ҵ����������ҵ��ϵͳ���룬���˵�����ʾ';

comment on column dm_sffund.monetary_fund_trade.fund_comp_order_no is
'����˾������ˮ��';

comment on column dm_sffund.monetary_fund_trade.fund_comp_trade_date is
'����˾�����������ڣ�����˾����';

comment on column dm_sffund.monetary_fund_trade.fund_comp_settle_date is
'����˾���׽������ڣ��ʽ������ڣ�����ʽ��yyyyMMdd';

comment on column dm_sffund.monetary_fund_trade.remark is
'��ע';

comment on column dm_sffund.monetary_fund_trade.create_time is
'����ʱ��';

comment on column dm_sffund.monetary_fund_trade.update_time is
'����ʱ��';

/*==============================================================*/
/* Index: idx_uq_fund_trd_out_bus_no                            */
/*==============================================================*/
create unique index dm_sffund.idx_uq_fund_trd_out_bus_no on dm_sffund.monetary_fund_trade (
   out_system_business_no asc
)
tablespace sffund_idx_ts1;




/*==============================================================*/
/* Table: monetary_fund_trade_buy                             */
/*==============================================================*/
create table dm_sffund.monetary_fund_trade_buy 
(
   fund_trade_no      varchar2(32)         not null,
   pay_order_no       varchar2(32),
   pay_channel        varchar2(16),
   create_time        timestamp,
   constraint pk_monetary_fund_trade_buy primary key (fund_trade_no)
)
tablespace sffund_dat_ts1;

comment on table dm_sffund.monetary_fund_trade_buy is
'���һ������깺��չ��--- by �ν�(840165)';

comment on column dm_sffund.monetary_fund_trade_buy.fund_trade_no is
'����ƽ̨��ˮ��';

comment on column dm_sffund.monetary_fund_trade_buy.pay_order_no is
'֧����˾��ˮ��,������������ͨ���ã���ҵ��ϵͳ����';

comment on column dm_sffund.monetary_fund_trade_buy.pay_channel is
'֧��ͨ��:������������ͨ���ã���ҵ��ϵͳ����';

comment on column dm_sffund.monetary_fund_trade_buy.create_time is
'����ʱ��';



/*==============================================================*/
/* Table: bankroll_req                                          */
/*==============================================================*/
create table dm_sffund.bankroll_req 
(
   bank_roll_req_no     varchar2(32)         not null,
   fund_comp_code       varchar2(32)         not null,
   begin_time           DATE                 not null,
   end_time             DATE                 not null,
   quick_redeem_amount  number(16,0)         not null,
   quick_redeem_count   number(10)           not null,
   bank_roll_status     varchar2(10)         not null,
   create_time          timestamp            not null,
   update_time          timestamp,
   constraint PK_BANKROLL_REQ primary key (bank_roll_req_no)
);

comment on table dm_sffund.bankroll_req is
'��������   --- by �ν�(840165)';

comment on column dm_sffund.bankroll_req.bank_roll_req_no is
'�����ˮ��,����BRRF+yyyyMMddHHmmssSSS+5λ�ɷ�';

comment on column dm_sffund.bankroll_req.fund_comp_code is
'����˾����';

comment on column dm_sffund.bankroll_req.begin_time is
'���ͳ�ƿ�ʼʱ��';

comment on column dm_sffund.bankroll_req.end_time is
'���ͳ�ƽ���ʱ��';

comment on column dm_sffund.bankroll_req.quick_redeem_amount is
'���ͳ��ʱ����ܽ��,��λ����';

comment on column dm_sffund.bankroll_req.quick_redeem_count is
'���ͳ��ʱ��ο������';

comment on column dm_sffund.bankroll_req.bank_roll_status is
'����״̬ DOING:�������У�SUCCESS:�����ɣ�';

comment on column dm_sffund.bankroll_req.create_time is
'����ʱ��';

comment on column dm_sffund.bankroll_req.update_time is
'����ʱ��';


/*==============================================================*/
/* Table: bankroll_pay                                          */
/*==============================================================*/
create table dm_sffund.bankroll_pay 
(
   bank_roll_pay_no     varchar2(32)         not null,
   fund_comp_code       varchar2(32)         not null,
   bank_roll_pay_amount number(16,0)         not null,
   bank_roll_pay_trd_date date                 not null,
   quick_redeem_count   number(10)           not null,
   bank_roll_pay_status varchar2(10)         not null,
   create_time          timestamp            not null,
   update_time          timestamp,
   constraint PK_BANKROLL_PAY primary key (bank_roll_pay_no)
);

comment on table dm_sffund.bankroll_pay is
'���ʻ����';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_no is
'������ˮ��,,����BRPF+yyyyMMddHHmmssSSS+5λ�ɷ�';

comment on column dm_sffund.bankroll_pay.fund_comp_code is
'����˾����';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_amount is
'������,��λ����';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_trd_date is
'����Ľ�����';

comment on column dm_sffund.bankroll_pay.quick_redeem_count is
'����Ľ����տ������';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_status is
'�����״̬ DOING:�������У�SUCCESS:�����ɣ�';

comment on column dm_sffund.bankroll_pay.create_time is
'����ʱ��';

comment on column dm_sffund.bankroll_pay.update_time is
'����ʱ��';

/*==============================================================*/
/* Table: fund_netvalue                                         */
/*==============================================================*/
create table dm_sffund.fund_netvalue 
(
   fund_comp_code       varchar2(32)         not null,
   fund_comp_prod_code  varchar2(32)         not null,
   net_value_date       CHAR(8)              not null,
   net_value            number(20, 6)        not null,
   income_ratio         number(20, 6)        not null,
   income_unit          number(20, 6)        not null,
   create_time          TIMESTAMP            not null,
   update_time          TIMESTAMP,
   constraint PK_FUND_NETVALUE primary key (fund_comp_code, fund_comp_prod_code, net_value_date)
);

comment on table dm_sffund.fund_netvalue is
'����˾��Ʒ��ֵ��������   --- by �ν�(840165)';

comment on column dm_sffund.fund_netvalue.fund_comp_code is
'����˾����';

comment on column dm_sffund.fund_netvalue.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.fund_netvalue.net_value_date is
'��ֵ����:��Ȼ��(yyyymmdd)  ��D�ո�';

comment on column dm_sffund.fund_netvalue.net_value is
'��ֵ';

comment on column dm_sffund.fund_netvalue.income_ratio is
'7���껯������';

comment on column dm_sffund.fund_netvalue.income_unit is
'ÿ��ݵ�λ����';

comment on column dm_sffund.fund_netvalue.create_time is
'����ʱ��';

comment on column dm_sffund.fund_netvalue.update_time is
'����ʱ��';

/*==============================================================*/
/* Table: fund_profit_detail                                    */
/*==============================================================*/
create table dm_sffund.fund_profit_detail 
(
   fund_account_no      number(16)         not null,
   fund_comp_code       varchar2(32)         not null,
   fund_comp_prod_code  varchar2(32)         not null,
   income_date          CHAR(8)              not null,
   total_lot            NUMBER(16,2)         not null,
   income               NUMBER(16,2)         not null,
   cumu_income          NUMBER(16,2)         not null,
   create_time2         TIMESTAMP            not null,
   update_time          TIMESTAMP,
   constraint PK_FUND_PROFIT_DETAIL primary key (fund_account_no, fund_comp_code, fund_comp_prod_code, income_date)
);

comment on table dm_sffund.fund_profit_detail is
'�����˻�����������ϸ��';

comment on column dm_sffund.fund_profit_detail.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.fund_profit_detail.fund_comp_code is
'����˾����';

comment on column dm_sffund.fund_profit_detail.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.fund_profit_detail.income_date is
'��������:��Ȼ��(yyyymmdd)  ��D�ո�';

comment on column dm_sffund.fund_profit_detail.total_lot is
'�ܷݶ��������';

comment on column dm_sffund.fund_profit_detail.income is
'����';

comment on column dm_sffund.fund_profit_detail.cumu_income is
'�ۼ�����';

comment on column dm_sffund.fund_profit_detail.create_time2 is
'����ʱ��';

comment on column dm_sffund.fund_profit_detail.update_time is
'����ʱ��';

/*==============================================================*/
/* Table: fund_lot                                              */
/*==============================================================*/
create table dm_sffund.fund_lot 
(
   fund_account_no      number(16)         not null,
   fund_comp_code       varchar2(32)         not null,
   fund_comp_prod_code  varchar2(32)         not null,
   fund_lot             number(16, 2)        not null,
   lot_buy              number(16, 2)        not null,
   lot_buy_next         number(16, 2)        not null,
   lot_sell             number(16, 2)        not null,
   lot_sell_next        number(16, 2)        not null,
   frozen_lot           number(16, 2),
   create_time          TIMESTAMP,
   update_time          TIMESTAMP,
   constraint PK_FUND_LOT primary key (fund_account_no, fund_comp_code, fund_comp_prod_code)
);

comment on table dm_sffund.fund_lot is
'�����ݶ��--- by �ν�(840165)';

comment on column dm_sffund.fund_lot.fund_account_no is
'����ƽ̨�˻�';

comment on column dm_sffund.fund_lot.fund_comp_code is
'����˾����';

comment on column dm_sffund.fund_lot.fund_comp_prod_code is
'�����Ʒ����';

comment on column dm_sffund.fund_lot.fund_lot is
'����˾D-1�շݶ�';

comment on column dm_sffund.fund_lot.lot_buy is
'��ȡ�������������á��Ľ������ڣ�����ʱ�䣨֧�����ʱ�䣩 �� �������� ����ʱ��㣨15��00�� �ǵ��գ�
����ʱ�䣨֧�����ʱ�䣩 �� �������� ����ʱ��㣨15��00�� ��D+1�գ�';

comment on column dm_sffund.fund_lot.lot_buy_next is
'D��15����깺�ݶ�';

comment on column dm_sffund.fund_lot.lot_sell is
'D��15��ǰ��طݶ�';

comment on column dm_sffund.fund_lot.lot_sell_next is
'D��15�����طݶ�';

comment on column dm_sffund.fund_lot.frozen_lot is
'����ݶ�,��ʱ��ⶳ�ʲ�����ʵʱ���׹��̲��á�';

comment on column dm_sffund.fund_lot.create_time is
'����ʱ��';

comment on column dm_sffund.fund_lot.update_time is
'����ʱ��';
