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
'通讯异常表';

comment on column dm_sffund.sys_timeout.fund_trade_no is
'货基平台流水号';

comment on column dm_sffund.sys_timeout.request_info is
'报文内容';

comment on column dm_sffund.sys_timeout.error_info is
'异常描述内容';

comment on column dm_sffund.sys_timeout.create_time is
'创建时间';

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
'基金交易所工作日表   --- by 何杰(840165)';

comment on column dm_sffund.base_market_day.natural_date is
'自然日(yyyymmdd) ';

comment on column dm_sffund.base_market_day.transaction_flag is
'是否是基金交易日 Y:是 N:否';

comment on column dm_sffund.base_market_day.create_time is
'创建时间';

comment on column dm_sffund.base_market_day.update_time is
'更新时间';

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
'基金公司表   --- by 何杰(840165)';

comment on column dm_sffund.base_comp.fund_comp_code is
'基金公司代码: 鹏华基金公司：FUND_PH; 大华基金公司：FUND_DH';

comment on column dm_sffund.base_comp.fund_comp_name is
'基金公司相关的配置数据放到zookpeer存放，便地缓存及及时更新。';

comment on column dm_sffund.base_comp.create_time is
'创建时间';

comment on column dm_sffund.base_comp.update_time is
'更新时间';

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
'基金公司产品表 --- by 何杰(840165)';

comment on column dm_sffund.base_fund.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.base_fund.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.base_fund.fund_comp_prod_name is
'基金产品名称';

comment on column dm_sffund.base_fund.on_sale_flag is
'是否上架：Y:是  N:否';

comment on column dm_sffund.base_fund.create_time is
'创建时间';

comment on column dm_sffund.base_fund.update_time is
'更新时间';

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
'货基账户表 --- by 何杰(840165)';

comment on column dm_sffund.fund_account.fund_account_no is
'货基平台账户';

comment on column dm_sffund.fund_account.member_no is
'顺手付会员号';

comment on column dm_sffund.fund_account.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.fund_account.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.fund_account.create_time is
'创建时间';

comment on column dm_sffund.fund_account.update_time is
'更新时间';

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
'货基账号与基金公司账户映射表--- by 何杰(840165)';

comment on column dm_sffund.fund_account_ta.fund_account_no is
'货基平台账户';

comment on column dm_sffund.fund_account_ta.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.fund_account_ta.fund_comp_trd_account is
'基金公司交易账户';

comment on column dm_sffund.fund_account_ta.status is
'使用状态: Y：开户；N：销户';

comment on column dm_sffund.fund_account_ta.member_name is
'姓名';

comment on column dm_sffund.fund_account_ta.mobile is
'手机号码';

comment on column dm_sffund.fund_account_ta.cert_type is
'证件类型：I_CARD:身份证   O_CERT:军官证   PASSPORT:护照   HK_M_PASS: 香港居民来往大陆通行证   MC_PASS:澳门居民来往大陆通行证   TW_PASS:台湾居民来往大陆通行证';

comment on column dm_sffund.fund_account_ta.cert_no is
'证件号码';

comment on column dm_sffund.fund_account_ta.bank_no is
'银行卡号';

comment on column dm_sffund.fund_account_ta.create_time is
'创建时间';

comment on column dm_sffund.fund_account_ta.update_time is
'更新时间';

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
'货币基金交易订单表--- by 何杰(840165)';

comment on column dm_sffund.monetary_fund_trade.fund_trade_no is
'货基平台流水号,规则FTRD+yyyyMMddHHmmssSSS+5位采番';

comment on column dm_sffund.monetary_fund_trade.fund_account_no is
'货基平台账户';

comment on column dm_sffund.monetary_fund_trade.out_system_order_no is
'业务系统订单号';

comment on column dm_sffund.monetary_fund_trade.out_system_business_no is
'业务系统流水号';

comment on column dm_sffund.monetary_fund_trade.out_system_code is
'业务系统编码 : FUND_SELFHELP_SYS:货基自助系统；FUND_PAY_SYS:基金消费系统；FUND_TRANSFER_SYS：基金代购系统；';

comment on column dm_sffund.monetary_fund_trade.trd_amt is
'交易金额  以分为单位';

comment on column dm_sffund.monetary_fund_trade.status is
'订单状态：INIT：初始化；DOING：进行中；APPLY_SUCCESS：实时成功; FAIL:实时失败；ADJUST_SUCCESS:调账成功；';

comment on column dm_sffund.monetary_fund_trade.pay_time is
'支付成功时间：用于计算收益起始日期及对账文件提取记录时间';

comment on column dm_sffund.monetary_fund_trade.pay_time_date is
'支付成功日期';

comment on column dm_sffund.monetary_fund_trade.pay_time_time is
'支付成功日期时间';

comment on column dm_sffund.monetary_fund_trade.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.monetary_fund_trade.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.monetary_fund_trade.fund_trd_type is
'基金交易类型：APPLY：申购；REDEEM_Q：快速赎回 ; REDEEM_C: 普通赎回;';

comment on column dm_sffund.monetary_fund_trade.busi_code is
'业务类型编码：由业务系统传入。转入：BUY;转出：SELL; 消费：PAY;收益：INCOME；转账：TRANSFER';

comment on column dm_sffund.monetary_fund_trade.busi_desc is
'业务描述：由业务系统传入，在账单中显示';

comment on column dm_sffund.monetary_fund_trade.fund_comp_order_no is
'基金公司交易流水号';

comment on column dm_sffund.monetary_fund_trade.fund_comp_trade_date is
'基金公司交易所属日期：基金公司返回';

comment on column dm_sffund.monetary_fund_trade.fund_comp_settle_date is
'基金公司交易结算日期（资金交收日期），格式：yyyyMMdd';

comment on column dm_sffund.monetary_fund_trade.remark is
'备注';

comment on column dm_sffund.monetary_fund_trade.create_time is
'创建时间';

comment on column dm_sffund.monetary_fund_trade.update_time is
'更新时间';

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
'货币基金交易申购扩展表--- by 何杰(840165)';

comment on column dm_sffund.monetary_fund_trade_buy.fund_trade_no is
'货基平台流水号';

comment on column dm_sffund.monetary_fund_trade_buy.pay_order_no is
'支付公司流水号,结算区份鹏华通道用：由业务系统传入';

comment on column dm_sffund.monetary_fund_trade_buy.pay_channel is
'支付通道:结算区分鹏华通道用：由业务系统传入';

comment on column dm_sffund.monetary_fund_trade_buy.create_time is
'创建时间';



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
'垫资请款表   --- by 何杰(840165)';

comment on column dm_sffund.bankroll_req.bank_roll_req_no is
'请款流水号,规则BRRF+yyyyMMddHHmmssSSS+5位采番';

comment on column dm_sffund.bankroll_req.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.bankroll_req.begin_time is
'请款统计开始时间';

comment on column dm_sffund.bankroll_req.end_time is
'请款统计结束时间';

comment on column dm_sffund.bankroll_req.quick_redeem_amount is
'请款统计时间段总金额,单位：分';

comment on column dm_sffund.bankroll_req.quick_redeem_count is
'请款统计时间段快赎笔数';

comment on column dm_sffund.bankroll_req.bank_roll_status is
'请款处理状态 DOING:请款进行中；SUCCESS:请款完成；';

comment on column dm_sffund.bankroll_req.create_time is
'创建时间';

comment on column dm_sffund.bankroll_req.update_time is
'更新时间';


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
'垫资还款表';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_no is
'还款流水号,,规则BRPF+yyyyMMddHHmmssSSS+5位采番';

comment on column dm_sffund.bankroll_pay.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_amount is
'还款金额,单位：分';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_trd_date is
'还款的交易日';

comment on column dm_sffund.bankroll_pay.quick_redeem_count is
'还款的交易日快赎笔数';

comment on column dm_sffund.bankroll_pay.bank_roll_pay_status is
'还款处理状态 DOING:请款进行中；SUCCESS:请款完成；';

comment on column dm_sffund.bankroll_pay.create_time is
'创建时间';

comment on column dm_sffund.bankroll_pay.update_time is
'更新时间';

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
'基金公司产品净值收益数据   --- by 何杰(840165)';

comment on column dm_sffund.fund_netvalue.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.fund_netvalue.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.fund_netvalue.net_value_date is
'净值日期:自然日(yyyymmdd)  按D日给';

comment on column dm_sffund.fund_netvalue.net_value is
'净值';

comment on column dm_sffund.fund_netvalue.income_ratio is
'7日年化收益率';

comment on column dm_sffund.fund_netvalue.income_unit is
'每万份单位收益';

comment on column dm_sffund.fund_netvalue.create_time is
'创建时间';

comment on column dm_sffund.fund_netvalue.update_time is
'更新时间';

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
'货基账户基金收益明细表';

comment on column dm_sffund.fund_profit_detail.fund_account_no is
'货基平台账户';

comment on column dm_sffund.fund_profit_detail.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.fund_profit_detail.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.fund_profit_detail.income_date is
'收益日期:自然日(yyyymmdd)  按D日给';

comment on column dm_sffund.fund_profit_detail.total_lot is
'总份额不包括收益';

comment on column dm_sffund.fund_profit_detail.income is
'收益';

comment on column dm_sffund.fund_profit_detail.cumu_income is
'累计收益';

comment on column dm_sffund.fund_profit_detail.create_time2 is
'创建时间';

comment on column dm_sffund.fund_profit_detail.update_time is
'更新时间';

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
'货基份额表--- by 何杰(840165)';

comment on column dm_sffund.fund_lot.fund_account_no is
'货基平台账户';

comment on column dm_sffund.fund_lot.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.fund_lot.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.fund_lot.fund_lot is
'基金公司D-1日份额';

comment on column dm_sffund.fund_lot.lot_buy is
'读取“清算日期配置”的交易日期，交易时间（支付完成时间） 《 交易日期 日切时间点（15：00） 记当日，
交易时间（支付完成时间） 》 交易日期 日切时间点（15：00） 记D+1日，';

comment on column dm_sffund.fund_lot.lot_buy_next is
'D日15点后申购份额';

comment on column dm_sffund.fund_lot.lot_sell is
'D日15点前赎回份额';

comment on column dm_sffund.fund_lot.lot_sell_next is
'D日15点后赎回份额';

comment on column dm_sffund.fund_lot.frozen_lot is
'冻结份额,长时间封冻资产，在实时交易过程不用。';

comment on column dm_sffund.fund_lot.create_time is
'创建时间';

comment on column dm_sffund.fund_lot.update_time is
'更新时间';
