insert into cs_task_define (TASK_ID, TASK_NAME, STEP_NO, FUND_COMP_NO, TYPE, INTERFACE_NAME, FILEN_AME, LOCAL_PATH, SFTP_PATH, REMARK, CREATE_TIME, UPDATE_TIME)
values (1, '处理基金公司收益文件', 7, 'FUND_PH', 0, 'fundProfitDetailService', 'profit_check', 'd:\\sffund\\download', '/sysfund/download/', '清算流程任务', '19-10月-17 12.00.00.000000 上午', '19-10月-17 12.00.00.000000 上午');

insert into cs_task_define (TASK_ID, TASK_NAME, STEP_NO, FUND_COMP_NO, TYPE, INTERFACE_NAME, FILEN_AME, LOCAL_PATH, SFTP_PATH, REMARK, CREATE_TIME, UPDATE_TIME)
values (2, '处理基金公司净值文件', 7, 'FUND_PH', 0, 'fundNetValueService', 'netvalue_check', 'd:\\sffund\\download', '/sysfund/download/', '清算流程任务', '19-10月-17 12.00.00.000000 上午', '19-10月-17 12.00.00.000000 上午');

insert into cs_task_define (TASK_ID, TASK_NAME, STEP_NO, FUND_COMP_NO, TYPE, INTERFACE_NAME, FILEN_AME, LOCAL_PATH, SFTP_PATH, REMARK, CREATE_TIME, UPDATE_TIME)
values (3, '数据汇总', 10, 'FUND_PH', 0, 'fundDataSumService', null, null,null, '清算流程任务', '19-10月-17 12.00.00.000000 上午', '19-10月-17 12.00.00.000000 上午');

insert into cs_task_define (TASK_ID, TASK_NAME, STEP_NO, FUND_COMP_NO, TYPE, INTERFACE_NAME, FILEN_AME, LOCAL_PATH, SFTP_PATH, REMARK, CREATE_TIME, UPDATE_TIME)
values (4, '数据备份', 6, 'FUND_PH', 0, 'fundDataBackupService', null, null, null, '清算流程任务', '19-10月-17 12.00.00.000000 上午', '19-10月-17 12.00.00.000000 上午');

insert into cs_task_define (TASK_ID, TASK_NAME, STEP_NO, FUND_COMP_NO, TYPE, INTERFACE_NAME, FILEN_AME, LOCAL_PATH, SFTP_PATH, REMARK, CREATE_TIME, UPDATE_TIME)
values (5, '日终', 11, 'FUND_PH', 0, 'fundClearingDateEndService', null, null, null, '清算流程任务', '19-10月-17 12.00.00.000000 上午', '19-10月-17 12.00.00.000000 上午');
