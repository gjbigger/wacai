package com.gj.wacai.excel.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gj.utils.IsLogin;
import com.gj.wacai.excel.service.ExcelService;
import com.gj.wacai.user.pojo.User;

@Controller
@RequestMapping("excel")
public class ExcelController {

	@Resource
	private ExcelService excelService;

	@IsLogin
	@RequestMapping("getWorkbook")
	public void getWorkbook(HttpServletRequest req, HttpServletResponse resp)
			throws ClassNotFoundException, IOException {
		Integer userId = ((User) req.getSession().getAttribute("user")).getId();

		HSSFWorkbook workbook = excelService.getWorkbook(userId);

		// 弹出保存框方式
		String fileName = "wacai" + System.currentTimeMillis();
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		workbook.write(os);
		byte[] content = os.toByteArray();
		InputStream is = new ByteArrayInputStream(content);
		// 设置response参数，可以打开下载页面
		resp.reset();
		resp.setContentType("application/vnd.ms-excel;charset=utf-8");
		resp.setHeader("Content-Disposition",
				"attachment;filename=" + new String((fileName + ".xls").getBytes(), "iso-8859-1"));
		ServletOutputStream out = resp.getOutputStream();
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			bis = new BufferedInputStream(is);
			bos = new BufferedOutputStream(out);
			byte[] buff = new byte[2048];
			int bytesRead;
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
	}

}
