package com.mdc.dao;

import java.util.List;
import java.util.Map;

import com.mdc.util.PageUtil;
import com.mdc.view.MlinkSingle;

public interface SingleDao {
	public int save(MlinkSingle single) throws Exception;

	public List<Map<String, Object>> getAllMapList(Map<String, Object> map) throws Exception;

	public List<MlinkSingle> getList(PageUtil<MlinkSingle> page, Map<String, Object> map) throws Exception;
	
	public int delete(String id)throws Exception;
	
	public int update(MlinkSingle single)throws Exception;
	
	public MlinkSingle getSingleByNodeId(String nodeid) throws Exception;
}
