package com.gj.wacai.transfer.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.transfer.dto.TransferDto;
import com.gj.wacai.transfer.pojo.Transfer;
import com.gj.wacai.transfer.query.TransferQuery;

@Repository
public interface TransferDao {

	//根据参数查询转账记录
	public List<TransferDto> selectByParams(TransferQuery transferQuery);
	
	//添加转账
	public int insert(Transfer transfer);
	
	//更新转账
	public int update(Transfer transfer);

	//根据id和userId查询转账
	public Transfer selectByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);

	//根据id和userId删除转账
	public int deleteByIdAndUserId(@Param("id")Integer id, @Param("userId")Integer userId);

}
