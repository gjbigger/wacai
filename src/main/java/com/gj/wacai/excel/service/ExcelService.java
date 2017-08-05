package com.gj.wacai.excel.service;

import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

import com.gj.wacai.loan.dao.LoanDao;
import com.gj.wacai.loan.dto.LoanDto;
import com.gj.wacai.loan.query.LoanQuery;
import com.gj.wacai.payIn.dao.PayInDao;
import com.gj.wacai.payIn.dto.PayInDto;
import com.gj.wacai.payIn.query.PayInQuery;
import com.gj.wacai.payOut.dao.PayOutDao;
import com.gj.wacai.payOut.dto.PayOutDto;
import com.gj.wacai.payOut.query.PayOutQuery;
import com.gj.wacai.transfer.dao.TransferDao;
import com.gj.wacai.transfer.dto.TransferDto;
import com.gj.wacai.transfer.query.TransferQuery;

@Service
public class ExcelService {
	
	@Resource
	private PayInDao payInDao;
	@Resource
	private PayOutDao payOutDao;
	@Resource
	private TransferDao transferDao;
	@Resource
	private LoanDao loanDao;

	
	/**
	 * 得到工作簿
	 * @return
	 * @throws ClassNotFoundException 
	 */
	public HSSFWorkbook getWorkbook(Integer userId) throws ClassNotFoundException {
		HSSFWorkbook workbook = new HSSFWorkbook();
		
		HSSFCellStyle cellStyle = workbook.createCellStyle();
        HSSFDataFormat format= workbook.createDataFormat();
        cellStyle.setDataFormat(format.getFormat("yyyy-mm-dd"));
		
		HSSFSheet payInSheet = workbook.createSheet("收入");
		HSSFSheet payOutSheet = workbook.createSheet("支出");
		HSSFSheet transferSheet = workbook.createSheet("转账");
		HSSFSheet loanSheet = workbook.createSheet("借贷");
		
		//收入
		PayInQuery payInQuery = new PayInQuery();
		payInQuery.setUserId(userId);
		List<PayInDto> payInDtoList = payInDao.selectByParams(payInQuery);
		HSSFRow[] payInRow = new HSSFRow[payInDtoList.size()+1];
		payInRow[0] = payInSheet.createRow(0);
		payInRow[0].createCell(0).setCellValue(new HSSFRichTextString("id"));
		payInRow[0].createCell(1).setCellValue(new HSSFRichTextString("金额"));
		payInRow[0].createCell(2).setCellValue(new HSSFRichTextString("时间"));
		payInRow[0].createCell(3).setCellValue(new HSSFRichTextString("备注"));
		payInRow[0].createCell(4).setCellValue(new HSSFRichTextString("类型"));
		payInRow[0].createCell(5).setCellValue(new HSSFRichTextString("账户"));
		for(int i=0,j=payInDtoList.size(); i<j; i++) {
			payInRow[i+1] = payInSheet.createRow(i+1);
			payInRow[i+1].createCell(0).setCellValue(payInDtoList.get(i).getId());
			payInRow[i+1].createCell(1).setCellValue(payInDtoList.get(i).getMoney());
			
			HSSFCell tempCell = payInRow[i+1].createCell(2);
			tempCell.setCellValue(payInDtoList.get(i).getTime());
			tempCell.setCellStyle(cellStyle);
			
			payInRow[i+1].createCell(3).setCellValue(payInDtoList.get(i).getRemark());
			payInRow[i+1].createCell(4).setCellValue(payInDtoList.get(i).getTypeName());
			payInRow[i+1].createCell(5).setCellValue(payInDtoList.get(i).getAccountName());
		}
		
		
		//支出
		PayOutQuery payOutQuery = new PayOutQuery();
		payOutQuery.setUserId(userId);
		List<PayOutDto> payOutDtoList = payOutDao.selectByParams(payOutQuery);
		HSSFRow[] payOutRow = new HSSFRow[payOutDtoList.size()+1];
		payOutRow[0] = payOutSheet.createRow(0);
		payOutRow[0].createCell(0).setCellValue(new HSSFRichTextString("id"));
		payOutRow[0].createCell(1).setCellValue(new HSSFRichTextString("金额"));
		payOutRow[0].createCell(2).setCellValue(new HSSFRichTextString("时间"));
		payOutRow[0].createCell(3).setCellValue(new HSSFRichTextString("备注"));
		payOutRow[0].createCell(4).setCellValue(new HSSFRichTextString("大类型"));
		payOutRow[0].createCell(5).setCellValue(new HSSFRichTextString("小类型"));
		payOutRow[0].createCell(6).setCellValue(new HSSFRichTextString("账户"));
		for(int i=0,j=payOutDtoList.size(); i<j; i++) {
			payOutRow[i+1] = payOutSheet.createRow(i+1);
			payOutRow[i+1].createCell(0).setCellValue(payOutDtoList.get(i).getId());
			payOutRow[i+1].createCell(1).setCellValue(payOutDtoList.get(i).getMoney());
			
			//payOutRow[i+1].createCell(2).setCellValue(payOutDtoList.get(i).getTime());
			HSSFCell tempCell = payOutRow[i+1].createCell(2);
			tempCell.setCellValue(payOutDtoList.get(i).getTime());
			tempCell.setCellStyle(cellStyle);
			
			payOutRow[i+1].createCell(3).setCellValue(payOutDtoList.get(i).getRemark());
			payOutRow[i+1].createCell(4).setCellValue(payOutDtoList.get(i).getBigTypeName());
			payOutRow[i+1].createCell(5).setCellValue(payOutDtoList.get(i).getSmallTypeName());
			payOutRow[i+1].createCell(6).setCellValue(payOutDtoList.get(i).getAccountName());
		}
		
		
		//转账
		TransferQuery transferQuery = new TransferQuery();
		transferQuery.setUserId(userId);
		List<TransferDto> transferDtoList = transferDao.selectByParams(transferQuery);
		HSSFRow[] transferRow = new HSSFRow[transferDtoList.size()+1];
		transferRow[0] = transferSheet.createRow(0);
		transferRow[0].createCell(0).setCellValue("id");
		transferRow[0].createCell(1).setCellValue("转出账户");
		transferRow[0].createCell(2).setCellValue("转入账户");
		transferRow[0].createCell(3).setCellValue("转出金额");
		transferRow[0].createCell(4).setCellValue("转入金额");
		transferRow[0].createCell(5).setCellValue("时间");
		transferRow[0].createCell(6).setCellValue("备注");
		for(int i=0,j=transferDtoList.size(); i<j; i++) {
			transferRow[i+1] = transferSheet.createRow(i+1);
			transferRow[i+1].createCell(0).setCellValue(transferDtoList.get(i).getId());
			transferRow[i+1].createCell(1).setCellValue(transferDtoList.get(i).getSrcAccountName());
			transferRow[i+1].createCell(2).setCellValue(transferDtoList.get(i).getDestAccountName());
			transferRow[i+1].createCell(3).setCellValue(transferDtoList.get(i).getSrcMoney());
			transferRow[i+1].createCell(4).setCellValue(transferDtoList.get(i).getDestMoney());
			
			//transferRow[i+1].createCell(5).setCellValue(transferDtoList.get(i).getTime());
			HSSFCell tempCell = transferRow[i+1].createCell(5);
			tempCell.setCellValue(transferDtoList.get(i).getTime());
			tempCell.setCellStyle(cellStyle);
			
			transferRow[i+1].createCell(6).setCellValue(transferDtoList.get(i).getRemark());
		}
		
		
		//借贷 
		LoanQuery loanQuery = new LoanQuery();
		loanQuery.setUserId(userId);
		List<LoanDto> loanDtoList = loanDao.selectByParams(loanQuery);
		HSSFRow[] loanRow = new HSSFRow[loanDtoList.size()+1];
		loanRow[0] = loanSheet.createRow(0);
		loanRow[0].createCell(0).setCellValue("id");
		loanRow[0].createCell(1).setCellValue("金额");
		loanRow[0].createCell(2).setCellValue("类型");
		loanRow[0].createCell(3).setCellValue("使用账户");
		loanRow[0].createCell(4).setCellValue("债权/债务人");
		loanRow[0].createCell(5).setCellValue("时间");
		loanRow[0].createCell(6).setCellValue("备注");
		for(int i=0,j=loanDtoList.size(); i<j; i++) {
			loanRow[i+1] = loanSheet.createRow(i+1);
			loanRow[i+1].createCell(0).setCellValue(loanDtoList.get(i).getId());
			loanRow[i+1].createCell(1).setCellValue(loanDtoList.get(i).getMoney());
			loanRow[i+1].createCell(2).setCellValue(loanDtoList.get(i).getTypeName());
			loanRow[i+1].createCell(3).setCellValue(loanDtoList.get(i).getAccountName());
			loanRow[i+1].createCell(4).setCellValue(loanDtoList.get(i).getLoanBodyAccountName());
			
			//loanRow[i+1].createCell(5).setCellValue(loanDtoList.get(i).getTime());
			HSSFCell tempCell = loanRow[i+1].createCell(5);
			tempCell.setCellValue(loanDtoList.get(i).getTime());
			tempCell.setCellStyle(cellStyle);
			
			loanRow[i+1].createCell(6).setCellValue(loanDtoList.get(i).getRemark());
		}
		
		return workbook;
	}
	
	
}
