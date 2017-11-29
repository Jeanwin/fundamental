package com.achievo.tgm.web.util;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.achievo.tgm.SysConstants;

/**
 * 中国工商银行充值工具类
 * 
 * @author niujunhong
 * 
 */
public class ICBCRechargeUtil {
	private static Logger logger = LoggerFactory
			.getLogger(ICBCRechargeUtil.class);
	private static Properties p = null;
	static {
		p = new Properties();
		InputStream ins = null;
		try {
			ins = ICBCRechargeUtil.class
					.getResourceAsStream("/pay/icbc/icbcRecharge.properties");
			p.load(ins);
		} catch (IOException e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		} finally {
			if (ins != null) {
				try {
					ins.close();
				} catch (IOException e) {
					e.printStackTrace();
					logger.error(e.getMessage());
				}
			}
		}
	}
	// key path
	public static final String KEY_PATH = "/pay/";
	// 银行公钥文件名
	public static final String BANKPUBCERT = p.getProperty("ICBC.BANKPUBCERT");
	// 公钥文件名
	public static final String PUBCERT = p.getProperty("ICBC.PUBCERT");
	// 私钥文件名
	public static final String PRIKEY = p.getProperty("ICBC.PRIKEY");

	// 充值银行url地址 测试的时候是 test 地址，以后修改为正式的地址
	public static final String RECHARGE_URL = p
			.getProperty("ICBC.RECHARGE_URL");
	// 网银接口名称
	public static final String INTERFACENAME = p
			.getProperty("ICBC.INTERFACENAME");

	// 网银接口版本号
	public static final String INTERFACEVERSION = p
			.getProperty("ICBC.INTERFACEVERSION");
	//交易数据xml模版文件路劲
	public static final String TRANDATATPL = p
			.getProperty("ICBC.TRANDATATPL");
	
	//商户代码
	public static final String MERID = p
			.getProperty("ICBC.MERID");
	//返回商户URL
	public static final String MERURL = p
			.getProperty("ICBC.MERURL");

	private ICBCRechargeUtil() {

	}
	public static String getTranDataXml(String orderType,String oid, String amt,String merVAR) {
		try {
			String orderDate = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			String orderId = "";
			//0表示充值
			if(orderType.equals("0")){
				orderId = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
			}else if(orderType.equals(SysConstants.PRODUCT_TYPE_HOTEL_ROOM)){
				orderId = oid;
			}
			StringBuffer sb=new StringBuffer();
			
			sb.append("<?xml version=\"1.0\" encoding=\"GBK\" standalone=\"no\"?>");
				sb.append("<B2CReq>");
					sb.append("<interfaceName>").append(INTERFACENAME).append("</interfaceName>");
					sb.append("<interfaceVersion>").append(INTERFACEVERSION).append("</interfaceVersion>");
					sb.append("<orderInfo>");
						sb.append("<orderDate>").append(orderDate).append("</orderDate>");
						sb.append("<curType>001</curType>");
						sb.append("<merID>").append(MERID).append("</merID>");
						sb.append("<subOrderInfoList>");
							sb.append("<subOrderInfo>");
								sb.append("<orderid>").append(orderId).append("</orderid>");
								sb.append("<amount>").append(amt).append("</amount>");
								sb.append("<installmentTimes>1</installmentTimes>");
								sb.append("<merAcct>4000024109200213417</merAcct>");
								sb.append("<goodsID>0</goodsID>");
								sb.append("<goodsName>笔记本</goodsName>");
								sb.append("<goodsNum>1</goodsNum>");
								sb.append("<carriageAmt></carriageAmt>");
							sb.append("</subOrderInfo>");
						sb.append("</subOrderInfoList>");
					sb.append("</orderInfo>");
					sb.append("<custom>");
						sb.append("<verifyJoinFlag>0</verifyJoinFlag>");
						sb.append("<Language>ZH_CN</Language>");
					sb.append("</custom>");
					sb.append("<message>");
						sb.append("<creditType>2</creditType>");
						sb.append("<notifyType>HS</notifyType>");
						sb.append("<resultType>0</resultType>");
						sb.append("<merReference>www.dy12301.com</merReference>");
						sb.append("<merCustomIp></merCustomIp>");
						sb.append("<goodsType>0</goodsType>");
						sb.append("<merCustomID></merCustomID>");
						sb.append("<merCustomPhone>13715103902</merCustomPhone>");
						sb.append("<goodsAddress></goodsAddress>");
						sb.append("<merOrderRemark></merOrderRemark>");
						sb.append("<merHint></merHint>");
						sb.append("<remark1>"+orderType+"</remark1>");
						sb.append("<remark2></remark2>");
						sb.append("<merURL>").append(MERURL).append("</merURL>");
						sb.append("<merVAR>").append(merVAR).append("</merVAR>");
					sb.append("</message>");
				sb.append("</B2CReq>");
		   System.out.println(sb.toString());
		   return sb.toString();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return "";
	}
	
	public static String[] getAmtAndOidFromNotifyData(String notifyDataXml) {
		try {
			Document doc  = DocumentHelper.parseText(notifyDataXml);
			Element root=doc.getRootElement();
			//订单
			Node orderid =root.selectSingleNode("orderInfo/subOrderInfoList/subOrderInfo/orderid");
			String oid= orderid.getText();
			 //金额
			Node amount =root.selectSingleNode("orderInfo/subOrderInfoList/subOrderInfo/amount");
			String amt= amount.getText();
			 //支付状态
			Node tranStat =root.selectSingleNode("bank/tranStat");
			String status= tranStat.getText();
			 //订单类型(0：允值，1：酒店房间订单)
			Node orderT =root.selectSingleNode("message/remark1");
			String orderType= orderT.getText();
			return new String[]{oid,amt,status,orderType};
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return null;
	}
}
