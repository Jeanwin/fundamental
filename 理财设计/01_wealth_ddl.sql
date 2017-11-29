create table wealth.mmf_order_info
(
	flow_no varchar(32) not null comment '流水号'
		primary key,
	cust_id varchar(20) not null comment '客户ID',
	status varchar(10) not null comment '订单状态：0:初始状态,1:成功,2:失败,3:处理中,4:已关单,5:已强制关单,6:轮询重复发起支付,7:退款已受理,8:退款已成功',
	frozen_amount decimal(15,2) null comment '冻结金额(货基申购)',
	redeem_share decimal(15,2) null comment '赎回份额（货基快赎）',
	product_code varchar(20) null comment '产品编码',
	lock_share decimal(15,2) null comment '锁定份额',
	op_type varchar(1) not null comment '操作编码：1申购，2快赎',
	fail_reason varchar(4000) null comment '失败原因',
	business_code varchar(10) not null comment '发起操作业务编码n	货基申购：1开户、2兑付、3现金券、4转让（出让）、5运营调账n	货基赎回：6购买固收、7购买活期、8转让（受让）',
	tx_flow_no varchar(32) null comment '业务流水',
	member_no varchar(32) null comment '会员号',
	payment_flow_no varchar(32) null comment '支付流水号',
	business_params varchar(4000) null comment '具体业务入参，用户重新发起后续逻辑',
	old_order_no varchar(32) null comment '原流水号，转让时，出让的订单号',
	version int default '0' null comment '版本',
	remarks varchar(255) null comment '备注',
	valid_flag char default '1' null comment '是否有效标志(''1''有效,''0''无效)',
	creator varchar(25) null comment '记录创建者',
	modifier varchar(25) null comment '最后更新者',
	create_time timestamp default CURRENT_TIMESTAMP null comment '最后更新者',
	update_time timestamp default CURRENT_TIMESTAMP null comment '最后更新时间',
	re_fund_order_no varchar(32) null comment '发生退款时，生成退款订单号',
	mmf_status varchar(10) null comment '货基接口返回状态：1:成功,2:失败,3:处理中,4:已关单,5:关单失败',
	in_params varchar(2000) null,
	out_params varchar(2000) null
)
comment '货币基金申购记录表'
;

create index mmf_order_info_cust_id_index
	on mmf_order_info (cust_id)
;

create index mmf_order_info_op_type_status_index
	on mmf_order_info (op_type, status)
;

create index mmf_order_info_business_code_index
	on mmf_order_info (business_code)
;

create table wealth.mmf_order_info_his
(
	flow_no varchar(32) not null comment '流水号'
		primary key,
	cust_id varchar(20) not null comment '客户ID',
	status varchar(10) not null comment '订单状态：0:初始状态,1:成功,2:失败,3:处理中,4:已关单,5:已强制关单,6:轮询重复发起支付,7:退款已受理,8:退款已成功',
	frozen_amount decimal(15,2) null comment '冻结金额(货基申购)',
	redeem_share decimal(15,2) null comment '赎回份额（货基快赎）',
	product_code varchar(20) null comment '产品编码',
	lock_share decimal(15,2) null comment '锁定份额',
	op_type varchar(1) not null comment '操作编码：1申购，2快赎',
	fail_reason varchar(4000) null comment '失败原因',
	business_code varchar(10) not null comment '发起操作业务编码n	货基申购：1开户、2兑付、3现金券、4转让（出让）、5运营调账n	货基赎回：6购买固收、7购买活期、8转让（受让）',
	tx_flow_no varchar(32) null comment '业务流水',
	member_no varchar(32) null comment '会员号',
	payment_flow_no varchar(32) null comment '支付流水号',
	business_params varchar(4000) null comment '具体业务入参，用户重新发起后续逻辑',
	old_order_no varchar(32) null comment '原流水号，转让时，出让的订单号',
	version int default '0' null comment '版本',
	remarks varchar(255) null comment '备注',
	valid_flag char default '1' null comment '是否有效标志(''1''有效,''0''无效)',
	creator varchar(25) null comment '记录创建者',
	modifier varchar(25) null comment '最后更新者',
	create_time timestamp default CURRENT_TIMESTAMP null comment '最后更新者',
	update_time timestamp default CURRENT_TIMESTAMP null comment '最后更新时间',
	mmf_status varchar(10) null comment '货基接口返回状态：1:成功,2:失败,3:处理中,4:已关单,5:关单失败',
	re_fund_order_no varchar(32) null comment '发生退款时，生成退款订单号'
)
comment '货币基金申购记录历史表'
;

create index mmf_order_info_his_business_code_index
	on mmf_order_info_his (business_code)
;

create index mmf_order_info_his_cust_id_index
	on mmf_order_info_his (cust_id)
;

create index mmf_order_info_his_op_type_status_index
	on mmf_order_info_his (op_type, status)
;

ALTER TABLE wealth.pc_customer_attribute ADD mmf_open_flag CHAR(1) DEFAULT 0 NOT NULL;
ALTER TABLE wealth.pc_customer_attribute MODIFY mmf_open_flag CHAR(1) NOT NULL DEFAULT '0' COMMENT '货基开户标志：0未开通、1开通中、2已开通';