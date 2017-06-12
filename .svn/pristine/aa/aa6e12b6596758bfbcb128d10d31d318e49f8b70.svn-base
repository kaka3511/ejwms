/**
 * 
 */
package com.huaao.common.utilities;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;

/** 
* @ClassName: TwoDimensionCode 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author lj
* @date 2016年8月15日 上午10:34:43 
* 
* 
*/
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Shape;
import java.awt.Toolkit;
import java.awt.font.LineMetrics;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;  
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FilterInputStream;
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;  
  
import javax.imageio.ImageIO;
import javax.swing.JTextArea;
import javax.swing.JWindow;

import org.apache.log4j.Logger;

import com.swetake.util.Qrcode;

import jp.sourceforge.qrcode.QRCodeDecoder;  
import jp.sourceforge.qrcode.exception.DecodingFailedException;
import oracle.sql.CharacterBuffer;

import java.awt.image.BufferedImage;  

import jp.sourceforge.qrcode.data.QRCodeImage;  
  
public class TwoDimensionCode {  
	private static Font font;
	static{
		try {
			
			font = Font.createFont(Font.TRUETYPE_FONT, TwoDimensionCode.class.getResourceAsStream("font/MSYH.TTF"));
//			font = new Font("宋体", Font.PLAIN, 20);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
      private Logger log = Logger.getLogger(getClass());
    /** 
     * 生成二维码(QRCode)图片 
     * @param content 存储内容 
     * @param imgPath 图片路径 
     */  
    public void encoderQRCode(String content,String bottomInfo, String imgPath) {  
        this.encoderQRCode(content,  bottomInfo,imgPath, "png", 7);  
    }  
      
    /** 
     * 生成二维码(QRCode)图片 
     * @param content 存储内容 
     * @param output 输出流 
     */  
    public void encoderQRCode(String content, String bottomInfo,OutputStream output) {  
        this.encoderQRCode(content,  bottomInfo,output, "png", 7);  
    }  
      
    /** 
     * 生成二维码(QRCode)图片 
     * @param content 存储内容 
     * @param imgPath 图片路径 
     * @param imgType 图片类型 
     */  
    public void encoderQRCode(String content,String bottomInfo, String imgPath, String imgType) {  
        this.encoderQRCode(content,  bottomInfo,imgPath, imgType, 7);  
    }  
      
    /** 
     * 生成二维码(QRCode)图片 
     * @param content 存储内容 
     * @param output 输出流 
     * @param imgType 图片类型 
     */  
    public void encoderQRCode(String content,String bottomInfo, OutputStream output, String imgType) {  
        this.encoderQRCode(content, bottomInfo, output, imgType, 7);  
    }  
  
    /** 
     * 生成二维码(QRCode)图片 
     * @param content 存储内容 
     * @param imgPath 图片路径 
     * @param imgType 图片类型 
     * @param size 二维码尺寸 
     */  
    public void encoderQRCode(String content,String bottomInfo, String imgPath, String imgType, int size) {  
        try {  
            BufferedImage bufImg = this.qRCodeCommon(content,  bottomInfo,imgType, size);  
              
            File imgFile = new File(imgPath);  
            // 生成二维码QRCode图片  
            ImageIO.write(bufImg, imgType, imgFile);  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
  
    /** 
     * 生成二维码(QRCode)图片 
     * @param content 存储内容 
     * @param output 输出流 
     * @param imgType 图片类型 
     * @param size 二维码尺寸 
     */  
    public void encoderQRCode(String content, String bottomInfo,final OutputStream output, final String imgType, int size) {  
        try {  
            final BufferedImage bufImg = this.qRCodeCommon(content,  bottomInfo,imgType, size);
            // 生成二维码QRCode图片  
						ImageIO.write(bufImg, imgType, output);
            
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
      
    /** 
     * 生成二维码(QRCode)图片的公共方法 
     * @param content 存储内容 
     * @param imgType 图片类型 
     * @param size 二维码尺寸 
     * @return 
     */  
    private BufferedImage qRCodeCommon(String content,String bottomInfo, String imgType, int size) {  
    	log.info("======bottomInfo:"+bottomInfo);
    	
        BufferedImage bufImg = null;  
        BufferedImage outImg = null;
        try {  
            Qrcode qrcodeHandler = new Qrcode();  
            // 设置二维码排错率，可选L(7%)、M(15%)、Q(25%)、H(30%)，排错率越高可存储的信息越少，但对二维码清晰度的要求越小  
            qrcodeHandler.setQrcodeErrorCorrect('H');  
            qrcodeHandler.setQrcodeEncodeMode('B');  
            // 设置设置二维码尺寸，取值范围1-40，值越大尺寸越大，可存储的信息越大  
            qrcodeHandler.setQrcodeVersion(size);  
            // 获得内容的字节数组，设置编码格式  
            byte[] contentBytes = content.getBytes("utf-8");  
            
            // 图片尺寸  
            int imgSize = 67 + 12 * (size - 1);
//            int imgSizeH = imgSize+bottomHeight*6;  
            int imgSizeH = imgSize;
            bufImg = new BufferedImage(imgSize, imgSize, BufferedImage.TYPE_INT_RGB);
            Graphics2D gs = bufImg.createGraphics();  
            // 设置背景颜色  
            gs.setBackground(Color.WHITE);  
            gs.clearRect(0, 0, imgSize, imgSize);  
  
            // 设定图像颜色> BLACK  
            gs.setColor(Color.BLACK);  
            // 设置偏移量，不设置可能导致解析出错  
            int pixoff = 2;  
            // 输出内容> 二维码  
            if (contentBytes.length > 0 && contentBytes.length < 800) {  
                boolean[][] codeOut = qrcodeHandler.calQrcode(contentBytes);  
                for (int i = 0; i < codeOut.length; i++) {  
                    for (int j = 0; j < codeOut.length; j++) {  
                        if (codeOut[j][i]) {  
                            gs.fillRect(j * 3 + pixoff, i * 3 + pixoff, 3, 3);  
                        }  
                    }  
                } 
                gs.dispose();
                
                int r = 4;
                int widthExt = (imgSize*r);
                int heightExt = (imgSize*r);
                
                BufferedImage scaleBufImg = new BufferedImage(widthExt,heightExt,BufferedImage.TYPE_INT_RGB);
                Graphics2D scaleBufGS = (Graphics2D)scaleBufImg.getGraphics();
                
                scaleBufGS.setBackground(Color.white);
                scaleBufGS.clearRect(0, 0, widthExt,heightExt);
                scaleBufGS.drawImage(bufImg.getScaledInstance(widthExt,heightExt, Image.SCALE_SMOOTH), 0, 0,null);
                scaleBufGS.dispose();
                
                int bottomHeight = 20;
                font = font.deriveFont(Font.PLAIN, bottomHeight);
               FontMetrics fontMetric = Toolkit.getDefaultToolkit().getFontMetrics(font);
               int lineHeight = fontMetric.getHeight();;
               System.out.println(lineHeight);
               char[] bottimInfoChars = new char[bottomInfo.length()];
               bottomInfo.getChars(0, bottomInfo.length(), bottimInfoChars, 0);
               StringBuffer sb = new StringBuffer();
               StringBuffer sb2 = new StringBuffer();
               int lineCount=1;
              
               for (int i=0;i<bottimInfoChars.length;i++) {
            	   sb.append(bottimInfoChars[i]);
            	   
            	   int len = fontMetric.stringWidth(sb.toString());
            	   log.info(i+"   " + bottimInfoChars[i]);
            	   if(len>=widthExt||i==bottimInfoChars.length-1){
            		   int endIndex = 0;
            		   if(i==bottimInfoChars.length-1){
            			   endIndex = sb.length();
            		   }else{
            			   endIndex =  sb.length()-1;
            		   }
            		   log.info("==== drawing:"+sb.toString());
            		   
            		   lineCount++;
            		   sb = new StringBuffer();
            		   sb.append(bottimInfoChars[i]);
            	   }
            	   
               }
               
               BufferedImage bufFont = new BufferedImage(widthExt, lineHeight*(lineCount), BufferedImage.TYPE_INT_RGB);
               Graphics2D gsFont = bufFont.createGraphics();
               gsFont.setBackground(Color.WHITE);  
               gsFont.clearRect(0, 0, widthExt, lineHeight*(lineCount));  
               gsFont.setColor(Color.BLACK);  
              gsFont.setFont(font);
               
              lineCount=1;
              for (int i=0;i<bottimInfoChars.length;i++) {
           	   sb2.append(bottimInfoChars[i]);
           	   
           	   int len = fontMetric.stringWidth(sb2.toString());
           	   log.info(i+"   " + bottimInfoChars[i]);
           	   if(len>=widthExt||i==bottimInfoChars.length-1){
           		   int endIndex = 0;
           		   if(i==bottimInfoChars.length-1){
           			   endIndex = sb2.length();
           		   }else{
           			   endIndex =  sb2.length()-1;
           		   }
           		   log.info("==== drawing:"+sb2.toString());
           		gsFont.drawString(sb2.toString().substring(0, endIndex), 0, lineHeight*(lineCount));
           		   lineCount++;
           		   sb2 = new StringBuffer();
           		   sb2.append(bottimInfoChars[i]);
           	   }
           	   
              }
               
               
               
               outImg = new BufferedImage(widthExt,heightExt+bufFont.getHeight(),BufferedImage.TYPE_INT_RGB);
               Graphics2D outGS = (Graphics2D)outImg.getGraphics();
               
                outGS.setBackground(Color.white);
                outGS.clearRect(0, 0, widthExt,heightExt+bufFont.getHeight());
                outGS.drawImage(bufImg.getScaledInstance(widthExt,heightExt, Image.SCALE_SMOOTH), 0, 0,null);
                outGS.drawImage(bufFont, 0, heightExt, null);
                outGS.dispose();
            } else {  
                throw new Exception("QRCode content bytes length = " + contentBytes.length + " not in [0, 800].");  
            }  
           
            gs.dispose();  
//            outImg.flush();  
        } catch (Exception e) {  
            e.printStackTrace();  
        }  
        return outImg;  
    }  
    /** 
     * 解析二维码（QRCode） 
     * @param imgPath 图片路径 
     * @return 
     */  
    public String decoderQRCode(String imgPath) {  
        // QRCode 二维码图片的文件  
        File imageFile = new File(imgPath);  
        BufferedImage bufImg = null;  
        String content = null;  
        try {  
            bufImg = ImageIO.read(imageFile);  
            QRCodeDecoder decoder = new QRCodeDecoder();  
            content = new String(decoder.decode(new TwoDimensionCodeImage(bufImg)), "utf-8");   
        } catch (IOException e) {  
            System.out.println("Error: " + e.getMessage());  
            e.printStackTrace();  
        } catch (DecodingFailedException dfe) {  
            System.out.println("Error: " + dfe.getMessage());  
            dfe.printStackTrace();  
        }  
        return content;  
    }  
      
    /** 
     * 解析二维码（QRCode） 
     * @param input 输入流 
     * @return 
     */  
    public String decoderQRCode(InputStream input) {  
        BufferedImage bufImg = null;  
        String content = null;  
        try {  
            bufImg = ImageIO.read(input);  
            QRCodeDecoder decoder = new QRCodeDecoder();  
            content = new String(decoder.decode(new TwoDimensionCodeImage(bufImg)), "utf-8");   
        } catch (IOException e) {  
            System.out.println("Error: " + e.getMessage());  
            e.printStackTrace();  
        } catch (DecodingFailedException dfe) {  
            System.out.println("Error: " + dfe.getMessage());  
            dfe.printStackTrace();  
        }  
        return content;  
    }  
  
    public static void main(String[] args) {  
        String imgPath = "d:/Michael_QRCode.png";  
        String encoderContent = "aaaaaaaaaa";  
        TwoDimensionCode handler = new TwoDimensionCode();  
        handler.encoderQRCode(encoderContent,"分公司的风格是对方公司的风格第三方公司的风格十分的对方公司的风格", imgPath, "png",10);  
//      try {  
//          OutputStream output = new FileOutputStream(imgPath);  
//          handler.encoderQRCode(content, output);  
//      } catch (Exception e) {  
//          e.printStackTrace();  
//      }  
        System.out.println("========encoder success");  
          
          
        String decoderContent = handler.decoderQRCode(imgPath);  
        System.out.println("解析结果如下：");  
        System.out.println(decoderContent);  
        System.out.println("========decoder success!!!");  
    }  
}  


  
class TwoDimensionCodeImage implements QRCodeImage {  
  
    BufferedImage bufImg;  
      
    public TwoDimensionCodeImage(BufferedImage bufImg) {  
        this.bufImg = bufImg;  
    }  
      
    @Override  
    public int getHeight() {  
        return bufImg.getHeight();  
    }  
  
    @Override  
    public int getPixel(int x, int y) {  
        return bufImg.getRGB(x, y);  
    }  
  
    @Override  
    public int getWidth() {  
        return bufImg.getWidth();  
    }  
  
}  
