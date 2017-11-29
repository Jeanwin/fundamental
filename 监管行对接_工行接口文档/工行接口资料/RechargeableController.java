package com.achievo.tgm.web.web.paymanager;

import java.io.File;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.com.infosec.icbc.ReturnValue;

import com.achievo.tgm.QuickPayConf;
import com.achievo.tgm.SysConstants;
import com.achievo.tgm.modules.mapper.BeanMapper;
import com.achievo.tgm.modules.utils.StringUtil;
import com.achievo.tgm.web.dao.account.UserDao;
import com.achievo.tgm.web.dao.pay.PayRecordDao;
import com.achievo.tgm.web.entity.account.User;
import com.achievo.tgm.web.entity.dto.account.UserDto;
import com.achievo.tgm.web.entity.dto.hotel.orderroom.OrderRoomDto;
import com.achievo.tgm.web.entity.dto.pay.TradeAccountDto;
import com.achievo.tgm.web.entity.hotel.orderroom.OrderRoom;
import com.achievo.tgm.web.entity.tradeacount.PayRecord;
import com.achievo.tgm.web.service.hotel.orderroom.OrderRoomManager;
import com.achievo.tgm.web.service.pay.ITradeAccountService;
import com.achievo.tgm.web.service.pay.OrderPayManager;
import com.achievo.tgm.web.service.pay.ReChargeServiceManager;
import com.achievo.tgm.web.util.DateUtils;
import com.achievo.tgm.web.util.ICBCRechargeUtil;
import com.achievo.tgm.web.util.PropertieFileUtil;
import com.achievo.tgm.web.util.QuickPayUtil;
import com.achievo.tgm.web.util.RechargeUtil;
import com.achievo.tgm.web.util.StringUtils;

/**
 * 充值
 */
@Controller
@RequestMapping("/pay/rechargeable")
public class RechargeableController {
	private static Logger logger = LoggerFactory
			.getLogger(RechargeableController.class);
	@Autowired
	private UserDao userDao;
	@Autowired
	private PayRecordDao payRecordDao;
	@Autowired
	private ReChargeServiceManager reChargeServiceManager;
	@Autowired
	private OrderPayManager orderPayManager;
	@Autowired
	private OrderRoomManager orderRoomManager;
	@Autowired
	private ITradeAccountService tradeAccountService;

	/**
	 * 
	 * 充值首頁
	 * 
	 * @return
	 */
	@RequestMapping(value = "rIndex")
	public String rIndex(HttpServletRequest request, Model model) {
		UserDto userDto = (UserDto) SecurityUtils.getSubject().getSession()
				.getAttribute(SysConstants.LOGIN_USER_INFO);
		model.addAttribute("userDto", userDto);
		
		TradeAccountDto tradeAccountDto = tradeAccountService
				.getCurrentAcount(userDto);
		model.addAttribute("tradeAccountDto", tradeAccountDto);
		
	    float fMoney= tradeAccountDto.getFreezeMoney()==null?0f:tradeAccountDto.getFreezeMoney();
	    float balance=tradeAccountDto.getAccountBalance() == null?0f:tradeAccountDto.getAccountBalance();
	    float canUseBlance=balance-fMoney;
		model.addAttribute("canUseBlance", canUseBlance);
		String isPay = request.getParameter("isPay");
		if (!StringUtil.isBlank(isPay)) {
			model.addAttribute("isPay", isPay);
			model.addAttribute("payType", request.getParameter("payType"));
			model.addAttribute("payPrice", request.getParameter("payPrice"));
			model.addAttribute("payYear", request.getParameter("payYear"));
			model.addAttribute("halfValue", request.getParameter("halfValue"));
			model.addAttribute("yearValue", request.getParameter("yearValue"));
		}
		String rechargeAmt = request.getParameter("rechargeAmt");
		if (!StringUtil.isBlank(rechargeAmt)) {
			model.addAttribute("rechargeAmt", rechargeAmt);
		}

		return "/pay/rechargeable/rechargeableForm";
	}

	/**
	 * 
	 * 充值提交接收方法
	 * 
	 * @return
	 */
	@RequestMapping(value = "dorecharge")
	public String dorecharge(HttpServletRequest request, Model model) {
		logger.debug("--------------消费交易签名Begin---------------");
		String bankType = request.getParameter("bankType").trim();
		if(bankType.equals("chinaPay")){
			return dorechargeChinaPay( request,  model);
		}
		else if(bankType.equals("icbc")){
			return dorechargeICBC( request,  model);
		}else{
			return null;
		}
	}
	public String dorechargeICBC(HttpServletRequest request, Model model) {
		String orderType = request.getParameter("orderType");
		String transAmtReq = request.getParameter("transAmt").trim();
		float amt = Float.parseFloat(transAmtReq);
		DecimalFormat df = new DecimalFormat("#.00");
		String tanAmt = df.format(amt).replace(".", "");
		String isPay = request.getParameter("isPay");
		if (!StringUtil.isBlank(isPay)) {
			model.addAttribute("isPay", isPay);
		}
		UserDto userDto = (UserDto) SecurityUtils.getSubject().getSession()
				.getAttribute(SysConstants.LOGIN_USER_INFO);
		try {
			// 自定义变量
			String merVAR = userDto.getUserId()+"";
			String tranData = "";
			if(orderType==null){
				tranData = ICBCRechargeUtil.getTranDataXml("0", "", tanAmt, merVAR);
			}else{
				String oid = RechargeUtil.fillOrderId(orderType, request.getParameter("oid"),16);
				tranData = ICBCRechargeUtil.getTranDataXml(orderType, oid, tanAmt, merVAR);
			}
			logger.debug(tranData);
			String password = "12345688";
			byte[] byteTranData = tranData.getBytes("GBK");
			char[] keyPass = password.toCharArray();
			byte[] bcert = FileUtils.readFileToByteArray(new File(
					RechargeUtil.class.getResource(ICBCRechargeUtil.PUBCERT)
							.getPath()));
			byte[] bkey = FileUtils.readFileToByteArray(new File(
					RechargeUtil.class.getResource(ICBCRechargeUtil.PRIKEY)
							.getPath()));

			byte[] sign = ReturnValue.sign(byteTranData, byteTranData.length,
					bkey, keyPass);
			if (sign == null) {
				logger.debug("签名失败,签名返回为空。请检查证书私钥和私钥保护口令是否正确。");
			} else {
				logger.debug("签名成功");

				String RECHARGE_URL = ICBCRechargeUtil.RECHARGE_URL;
				logger.debug("RECHARGE_URL：" + RECHARGE_URL);
				model.addAttribute("RECHARGE_URL", RECHARGE_URL);

				String interfaceName = ICBCRechargeUtil.INTERFACENAME;
				logger.debug("接口名称 interfaceName：" + interfaceName);
				model.addAttribute("interfaceName", interfaceName);

				String interfaceVersion = ICBCRechargeUtil.INTERFACEVERSION;
				logger.debug("接口版本号 interfaceVersion：" + interfaceVersion);
				model.addAttribute("interfaceVersion", interfaceVersion);

				byte[] encByteTranData = ReturnValue.base64enc(byteTranData);
				String tranDataBase64 = new String(encByteTranData).toString();
				logger.debug("交易数据tranData BASE64编码：" + tranDataBase64);
				model.addAttribute("tranDataBase64", tranDataBase64);

				byte[] encSign = ReturnValue.base64enc(sign);
				String merSignMsgBase64 = new String(encSign).toString();
				logger.debug("订单签名数据 merSignMsg BASE64编码：" + merSignMsgBase64);
				model.addAttribute("merSignMsgBase64", merSignMsgBase64);

				byte[] encCert = ReturnValue.base64enc(bcert);
				String merCertBase64 = new String(encCert).toString();
				logger.debug("商城证书公钥merCert BASE64编码：" + merCertBase64);
				model.addAttribute("merCertBase64", merCertBase64);

				byte[] DecSign = ReturnValue.base64dec(encSign);
				if (DecSign != null) {
					logger.debug("签名信息BASE64解码成功");
					byte[] DecCert = ReturnValue.base64dec(encCert);
					if (DecCert != null) {
						logger.debug("证书公钥BASE64解码成功");
						int a = ReturnValue.verifySign(byteTranData,
								byteTranData.length, DecCert, DecSign);
						if (a == 0) {
							logger.debug("验签成功");
						} else {
							logger.debug("验签失败,验证返回码：" + a);
						}

					} else {
						logger.debug("证书BASE64解码失败");
					}
				} else {
					logger.debug("签名信息BASE64解码失败");
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getLocalizedMessage());
		}
		return "/pay/rechargeable/icbc/dorechargeForm";
	}
	public String dorechargeChinaPay(HttpServletRequest request, Model model) {
		UserDto userDto = (UserDto) SecurityUtils.getSubject().getSession()
				.getAttribute(SysConstants.LOGIN_USER_INFO);
		int interfaceType =Integer.parseInt(request.getParameter("interfaceType"));
		String orderType =request.getParameter("orderType");
//		String MERID = RechargeUtil.getChinaPayMerId(interfaceType);
		String MERID = QuickPayConf.merCode;
		logger.debug("--------------消费交易签名Begin---------------");
		String ordId = request.getParameter("oid");
		if(orderType==null){
			ordId = RechargeUtil.createOrderId(interfaceType);
		}else{
			OrderRoomDto orderRoomDto = orderRoomManager.findOrderRoom(Long.parseLong(ordId));
			OrderRoom orderRoom = BeanMapper.map(orderRoomDto, OrderRoom.class);
			if(orderRoomManager.isOverTime(orderRoom)){
				model.addAttribute("message", "抱歉，您的订单支付超时，请重新下单！");
				return "/pay/orderpay/orderPayFail";
			}
			
			if(orderRoomDto.getStatus().intValue() == SysConstants.ORDER_ROOM_STATUS_CODE[0]){
				model.addAttribute("message", "抱歉，该笔订单您已完成支付，不能重复支付！");
				return "/pay/orderpay/orderPayFail";
			}
			ordId = RechargeUtil.fillOrderId(orderType, ordId,16);
		}
		
		// 交易金额格式组装。
		String transAmtReq = request.getParameter("transAmt").trim();
		final String transAmt = RechargeUtil.createAmtStrByAmtReg(transAmtReq);

		String isPay = request.getParameter("isPay");
		orderType=orderType==null?"0":orderType;
		String merReserved = "";
		String orderTime = DateUtils.formatDate(new Date(), "yyyyMMddHHmmss");
		String timerOut = String.valueOf(PropertieFileUtil.getIntegerValue("hotel.orderroom.timeout")*60*1000);
		String param = "?userId="+userDto.getUserId()+"&isPay="+isPay+"&orderType="+orderType;
		String merFrontEndUrl = QuickPayConf.merFrontEndUrl+param;
		String merBackEndUrl = QuickPayConf.merBackEndUrl+param;
		StringBuffer signStr = new StringBuffer();
		signStr.append("version="+QuickPayConf.version+"&");
		signStr.append("charset="+QuickPayConf.charset+"&");
		signStr.append("transType="+QuickPayConf.transPay+"&");
		signStr.append("merId="+QuickPayConf.merCode+"&");
		signStr.append("merAbbr="+QuickPayConf.merName+"&");
		signStr.append("orderNumber="+ordId+"&");
		signStr.append("orderAmount="+transAmt+"&");
		signStr.append("orderCurrency="+QuickPayConf.curRMB+"&");
		signStr.append("orderTime="+orderTime+"&");
		signStr.append("customerIp="+"121.199.51.159"+"&");
		signStr.append("customerName="+userDto.getName()+"&");
		signStr.append("transTimeout="+timerOut+"&");
		signStr.append("frontEndUrl="+merFrontEndUrl+"&");
		signStr.append("backEndUrl="+merBackEndUrl+"&");
		signStr.append("merReserved="+merReserved+"&");
		logger.debug("merReserved:" + signStr.toString());
    
		String[] valueVo = new String[]{
				QuickPayConf.version,//协议版本
				QuickPayConf.charset,//字符编码
				QuickPayConf.transPay,//交易类型
				QuickPayConf.merName,//商户简称
	            QuickPayConf.merCode,//商户代码
	            merBackEndUrl,// 后台回调商户URL
	            merFrontEndUrl,// 前台回调商户URL
	            orderTime,//交易时间
	            ordId,//订单号（需要商户自己生成）
	            transAmt,//交易金额 单位：分
	            QuickPayConf.curRMB,//交易币种
	            "121.199.51.159",//用户IP
	            userDto.getName(),
	            timerOut,//交易超时时间
	            merReserved//商户保留域
		};
		Map<String, String> map = new TreeMap<String, String>();
		for (int i = 0; i < QuickPayConf.reqVo.length; i++) {
			map.put(QuickPayConf.reqVo[i], valueVo[i]);
		}
		
		String signature = new QuickPayUtil().signMap(map, QuickPayConf.signType);
		model.addAttribute("version", 			QuickPayConf.version);
		model.addAttribute("charset", 			QuickPayConf.charset);
		model.addAttribute("transType", 		QuickPayConf.transPay);
		model.addAttribute("merId", 			QuickPayConf.merCode);
		model.addAttribute("merAbbr", 			QuickPayConf.merName);
		model.addAttribute("orderNumber", 		ordId);
		model.addAttribute("orderAmount", 		transAmt);
		model.addAttribute("orderCurrency",		QuickPayConf.curRMB);
		model.addAttribute("orderTime", 		orderTime);
		model.addAttribute("customerIp", 		"121.199.51.159");
		model.addAttribute("customerName", 		userDto.getName());
		model.addAttribute("transTimeout", 		String.valueOf((PropertieFileUtil.getIntegerValue("hotel.orderroom.timeout").intValue()*60*1000)));
		model.addAttribute("actionUrl", 		QuickPayConf.gateWay);
		model.addAttribute("frontEndUrl", 		merFrontEndUrl);
		model.addAttribute("backEndUrl", 		merBackEndUrl);
		model.addAttribute("merReserved", 		merReserved);
		model.addAttribute("signature", 		signature);
		model.addAttribute("signMethod", 		QuickPayConf.signType);
		return "/pay/rechargeable/chinapay/dorechargeForm";
	}
	/**
	 * 银联支付平台充值后回调的方法
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "icbcpageRetUrl")
	public String icbcpageRetUrl(HttpServletRequest request, Model model) {
		try {
			logger.debug("--------bgreturl------消费交易验证Begin---------------");
			String orderType =request.getParameter("orderType");
			String msg = null;
			String userId =request.getParameter("merVAR");
			logger.debug("userId:" + userId);
			String notifyDataBase64 = request.getParameter("notifyData");
			logger.debug("notifyDataBase64->" + notifyDataBase64);
			byte notifyDataBytes[] = notifyDataBase64.getBytes();
			byte[] notifyData = ReturnValue.base64dec(notifyDataBytes);
			String notifyDataXml = new String(notifyData,"GBK");
			logger.debug(notifyDataXml);
			String isPay="1";
			String signMsg = request.getParameter("signMsg");
			logger.debug("signMsg:"+signMsg);
			
			//记录银行响应流水
			PayRecord payRecord = new PayRecord();
			payRecord.setUserId(Long.parseLong(userId));
			User user = userDao.findOne(Long.parseLong(userId));
			payRecord.setUserName(user.getName());
			payRecord.setPayBank("工商银行");

			payRecord.setSign(signMsg);
			payRecord.setCipherText(notifyDataBase64);
			payRecord.setPlainText(notifyDataXml);
			payRecord.setCreateDate(new Timestamp(System.currentTimeMillis()));

			byte[] encSign = signMsg.getBytes("GBK");

			byte[] bcert = FileUtils.readFileToByteArray(new File(
					RechargeUtil.class.getResource(ICBCRechargeUtil.BANKPUBCERT)
							.getPath()));
			byte[] encCert = ReturnValue.base64enc(bcert);

			byte[] DecSign = ReturnValue.base64dec(encSign);
			String[] aOids= null;
			if (DecSign != null) {
				logger.debug("签名信息BASE64解码成功");
				byte[] DecCert = ReturnValue.base64dec(encCert);
				if (DecCert != null) {
					logger.debug("证书公钥BASE64解码成功");
					int a = ReturnValue.verifySign(notifyData,
							notifyData.length, DecCert, DecSign);
					if (a == 0) {
						aOids = ICBCRechargeUtil
								.getAmtAndOidFromNotifyData(notifyDataXml);
						logger.debug("验签成功");
						if(aOids[2].equals("1")){
							logger.debug("消费交易成功!OrdId:" + aOids[0] + ",TransAmt:"
									+ aOids[1]);
							if(aOids[3].equals("0")){
								reChargeServiceManager.rechargeSuccessRecord(userId,
									aOids[0], Float.parseFloat(aOids[1].trim())/100);
							}else{
								orderPayManager.paySuccessRecord(SysConstants.PAY_CHANNEL_ICBC, 0, aOids[3], Long.parseLong(userId),
										Long.parseLong(aOids[0]), Float.parseFloat(aOids[1].trim())/100,"",null);
							}
							msg = "交易成功!";
							isPay="2";
						}else{
							logger.debug("消费交易失败!OrdId:" + aOids[0] + ",TransAmt:"
									+ aOids[1]+"分");
							msg = "交易失败!";
						}
					} else {
						logger.debug("验签失败,验证返回码：" + a);
					}

				} else {
					logger.debug("证书BASE64解码失败");
				}
			} else {
				logger.debug("签名信息BASE64解码失败");
			}
			if(aOids!=null && aOids.length==4 && aOids[3].equals("0")){
				payRecord.setPayType("充值");
			}else{
				payRecord.setPayType("支付");
			}
			payRecordDao.save(payRecord);
			model.addAttribute("msg", msg);
			model.addAttribute("isPay", isPay);

		} catch (Exception ex) {

		}
		return "/pay/rechargeable/icbc/pageRetUrl";
	}

	
	/**
	 * 银联支付平台充值后回调的方法
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "bgreturl")
	public void bgreturl(HttpServletRequest request, Model model) {
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			logger.debug(name+"="+valueStr);
		}
		
		logger.debug("--------bgreturl------消费交易验证Begin---------------");
		if(request.getParameter(QuickPayConf.notifyVo[0]) == null){
			logger.debug("无效请求");
			return;
		}
		String values = "";
		String[] resArr = new String[QuickPayConf.notifyVo.length]; 
		for(int i=0;i<QuickPayConf.notifyVo.length;i++){
			resArr[i] = request.getParameter(QuickPayConf.notifyVo[i]);
			values += QuickPayConf.notifyVo[i]+"="+resArr[i] +"&";
		}
		logger.debug("values:"+values);
		String userId = request.getParameter("userId");
		String orderType = request.getParameter("orderType");
		Long oid = Long.parseLong(resArr[15]);
		String transAmt = RechargeUtil.formartTranseAmt(resArr[14]);
		Float transAmtD = Float.parseFloat(transAmt);
		String signature = request.getParameter(QuickPayConf.signature);
		String signMethod = request.getParameter(QuickPayConf.signMethod);
		
		//记录银行响应流水
		PayRecord payRecord = new PayRecord();
		payRecord.setUserId(Long.parseLong(userId));
		User user = userDao.findOne(Long.parseLong(userId));
		payRecord.setUserName(user.getName());
		payRecord.setPayBank("银联支付");
		if(orderType.equals("0")){
			payRecord.setPayType("充值");
		}else{
			oid = Long.parseLong(resArr[15].substring(1, resArr[15].length()));
			payRecord.setPayType("支付");
		}
		payRecord.setOrderId(oid.toString());
		payRecord.setSign(signature);
		payRecord.setPlainText("merId:"+resArr[4]+"---OrderStatus:"+resArr[0]+"---Priv1:"+userId+"---transDate:"+resArr[6]);
		payRecord.setMoney(transAmtD);
		payRecord.setCreateDate(new Timestamp(System.currentTimeMillis()));
		payRecordDao.save(payRecord);

		Boolean signatureCheck = new QuickPayUtil().checkSign(resArr, signMethod, signature);
		

		if(!signatureCheck){
			logger.debug("交易验证失败!");
		}else{
			logger.debug("交易验证成功!");
			if(!"00".equals(resArr[0])){
				logger.debug("交易失败："+resArr[17]);
				orderPayManager.payFailure(orderType, oid);
			}else{
				logger.debug("消费交易成功!OrdId:" + oid + ",TransAmt:" + transAmtD);
				if(orderType.equals("0")){
					reChargeServiceManager.rechargeSuccessRecord(userId, oid.toString(),
							transAmtD);
				}else{
					
					int interfaceType = 11;//RechargeUtil.getChinaPayInterfaceType(resArr[5]);
					orderPayManager.paySuccessRecord(SysConstants.PAY_CHANNEL_CHINAPAY, interfaceType, orderType, Long.parseLong(userId),
							oid, transAmtD, resArr[3], null);
				}
			}
		}
	}

	@RequestMapping(value = "pageRetUrl")
	public String pageRetUrl(HttpServletRequest request, Model model) {
		logger.debug("-------pageRetUrl-------消费交易验证Begin---------------");
		String values = "";
		String[] resArr = new String[QuickPayConf.notifyVo.length]; 
		for(int i=0;i<QuickPayConf.notifyVo.length;i++){
			resArr[i] = request.getParameter(QuickPayConf.notifyVo[i]);
			values += QuickPayConf.notifyVo[i]+"="+resArr[i] +"&";
		}
		logger.debug("values:"+values);
		String msg = "";
		Long oid = Long.parseLong(resArr[15]);
		String userId = request.getParameter("userId");
		String orderType = request.getParameter("orderType");
		String transAmt = RechargeUtil.formartTranseAmt(resArr[14]);
		Float transAmtD = Float.parseFloat(transAmt);
		String signature = request.getParameter(QuickPayConf.signature);
		String signMethod = request.getParameter(QuickPayConf.signMethod);
		if(!orderType.equals("0")){
			oid = Long.parseLong(resArr[15].substring(1, resArr[15].length()));
		}
		Boolean signatureCheck = new QuickPayUtil().checkSign(resArr, signMethod, signature);
		
		if (!signatureCheck) {
			// FIXME 处理
			logger.debug("交易验证失败!");
		} else {
			logger.debug("交易验证成功!");
			if(!"00".equals(resArr[0])){
				msg = "交易失败：!" + resArr[17];
			}else{
				msg = "交易成功!";
				logger.debug("消费交易成功!OrdId:" + oid + ",TransAmt:" + transAmtD);
			}
		}
		model.addAttribute("msg", msg);
		if(orderType.equals("0")){
			return "/pay/rechargeable/chinapay/pageRetUrl";
		}else{
			OrderRoomDto orderRoom = orderRoomManager.findOrderRoom(oid);
			model.addAttribute("orderId", orderRoom.getOrderId());
			model.addAttribute("transAmt", orderRoom.getPrice());
			return "/pay/orderpay/orderPaySucess";
		}


	}
}
