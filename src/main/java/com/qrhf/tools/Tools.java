package com.qrhf.tools;

import java.io.File;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;


public class Tools {
	/**
	 * 为模糊查询提供字符串转换：
	 * example：慧用法-->%中%科%软%
	 * @param s
	 * @return
	 */
	public static String fuzzyQueryString(String s){
		StringBuffer sb = new StringBuffer();
		sb.append("%");
		if(isNotEmptyString(s)){
			s=s.replaceAll(" ", "");
			for(int i=0;i<s.length();i++){
				sb.append(s.charAt(i)+"%");
			}
		}
		return sb.toString();
	}
	/**
	* 获取月份起始日期
	* @param date
	* @return
	* @throws ParseException
	*/
	public static Date getMinMonthDate(String date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date(System.currentTimeMillis()));
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
		return calendar.getTime();
	}
	
	/**
	* 获取月份最后日期
	* @param date
	* @return
	* @throws ParseException
	*/
	public static Date getMaxMonthDate(String date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date(System.currentTimeMillis()));
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		return calendar.getTime();
	}
	
	/**
	 * 检查String是否为空,不空 返回true
	 * @param s
	 * @return
	 */
	public static boolean isNotEmptyString(String s){
		if(s!=null&&!s.isEmpty()&&!"".equals(s)){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 检查List是否为空,不空 返回true
	 * @param l
	 * @return
	 */
	public static boolean isNotEmptyList(List l){
		if(l!=null&&l.size()!=0&&!l.isEmpty()){
			for(int i=0;i<l.size();i++){
				if(isNotEmptyFields(l.get(i))){
					l.remove(i);
					i--;
				}
			}
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 删掉List中空对象
	 * @param l
	 * @return
	 */
	public static List removeEmptyObj(List l){
		if(l!=null&&l.size()!=0&&!l.isEmpty()){
			for(int i=0;i<l.size();i++){
				if(l.get(i)==null){
					l.remove(i);
					i--;
				}
			}
		}
		return l;
	}
	
	/**
	 * 检查对象属性是否有值,是空 返回true
	 * @param object 
	 * @return 
	 * @throws Exception
	 */
    public static boolean isNotEmptyFields(Object object){
        Field[] fields = object.getClass().getDeclaredFields();
        boolean flag = true;
        for (Field field : fields) {
            field.setAccessible(true);
            try {
				Object value = field.get(object);
				if(value!=null){
					flag = false;
				}
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
        }
		return flag;  
    }
	
	/**
	 * 把日期转化为字符串，去掉多余的0，如日期格式的2017-01-02转化后为2017-1-2
	 * @param day
	 * @return yyyy-MM-dd
	 */
	public static String DTS(Date day) {
		if(day==null){
			day=new Date();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(day).replaceAll("-0", "-");
	}
	
	/**
	 * 把日期转化为字符串，包含0，如日期格式的2017-01-02转化后为2017-01-02，常用于对前台日期控件赋值
	 * @param day
	 * @return yyyy-MM-dd
	 */
	public static String DTSFillZero(Date day) {
		if(day==null){
			day=new Date();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(day);
	}
	/**
	 * 
	 * @param day 时间
	 * @param format 格式
	 * @return
	 */
	public static String DTS(Date day,String format) {
		if(day==null){
			day=new Date();
		}
		SimpleDateFormat sdf = null;
		if(Tools.isNotEmptyString(format)){
			sdf = new SimpleDateFormat(format);
		}else{
			sdf = new SimpleDateFormat("yyyy-MM-dd");
		}
		return sdf.format(day).replaceAll("-0", "-");
	}
	/**
	 * 
	 * @param day
	 * @return yyyy年MM月dd日
	 */
	public static String DTSChina(Date day) {
		if(day==null){
			day=new Date();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		return sdf.format(day).replaceAll("年0", "年").replaceAll("月0", "月");
	}
	/**
	 * 
	 * @param day
	 * @return yyyy年MM月dd日HH时mm分
	 */
	public static String DTSChinaHourMinute(Date day) {
		if(day==null){
			day=new Date();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
		return sdf.format(day).replaceAll("年0", "年").replaceAll("月0", "月").replaceAll("日0", "日").replaceAll("时0", "时");
	}
	public static Document loadXML(String filename) {
		Document document = null;
		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			document = builder.parse(new File(filename));
			document.normalize();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return document;
	}
	public static boolean doc2XmlFile(Document document, File targetFile) {
		boolean flag = true;
		try {
			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer();
			DOMSource source = new DOMSource(document);
			StreamResult result = new StreamResult(targetFile.toURI().getPath());
			transformer.transform(source, result);
		} catch (Exception ex) {
			flag = false;
			ex.printStackTrace();
		}
		return flag;
	}
	/**
	 * 日期大写二零一七年九月二十日
	 * @param day
	 * @return yyyy年MM月dd日
	 */
	public static String DTSChinaDX(Date day) {
		String[] str={"〇","一","二","三","四","五","六","七","八","九"};
		String[] strTen={"","十","二十","三十"};
		if(day==null){
			day=new Date();
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		String date =sdf.format(day);
		String newdate="";
		for(int i=0;i<date.length();i++){
			if(Character.isDigit(date.charAt(i))){//如果是数字
				if(i==5){//月份的第1个数字不为0的时候才替换
					if(!(date.charAt(i)+"").equals("0")){//不为0的时候才替换
						newdate+=strTen[Integer.parseInt(date.charAt(i)+"")];
					}
				}else if(i==6){//月份的第2个数字不为0的时候才替换
					if(!(date.charAt(i)+"").equals("0")){//不为0的时候才替换
						newdate+=str[Integer.parseInt(date.charAt(i)+"")];
					}
				}else if(i==8){//日的第1个数字不为0的时候才替换
					if(!(date.charAt(i)+"").equals("0")){//不为0的时候才替换
						newdate+=strTen[Integer.parseInt(date.charAt(i)+"")];
					}
				}else if(i==9){//日的第2个数字不为0的时候才替换
					if(!(date.charAt(i)+"").equals("0")){//不为0的时候才替换
						newdate+=str[Integer.parseInt(date.charAt(i)+"")];
					}
				}else{
					newdate+=str[Integer.parseInt(date.charAt(i)+"")];
				}
			}else{
				newdate+=date.charAt(i)+"";
			}
		}
		return newdate;
	}
	public static String isoToUtf8(String s){
		try {
			if(Tools.isNotEmptyString(s)){
				s=new String(s.getBytes("iso-8859-1"),"utf-8");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}
	public static String doubleToString(double d, int fNumber,boolean fillzero){
		if (fNumber < 0)
			fNumber = 0;
		String pattern = null;
		switch (fNumber){
			case 0: pattern = "#0"; 
			break;
			default: pattern = "#0."; 
			StringBuffer b = new StringBuffer(pattern);
			for (int i = 0; i < fNumber; i++){
				if(!fillzero){
					b.append('#');
				}else{
					b.append('0');
				}
			}
			pattern = b.toString();
			break;
		}
		DecimalFormat formatter = new DecimalFormat();
		formatter.applyPattern(pattern);
		String value = formatter.format(d);
		return value;
	}
	
	public static double priceFormat(double price) {
		BigDecimal bd = new BigDecimal(price);
		return bd.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
}
