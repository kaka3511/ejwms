package com.huaao.common.extension;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;


import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;


public class ExcelFormat {
		
		/**
		 * 获取指定的Excel
		 * @param url
		 * @return
		 * @throws BiffException
		 * @throws IOException
		 */
		public static WritableWorkbook copyfileExcel(String oldUrl,File file) throws BiffException, IOException{
			 Workbook book = Workbook.getWorkbook(new File(oldUrl));  
			 WritableWorkbook copybook =Workbook.createWorkbook(file,book); 
			 return copybook;
		}
		
		/**
		 * 根据传入的WorkBook和下标获取指定的Sheet
		 * @param book
		 * @param index
		 * @return
		 */
		public static Sheet getQuerySheetforIndex(Workbook book,int index){
			   Sheet sheet  =  book.getSheet( index );
			return sheet;  
		}
		
		

	    private static void customBufferBufferedStreamCopy(File source, File target) {  
	        InputStream fis = null;  
	        OutputStream fos = null;  
	        try {  
	            fis = new BufferedInputStream(new FileInputStream(source));  
	            fos = new BufferedOutputStream(new FileOutputStream(target));  
	            byte[] buf = new byte[4096];  
	            int i;  
	            while ((i = fis.read(buf)) != -1) {  
	                fos.write(buf, 0, i);  
	            }  
	        }  
	        catch (Exception e) {  
	            e.printStackTrace();  
	        } finally { 
	        	try {
					fis.close();
					fos.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	
	        }  
	    }  


		public static void main(String[] args) throws IOException, WriteException {
			WritableWorkbook copy=null;
			try {
				 copy=copyfileExcel("F:\\Users\\Desktop\\文卉苑社区患者登记表_20161124.xls",new File("F:\\Users\\Desktop\\Copy_文卉苑社区患者登记表_20161124.xls"));
				WritableSheet sheet = copy.getSheet(0);
				for (int i = 3; i < sheet.getRows(); i++) {
					
					for (int j = 0; j < sheet.getRow(i).length; j++) {
						System.out.print(sheet.getRow(i)[j].getContents()+"\t");
						//这里是获取行的固定的样式
						WritableCell cell = sheet.getWritableCell(3,i);
						Label qinghua = new Label(j,i,sheet.getRow(i)[j].getContents()+j,cell.getCellFormat());
						sheet.addCell(qinghua);
					}
					System.out.println();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}finally{
				copy.write();
				copy.close();
			}
		}
}
