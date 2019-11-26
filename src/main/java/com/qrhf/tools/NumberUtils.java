package com.qrhf.tools;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 保证采购表序号的连续
 */
public class NumberUtils {

	public static int continuous(List<String> list) {
		if(null == list || list.size()==0) {
			return 1;
		}else {
			List<Integer> lists = new ArrayList<>();
			for (int i = 0; i < list.size(); i++) {
				String str = list.get(i);
				String sub = str.substring(str.length()-2, str.length());
				Integer num = Integer.valueOf(sub);
				lists.add(num);
			}
			Collections.sort(lists);
			int j = 0;
			if(lists.get(0)!=1) {
				j = 1;
			}
			for (int i = 0; i < lists.size(); i++) {
				if((i+1)==lists.get(i)) {
					j = (lists.get(i))+1;
				}
			}
			return j;
		}
	}
}
