/*==============================================================*/
/* 基金收益表                                           */
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
'基金收益表,每人一条收益数据';

comment on column dm_sffund.fund_profit.fund_account_no is
'货基平台账户';

comment on column dm_sffund.fund_profit.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.fund_profit.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.fund_profit.total_share is
'总份额不包括收益';

comment on column dm_sffund.fund_profit.income is
'收益';

comment on column dm_sffund.fund_profit.cumu_income is
'累计收益';

comment on column dm_sffund.fund_profit.create_time is
'创建时间';

comment on column dm_sffund.fund_profit.update_time is
'更新时间';

/*==============================================================*/
/* 对账导入业务数据明细表                                    */
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
'对账导入业务数据明细表';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.out_system_business_no is
'业务系统流水号';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.pay_time is
'支付完成时间';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_trade_no is
'货基平台流水号';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_trd_type is
'基金交易类型：APPLY：申购；SOON_REDEEM：快速赎回 ; REDEEM: 普通赎回;';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_account_no is
'货基平台账户';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_comp_prod_code is
'基金产品号';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.amt is
'金额';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.status is
'订单状态：INIT：初始化；DOING：进行中；APPLY_SUCCESS：实时成功; FAIL:实时失败；SUCCESS:成功；';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.trade_date is
'基金公司交易所属日期：基金公司返回';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.fund_order_no is
'基金公司交易流水号';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.pay_channel is
'支付通道:结算区分鹏华通道用';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.pay_order_no is
'支付公司流水号';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.busi_code is
'业务类型编码';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.busi_desc is
'业务类型描述：由业务系统传入，在账单中显示业务类型描述：由业务系统传入，在账单中显示';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.remark is
'备注';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.create_time is
'创建时间';

comment on column dm_sffund.CLEAR_BUSI_DETAIL.update_time is
'更新时间';


/*==============================================================*/
/* Table: 清算对账差异表                                  */
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
'清算对账差异表';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.out_system_business_no is
'业务系统流水号';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.pay_time is
'支付完成时间';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_trade_no is
'货基平台流水号';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_trd_type is
'基金交易类型：APPLY：申购；SOON_REDEEM：快速赎回 ;REDEEM:普通赎回;';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.clear_date is
'清算日期';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_account_no is
'货基平台账户';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.fund_comp_code is
'基金公司代码';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.busi_code is
'业务系统编码';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.diff_type is
'差异类型(STATUS-状态差异，MORE-外部订单多，FEW-外部订单少，AMT-金额差异)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.original_amt is
'原始订单金额(分)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.final_amt is
'最终订单金额(分)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.business_status is
'业务订单状态';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.trade_status is
'服务订单状态(货基平台订单状态)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.final_status is
'最终订单状态SUCCESS-成功，FAIL-失败)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.process_status is
'处理状态(INIT-初始化，PROCESSING-处理中，SUCCESS-成功，FAIL-失败)';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.is_notify is
'是否需要通知业务处理,0-不需要,1-需要';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.remark is
'备注';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.create_time is
'创建时间';

comment on column dm_sffund.CLEAR_ACCOUNT_DIFF.update_time is
'更新时间';


/*==============================================================*/
/* D日清算汇总表                                     */
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
'D日清算汇总表';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.CLEAR_DATE is
'清算日期';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.FUND_COMP_CODE is
'基金公司代码';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_BUY_NUM is
'申购总订单数';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_SOON_REDEEM_NUM is
'快赎总订单数';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_REDEEM_NUM is
'普通赎回订单数';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_BUY_AMT is
'申购总额(分)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_SOON_REDEEM_AMT is
'快赎总额(分)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.TOTAL_REDEEM_AMT is
'普通赎回总额(分)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.DIFF_AMT is
'扎差清算额(分)';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.CREATE_TIME is
'创建时间';

comment on column dm_sffund.TRADE_CLEAR_TOTAL.UPDATE_TIME is
'更新时间';


/*==============================================================*/
/* 交易清算明细表                                    */
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
'交易清算明细表，基金业务与基金服务对账后，生成此表数据';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.out_system_business_no is
'业务系统流水号';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_trade_no is
'货基平台流水号';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_trd_type is
'基金交易类型：APPLY：申购；SOON_REDEEM：快速赎回 ; REDEEM: 普通赎回;';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.pay_time is
'支付完成时间';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.clear_date is
'清算日期';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_account_no is
'货基平台账户(会员号)';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.busi_code is
'业务类型编码：由业务系统传入';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.busi_desc is
'业务类型描述';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_comp_code is
'基金公司商户号';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_comp_prod_code is
'基金产品代码';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.fund_order_no is
'基金公司交易流水号';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.trade_date is
'基金公司交易所属日期';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.amt is
'金额';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.pay_channel is
'支付通道:结算区分鹏华通道用：由业务系统传入';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.pay_order_no is
'支付公司流水号';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.STATUS is
'订单状态(SUCCESS-成功，FAIL-失败，EXCEPTION-异常)(平台现交易状态)';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.AUTID_STATUS is
'待审核状态(操作人员修改订单状态后，需要由审核人员审核，这里记录的就是待审核状态)';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.DIFF_PROCESS_STATUS is
'差错处理状态,INIT-未处理,SUCCESS-处理成功';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.ORIGINAL_ACCOUNT_RESULT is
'原业务对账结果';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.REMARK is
'备注';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.OPERATOR is
'操作人';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.AUDITOR is
'审核人';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.CREATE_TIME is
'创建时间';

comment on column dm_sffund.TRADE_CLEAR_DETAIL.UPDATE_TIME is
'更新时间';


/*==============================================================*/
/* 基金公司确认文件数据明细表                         */
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
'基金公司确认文件数据明细表，此表数据来源于基金公司提供的转入、转出确认文件';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_TRADE_NO is
'业务订单号';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_ORDER_NO is
'基金公司订单号';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.APPLY_DATE is
'工作日，yyyymmdd，节假日顺延至下一工作日';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.CONFIRM_DATE is
'工作日，yyyymmdd，基金份额确认日期，同时也是资金交收日期';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.PAY_TIME is
'用户订单支付时间，格式为yyyymmddhhmmss';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_ACCOUNT_NO is
'用户在合作机构专用于基金交易的内部账号，基金公司对用户的操作都使用该账号';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.FUND_TRD_TYPE is
'交易业务类型(01-申购，02-快赎，04-普通赎回)';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.PRODUCT_NO is
'业务系统编码';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.AMT is
'单位为元。两位小数。
比如100.01份，传递100.01；
单位为元，两位小数';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.LOT is
'两位小数。';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.RESULT is
'确认结果';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.CHECK_STATUS is
'对账状态(INIT-初始化,FINISH-完成)';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.MSG is
'返回信息';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.CREATE_TIME is
'创建时间';

comment on column dm_sffund.FUND_CONFIRMDATA_DETAIL.UPDATE_TIME is
'更新时间';


/*==============================================================*/
/* T日结算汇总表                                    */
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
'T日结算汇总表';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.SETTLE_DATE is
'结算日期';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.FUND_COMPY_CODE is
'基金公司代码';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_BUY_NUM is
'申购总订单数';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_SOON_REDEEM_NUM is
'快赎总订单数';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_REDEEM_NUM is
'普通赎回订单数';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_BUY_AMT is
'申购总额(分)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_SOON_REDEEM_AMT is
'快赎总额(分)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TOTAL_REDEEM_AMT is
'普通赎回总额(分)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.DIFF_AMT is
'轧差结算额(分)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.TRANSFER_STATUS is
'结算状态((INIT-初始化，SUCCESS-成功，FAIL-失败，上传对账文件，通知监管行对账，监管行对账完成，RECHARGED-充值登记，DEBOURS_RETURN-垫资回款，普赎分账)';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.CREATE_TIME is
'创建时间';

comment on column dm_sffund.TRADE_SETTLE_TOTAL.UPDATE_TIME is
'更新时间';


/*==============================================================*/
/* 结算支付指令表                                     */
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
'结算支付指令表';

comment on column PAYMENT_SETTLE.SETTLE_DATE is
'结算日期';

comment on column PAYMENT_SETTLE.PAY_NO is
'支付流水号';

comment on column PAYMENT_SETTLE.PAY_ORDER is
'支付指令(RECHARGE-充值，TRANSFER-转账，WITHDRAW-提现)';

comment on column PAYMENT_SETTLE.BIND_CARD_NO is
'顺手付银行绑卡号(提现时填)';

comment on column PAYMENT_SETTLE.PAYER is
'付款方(提现、转账填付款方)';

comment on column PAYMENT_SETTLE.PAYEE is
'收款方(充值、转账填收款方)';

comment on column PAYMENT_SETTLE.BEGIN_TIME is
'开始时间';

comment on column PAYMENT_SETTLE.END_TIME is
'结束时间';

comment on column PAYMENT_SETTLE.AMT is
'支付金额(分)';

comment on column PAYMENT_SETTLE.PAY_STATUS is
'支付状态(INIT-初始，PAYING-付款中，SUCCESS-付款完成，FAIL-付款失败)';

comment on column PAYMENT_SETTLE.CREATE_TIME is
'创建时间';

comment on column PAYMENT_SETTLE.UPDATE_TIME is
'更新时间';


/*==============================================================*/
/* 清算日期配置                                      */
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
'清算日期配置';

comment on column dm_sffund.SYS_CLEAR_CONFIG.ID is
'主键';

comment on column dm_sffund.SYS_CLEAR_CONFIG.TRADE_DATE is
'交易日期';

comment on column dm_sffund.SYS_CLEAR_CONFIG.CLEAR_DATE is
'清算日期';

comment on column dm_sffund.SYS_CLEAR_CONFIG.LAST_TRADE_DATE is
'上一交易日期';

comment on column dm_sffund.SYS_CLEAR_CONFIG.STATUS is
'''0'' 正常运行,''1''  清算中,''2''清算完成';

comment on column dm_sffund.SYS_CLEAR_CONFIG.DBSTATUS is
'''0'' 正常运行,''1'' 正在备份,''2'' 正在恢复';


/*==============================================================*/
/* 文件服务器信息表                                        */
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
'文件服务器信息表';

comment on column dm_sffund.SYS_FILESERVER.SERVERID is
'服务ID，可使用商户号';

comment on column dm_sffund.SYS_FILESERVER.SERVER_TYPE is
'服务器类型';

comment on column dm_sffund.SYS_FILESERVER.IP is
'文件服务器IP地址';

comment on column dm_sffund.SYS_FILESERVER.PORT is
'文件服务器端口号';

comment on column dm_sffund.SYS_FILESERVER.USERNAME is
'文件服务器用户名';

comment on column dm_sffund.SYS_FILESERVER.PASSWORD is
'文件服务器密码';

comment on column dm_sffund.SYS_FILESERVER.REMARK is
'备注';

/*==============================================================*/
/* 日终控制表                                    */
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
'清算日终控制表，防止对同一清算日做多次日终';

comment on column dm_sffund.CLR_DAYEND_CONTROL.CLEAR_DATE is
'清算日期，取自清算日期配置表';

comment on column dm_sffund.CLR_DAYEND_CONTROL.STATUS is
'''0'' 日终未完成,''1''日终完成';

comment on column dm_sffund.CLR_DAYEND_CONTROL.CREATE_TIME is
'创建时间';

comment on column dm_sffund.CLR_DAYEND_CONTROL.END_TIME is
'日终结束时间';

comment on column dm_sffund.CLR_DAYEND_CONTROL.REMARK is
'备注';


/*==============================================================*/
/* 清结算流程定义表                                  */
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
   INTERFACE_NAME       VARCHAR2(200)，
   REMARK               VARCHAR2(500),
   CREATE_TIME          TIMESTAMP,
   UPDATE_TIME          TIMESTAMP
)
tablespace SFFUND_DAT_TS1;

comment on table dm_sffund.CS_FLOWCHART_DEFINE is
'清结算流程定义表';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.STEP_NO is
'步骤序号，从1开始，0为无效步骤';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.STEP_NAME is
'步骤名称';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.NEXT_STEP is
'下一步骤号';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.TYPE is
'0-清算,1-结算';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.GROUPID is
'默认0';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.FUND_COMP_CODE is
'基金公司代码';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.REDO is
'0-不允许,1-允许';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.ALLOWSKIP is
'0-不允许,1-允许';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.LOCKFLAG is
'0-未锁定,1-锁定';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.INTERFACE_NAME is
'接口名(记录每个流程对应的接口路径)';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.REMARK is
'备注';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.CREATE_TIME is
'创建时间';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.UPDATE_TIME is
'更新时间';


/*==============================================================*/
/* 清结算流程状态表                                       */
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
   INTERFACE_NAME       VARCHAR2(200)，
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
'清结算过程中保存每个商户的清算状态';

comment on column dm_sffund.CS_FLOW_STATUS.STEP_NO is
'步骤序号，从1开始，0为无效步骤';

comment on column dm_sffund.CS_FLOW_STATUS.STEP_NAME is
'步骤名称';

comment on column dm_sffund.CS_FLOW_STATUS.NEXTSTEP is
'下一步骤号，没有下一步为空';

comment on column dm_sffund.CS_FLOW_STATUS.FUND_COMP_CODE is
'基金公司代码';

comment on column dm_sffund.CS_FLOW_STATUS.CS_DATE is
'清结算日期';

comment on column dm_sffund.CS_FLOW_STATUS.TYPE is
'0-清算,1-结算';

comment on column dm_sffund.CS_FLOW_STATUS.GROUPID is
'默认0';

comment on column dm_sffund.CS_FLOW_STATUS.REDO is
'是否允许重做 0-不允许,1-允许';

comment on column dm_sffund.CS_FLOW_STATUS.ALLOW_SKIP is
'是否允许跳过';

comment on column dm_sffund.CS_FLOW_STATUS.IS_LOCK is
'是否锁定v';

comment on column dm_sffund.CS_FLOWCHART_DEFINE.INTERFACE_NAME is
'接口名(记录每个流程对应的接口路径)';

comment on column dm_sffund.CS_FLOW_STATUS.STATUS is
'INIT-初始化,SUCCESS-成功,FAIL-失败';

comment on column dm_sffund.CS_FLOW_STATUS.IS_MONITOR is
'是否需要监控，0-不需要,1-需要';

comment on column dm_sffund.CS_FLOW_STATUS.BEGINTIME is
'开始时间';

comment on column dm_sffund.CS_FLOW_STATUS.ENDTIME is
'结束时间';

comment on column dm_sffund.CS_FLOW_STATUS.REMARK is
'备注';

comment on column dm_sffund.CS_FLOW_STATUS.CREATETIME is
'创建时间';

comment on column dm_sffund.CS_FLOW_STATUS.UPDATETIME is
'更新时间';

/*==============================================================*/
/* 清结算任务定义表                                     */
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
'清结算流程定义表';

comment on column dm_sffund.CS_TASK_DEFINE.TASK_ID is
'任务ID,从1开始';

comment on column dm_sffund.CS_TASK_DEFINE.TASK_NAME is
'任务名称';

comment on column dm_sffund.CS_TASK_DEFINE.STEP_NO is
'清结算步骤序号，从1开始，0为无效步骤';

comment on column dm_sffund.CS_TASK_DEFINE.FUND_COMP_NO is
'基金公司代码';

comment on column dm_sffund.CS_TASK_DEFINE.TYPE is
'0-清算,1-结算';

comment on column dm_sffund.CS_TASK_DEFINE.FILEN_AME is
'生成的文件名，无需生成文件字段为空';

comment on column dm_sffund.CS_TASK_DEFINE.LOCAL_PATH is
'生成文件在本地存放的路径';

comment on column dm_sffund.CS_TASK_DEFINE.SFTP_PATH is
'SFTP文件路径';

comment on column dm_sffund.CS_TASK_DEFINE.REMARK is
'备注';


/*==============================================================*/
/* 清结算任务状态表                                        */
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
'清结算流程状态表';

comment on column dm_sffund.CS_TASK_STATUS.TASKID is
'任务ID,从1开始';

comment on column dm_sffund.CS_TASK_STATUS.TASKNAME is
'任务名称';

comment on column dm_sffund.CS_TASK_STATUS.CS_DATE is
'清结算日期';

comment on column dm_sffund.CS_TASK_STATUS.STEP_NO is
'清结算步骤序号，从1开始，0为无效步骤';

comment on column dm_sffund.CS_TASK_STATUS.FUND_COMP_CODE is
'基金公司代码';

comment on column dm_sffund.CS_TASK_STATUS.TYPE is
'0-清算,1-结算';

comment on column dm_sffund.CS_TASK_STATUS.FILE_NAME is
'生成的文件名，无需生成文件字段为空';

comment on column dm_sffund.CS_TASK_STATUS.LOCAL_PATH is
'生成文件在本地存放的路径';

comment on column dm_sffund.CS_TASK_STATUS.SFTP_PATH is
'SFTP文件路径';

comment on column dm_sffund.CS_TASK_STATUS.STATUS is
'INIT-未处理,PROCESSING-处理中,SUCC-处理成功,FAIL-处理失败';

comment on column dm_sffund.CS_TASK_STATUS.BEGINTIME is
'开始时间';

comment on column dm_sffund.CS_TASK_STATUS.ENDTIME is
'结束时间';

comment on column dm_sffund.CS_TASK_STATUS.REMARK is
'备注';

comment on column dm_sffund.CS_TASK_STATUS.CREATETIME is
'创建时间';

comment on column dm_sffund.CS_TASK_STATUS.UPDATETIME is
'更新时间';
