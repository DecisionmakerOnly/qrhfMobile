package com.qrhf.tools;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.util.StringUtils;

/**
 * 常用加密算法工具类
 * @author cq
 */
public class EncryptUtil implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 用MD5算法进行加密
	 * @param str 需要加密的字符串
	 * @return MD5加密后的结果
	 */
	public static String encodeMD5String(String str) {
		if (StringUtils.isEmpty(str))
			return null;
		return DigestUtils.md5Hex(str);
	}

}
