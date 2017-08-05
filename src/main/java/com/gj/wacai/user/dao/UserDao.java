package com.gj.wacai.user.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.gj.wacai.user.pojo.User;

@Repository
public interface UserDao {

	public User selectByUserName(@Param("userName") String userName);
	
	public int insert(@Param("userName")String userName, @Param("userPwd")String userPwd);
	
	public User selectById(@Param("id") Integer id);
	
	public int updateUserPwd(@Param("id")Integer id, @Param("newPwd")String newPwd, @Param("updateTime")Date updateTime);
	
	public int updateDefaultAccountUnitId(@Param("id")Integer id, @Param("defaultAccountUnitId")Integer defaultAccountUnitId);
}
