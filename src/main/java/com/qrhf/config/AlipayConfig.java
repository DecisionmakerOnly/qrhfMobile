package com.qrhf.config;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {
	
//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

	// 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
	public static String app_id = "2019032863717597";
	
	// 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCoOP6xrbVzXihupa9ta+pVju10k3aDzcTI6WaUUhmSB6t9IxNcW6zEVUmMd51SzYU0dlS/DvvTxxlSs2yMzfoYVLPTlierlf1Jv4QVByfcHGfCE829lY09MIhUceJpenyvsWwkpeIPH53HPoNOB3YCch6ZeR0bUhJIiefU9E1IbWIbKgnbtt7ZV1AO8aOAInLa2rmwYXAk4YfbHOiMZ7mJ3QH7KIIWwja+hd+XybJvnQQ0ePuJN2SYlyptoXookVHJoHL07PPzfZPObgix0Q9cWGOBClz6c74/nGtI7Ay6IWEeHJnic0NedI3cFpTPtIvbmStCBZFpoMnbejVCm7PZAgMBAAECggEAFq44iLQm9rsHMIPeNx6JpadzlHgdTn/7vCrbzbuT/wBRurlz7svda0skc2/dIkDbaMtbebcHdPIvE9tlE0biJU2mQSzJhHTghYTwxfUFBsQ9qQkKgDkdpdZZSylfoWEGVpnRPs+uvuNAXpCrG2YeHw5L2d1ec0SJeoY9X5Tgppb/p3fDGS8+AF0q/YwR+GhP+KC2fnowQp86UDhpqmxoM2jpikyvt1c1NS5KGzGCaOfQGGAI2ITGCjsxqEPNI7y9g98+sanEarTOzef0NjO97GPtjIPc+pisbgRZ/wG0dc6vpG5r/oyZWmSiQnrjL1f5lfHaetClmwoDTh+V+fHaAQKBgQD/yA1m4nxWK4+h1246YtSRLM1UFWApsVbbuapVpvEfW8F9WtItPtOZ+2RsK4+d9BoSyANUo7tWyiJ1fDT9Ax3AhTYbiD8si/TDApyfPZFuEICATphhzXDqLIPTySwScI07N/OMIaz+tO9MJrn72XH3Q9giJipkqhPTqaMy4aRJ0QKBgQCoXcplhlB16oe6bCeGMFwgAFBoEAic4abOcy/ETIuAkuYubWWvsznstvoRr1aK2gNR1pxS3EhLBmUQoJtEfVttF4tLsYD8PIEB2s3CDBCw8AFR29W4ASgsTfIADMvQWXr1QEM7gFKc/8z5L/CKS5RBccIuoz2Nhm2ahaj/jZbDiQKBgHnp22FvkD3uM167dQGFO7YaeZ+bNKOKsFC4dRSwJnuA23+pO0ZvjKH3Lc1VEfYCdC8BgHzmMZPTcos28Xaq9pJdrAWBckMETlxosUhBK0Efwm/lhkIPjsM/BnJ6j3QWi2pvZ7kiD/ezO9+7EaiV4vktMCZOtKQYYKzhTTUiUZERAoGBAIbZ0EEuqgU32oxDEgkVdMQg3EXtCaj1x0+1zH1yPY22mux2rKpkZ7GkAHjnse42ndAPj1eCndiRf6MosBPUP8UJxYTT4BanM0DUClcwqLG/GZ+B7xSYwJ9zsq+9kAUJlkUWuoLOzdx3uamgbw2laVJdlgUatDNFh0XrZieBNU7ZAoGAa8FG9pwuR0UXjxS5D/bqmmUIRb3sUiJSXRC11wAv70MWRn6EyQ406JbpevoGwhegsiAZt+jl3kwjhzr68ceGGKW4u73z72mD3VQmMFRxm+SSOFx2hCHciSlvT/twFCLvrtZyYDLohd5YejBXJg5uvjH6HsgppmSFYf4PRqzLOC0=";
	
	// 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjv6U+kzVjd2VDrYzmGid+sSWazEiWqkNf0/kMUJdlDc6uRg3qA9hppY+91jcRtYvyJVdGNuIDoeP1D0O6FZ/PjtqlJaSnXm25EafVHso4WZIVfap8xTHyVV4ONF7DvFut4ldGk9wmWHQ+ug9PAZ9yTrTjLJQnIxbiSQMEKFIugoOb+zClpXMON2zz0cx3eKWYy7gF/icqASaBKAk3ArZAQ/pruuL5w5gC66DdD/ltP/1ZM0bB1Jv4SWBFI9fUsNZ8R+vURGzLmfDwbr7Ssd5pWJd1wbzfd1k/ukl9pZ/9ZdpGR4Sy6e/tY3PDLPqnQ9B3XR2SHIxhYbmFkN+kQ/2OQIDAQAB";

	// 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String notify_url = "http://www.zdcigo.com/notify_url.jsp";

	// 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
	public static String return_url = "http://www.zdcigo.com/return_url.jsp";

	// 签名方式
	public static String sign_type = "RSA2";
	
	// 字符编码格式
	public static String charset = "utf-8";
	
	// 支付宝网关
	public static String gatewayUrl = "https://openapi.alipay.com/gateway.do";
	
	// 支付宝网关
	public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /** 
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

