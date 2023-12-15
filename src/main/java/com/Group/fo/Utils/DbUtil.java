package com.Group.fo.Utils;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DbUtil {
	/**
	 * 출처 : https://moonleafs.tistory.com/52
     * ResultSet을 Row마다 Map에 저장후 List에 다시 저장.
     * @param rs DB에서 가져온 ResultSet
     * @return Listt<map> 형태로 리턴
     * @throws Exception Collection
     */
    public List<Map<String, Object>> getResultMapRows(ResultSet rs) throws Exception{
        // ResultSet 의 MetaData를 가져온다.
        ResultSetMetaData metaData = rs.getMetaData();
        // ResultSet 의 Column의 갯수를 가져온다.
        int sizeOfColumn = metaData.getColumnCount();
 
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> map;
        String column;
        // rs의 내용을 돌려준다.
        while (rs.next())
        {
            // 내부에서 map을 초기화
            map = new HashMap<String, Object>();
            // Column의 갯수만큼 회전
            for (int indexOfcolumn = 0; indexOfcolumn < sizeOfColumn; indexOfcolumn++)
            {
                column = metaData.getColumnName(indexOfcolumn + 1);
                // map에 값을 입력 map.put(columnName, columnName으로 getString)
                map.put(column, rs.getString(column));
            }
            // list에 저장
            list.add(map);
        }
        return list;
    }	
	
}
