package com.huaao.common.extension;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;  
import org.jsoup.nodes.Element;  
import org.jsoup.select.Elements;  
public class VideoUtil {  
      
      
    public static Video getVideoInfo(String url){  
        Video video = new Video();  
          
        if(url.indexOf("v.youku.com")!=-1){  
            try {  
                video = getYouKuVideo(url);  
            } catch (Exception e) {  
                video = null;  
            }  
        }else if(url.indexOf("tudou.com")!=-1){  
            try {  
                video = getTudouVideo(url);  
            } catch (Exception e) {  
                video = null;  
            }  
        }else if(url.indexOf("v.ku6.com")!=-1){  
            try {  
                video = getKu6Video(url);  
            } catch (Exception e) {  
                video = null;  
            }  
        }else if(url.indexOf("6.cn")!=-1){  
            try {  
                video = get6Video(url);  
            } catch (Exception e) {  
                video = null;  
            }  
        }else if(url.indexOf("56.com")!=-1){  
            try {  
                video = get56Video(url);  
            } catch (Exception e) {  
                video = null;  
            }  
        }  
          
        return video;  
    }  
      
      
      
    public static Video getYouKuVideo(String url) throws Exception{  
        Document doc = getURLContent(url);  
          
          
        String pic = getElementAttrById(doc, "s_baidu1", "href");  
        int local = pic.indexOf("pic=");  
        pic = pic.substring(local+4);  
          
               
        //String flash = getElementAttrById(doc, "link2", "value");  
          
           
        //String time = getElementAttrById(doc, "download", "href");  
        //String []arrays = time.split("\\|");  
        //time = arrays[4];  
          
        Video video = new Video();  
        video.setPic(pic);  
        //video.setFlash(flash);  
        //video.setTime(time);  
          
        return video;  
    }  
      
      
      
    public static Video getTudouVideo(String url) throws Exception{  
        Document doc = getURLContent(url);  
        String content = doc.html();  
        int beginLocal = content.indexOf("");
        int endLocal = content.indexOf("");
        content = content.substring(beginLocal, endLocal);  
          
           
        String flash = getScriptVarByName("iid_code", content);  
        flash = "http://www.tudou.com/v/" + flash + "/v.swf";  
          
          
        String pic = getScriptVarByName("thumbnail", content);  
          
           
        String time = getScriptVarByName("time", content);  
  
        Video video = new Video();  
        video.setPic(pic);  
        video.setFlash(flash);  
        video.setTime(time);  
          
        return video;  
    }  
      
      
      
    public static Video getKu6Video(String url) throws Exception{  
        Document doc = getURLContent(url);  
          
          
        Element flashEt = doc.getElementById("outSideSwfCode");  
        String flash = flashEt.attr("value");  
          
          
        Element picEt = doc.getElementById("plVideosList");  
        String time = null;  
        String pic = null;  
        if(picEt!=null){  
            Elements pics = picEt.getElementsByTag("img");  
            pic = pics.get(0).attr("src");  
              
              
            Element timeEt = picEt.select("span.review>cite").first();   
            time = timeEt.text();  
        }else{  
            pic = doc.getElementsByClass("s_pic").first().text();  
        }  
          
        Video video = new Video();  
        video.setPic(pic);  
        video.setFlash(flash);  
        video.setTime(time);  
          
        return video;  
          
    }  
      
      
      
    public static Video get6Video(String url) throws Exception{  
        Document doc = getURLContent(url);  
          
          
        Element picEt = doc.getElementsByClass("summary").first();  
        String pic = picEt.getElementsByTag("img").first().attr("src");  
          
          
        String time = getVideoTime(doc, url, "watchUserVideo");  
        if(time==null){  
            time = getVideoTime(doc, url, "watchRelVideo");  
        }  
          
          
        Element flashEt = doc.getElementById("video-share-code");  
        doc = Jsoup.parse(flashEt.attr("value"));    
        String flash = doc.select("embed").attr("src");  
          
        Video video = new Video();  
        video.setPic(pic);  
        video.setFlash(flash);  
        video.setTime(time);  
          
        return video;  
    }  
      
      
      
    public static Video get56Video(String url) throws Exception{  
        Document doc = getURLContent(url);  
        String content = doc.html();  
          
          
        int begin = content.indexOf("img:");  
        content = content.substring(begin+7, begin+200);  
        int end = content.indexOf("};");  
        String pic = content.substring(0, end).trim();  
        pic = pic.replaceAll("\\", "");
          
          
        String flash = "http://player.56.com" + url.substring(url.lastIndexOf("/"), url.lastIndexOf(".html")) + ".swf";  
          
        Video video = new Video();  
        video.setPic(pic);  
        video.setFlash(flash);  
          
        return video;  
    }  
  
      
    private static String getVideoTime(Document doc, String url, String id) {  
        String time = null;  
          
        Element timeEt = doc.getElementById(id);   
        Elements links = timeEt.select("dt > a");  
          
          
        for (Element link : links) {  
          String linkHref = link.attr("href");  
          if(linkHref.equalsIgnoreCase(url)){  
              time = link.parent().getElementsByTag("em").first().text();  
              break;  
          }  
        }  
        return time;  
    }  
      
              
      
    private static String getScriptVarByName(String name, String content){  
        String script = content;  
          
        int begin = script.indexOf(name);  
          
        script = script.substring(begin+name.length()+2);  
          
        int end = script.indexOf(",");  
          
        script = script.substring(0,end);  
          
        String result=script.replaceAll("'", "");  
        result = result.trim();  
          
        return result;  
    }  
      
      
      
    private static String getElementAttrById(Document doc, String id, String attrName)throws Exception{  
        Element et = doc.getElementById(id);  
        String attrValue = et.attr(attrName);  
          
        return attrValue;  
    }  
      
      
      
      
    private static Document getURLContent(String url) throws Exception{  
    	Document doc = Jsoup.connect(url).get();
/*        Document doc = Jsoup.connect(url)  
          .data("query", "Java")  
          .userAgent("Mozilla")  
          .cookie("auth", "token")  
          .timeout(6000)  
          .post();  */
        return doc;  
    }  
      
      
    public static void main(String[] args) {  
        //String url = "http://v.youku.com/v_show/id_XMjU0MjI2NzY0.html";  
        //String url = "http://www.tudou.com/programs/view/pVploWOtCQM/";  
        //String url = "http://v.ku6.com/special/show_4024167/9t7p64bisV2A31Hz.html";  
        //String url = "http://v.ku6.com/show/BpP5LeyVwvikbT1F.html";  
        //String url = "http://6.cn/watch/14757577.html";  
        String url = "http://www.56.com/u64/v_NTkzMDEzMTc.html";  
        Video video = getVideoInfo(url);  
        System.out.println("视频缩略图："+video.getPic());  
        System.out.println("视频地址："+video.getFlash());  
        System.out.println("视频时长："+video.getTime());  
    }  
}  
