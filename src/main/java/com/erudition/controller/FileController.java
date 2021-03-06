package com.erudition.controller;

import com.erudition.bean.CategoryEntity;
import com.erudition.bean.FilesEntity;
import com.erudition.bean.UserEntity;
import com.erudition.dao.CategoryDao;
import com.erudition.dao.ConfigDao;
import com.erudition.dao.ResourcesDao;
import com.erudition.dao.UserDao;
import com.erudition.util.nlpir.WordFrequency;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sl on 16-5-3.
 */
@Controller
@RequestMapping("/admin/file")
public class FileController {

    @Autowired
    @Qualifier("resourcesDao")
    ResourcesDao resourcesDao;

    @Autowired
    @Qualifier("configDao")
    ConfigDao configDao;

    @Autowired
    @Qualifier("categoryDao")
    CategoryDao categoryDao;

    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;


    @RequestMapping(value = "/upload", method = RequestMethod.GET)
    public String upload(HttpSession session, Model model) {
        session.setAttribute("adminSidebarActive", 1);
        model.addAttribute("firstCategorys", categoryDao.getFirstCategory());
        List<FilesEntity> files = resourcesDao.getAll("FilesEntity");
        session.setAttribute("allfiles", files);
        return "admin/upload";
    }


    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String upload(String cate1, String cate2, String cate3,
                         @RequestParam MultipartFile[] files,  String keywords , String userid,HttpSession session) {

        System.out.println("发送了post你好请求");
        System.out.println("一级目录"+cate1);
        System.out.println("二级目录"+cate2);
        System.out.println("三级目录"+cate3);
        System.out.println("关键字"+keywords);
        for (MultipartFile file : files) {
            System.out.println("进入了文件");
            if (!file.isEmpty()) {
                System.out.println(file.getOriginalFilename());

                //int userid = (int) session.getAttribute("userid");
                System.out.println("userid: "+userid);
                UserEntity user = userDao.getById(Integer.valueOf(userid));



                String originalName = file.getOriginalFilename();

                String name = resourcesDao.saveFiles(cate1, cate2, cate3, keywords, originalName,file, user);


                //开始设置关联
                List<FilesEntity> allFilesInDatabase = resourcesDao.getAllFiles();
                setRelation(originalName, allFilesInDatabase, name);
            }

        }

        return "admin/upload";
    }


    @RequestMapping(value = "/download/{fid}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity download(@PathVariable("fid") int fid) throws IOException {
        FilesEntity file = resourcesDao.getById(fid);
        String dfileName = new String(file.getTitle().getBytes("gb2312"), "iso8859-1");
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", dfileName);
        File fileReal = new File(file.getUrl());
        return new ResponseEntity(FileUtils.readFileToByteArray(fileReal), headers, HttpStatus.CREATED);
    }


    /**
     * @param name setRelation方法中的name参数
     * @return 关键字组成的String数组
     */
    private String[] calculateKeywords(String name) {
        //获取关键字们
        return resourcesDao.getKeyWords();
    }

    /**
     *
     * @param originalName 文件真实名字
     * @param relations 与新文件有关联关系的全部文件的id组成的数组
     */

    private void setNewFileRelation(String originalName, List<Integer> relations) {
        List<FilesEntity> newfiles = resourcesDao.getByTitle(originalName);
        String newFileRelations = new String();
        //存在有关联文件时才执行文件关联动作
        for (int i : relations) {
            newFileRelations += i + ",";
        }
        newFileRelations = newFileRelations.substring(0, newFileRelations.lastIndexOf(","));
        for (FilesEntity f : newfiles) {
            f.setRelations(newFileRelations);
            resourcesDao.update(f);
            updateRelations(relations, f.getId());
        }
    }

    /**
     * @param relations 所有相关文件的id
     * @param newfileid 新文件的id
     */
    //当找出所有与新上传的文件有关联关系的文件id时
    //除了要设置新文件的relations字段，还要更新所有相关文件的relations字段
    private void updateRelations(List<Integer> relations, int newfileid) {
        for (int re : relations) {
            FilesEntity relationalfile = (FilesEntity) resourcesDao.getById(re);
            String relation = "";
            relation = relationalfile.getRelations();
            if(relation==null){
                relationalfile.setRelations(newfileid+"");
            }else{
                relationalfile.setRelations(relation + "," + newfileid);
            }

            resourcesDao.update(relationalfile);
        }
    }


    /**
     * @param originalName 上传文件的真实文件名
     * @param files        从session域中取出的全部文件，以背与新上传文件的比较
     * @param name         文件保存到本地时根据MD5算法以及当前系统时间计算出的文件名
     */
    private void setRelation(String originalName, List<FilesEntity> files, String name) {
        List<Integer> relations = new ArrayList<Integer>();
        String suffixName = originalName.substring(originalName.lastIndexOf(".") + 1);
        //目前只针对txt类型文件进行关键字计算
        //因为涉及到从session域中取数据，因此这部分逻辑必须在contoller中实现
        System.out.println("文件类型：-----------》"+suffixName);
      //  if (suffixName.equals("txt")) {
            System.out.println(originalName);
            String[] words = calculateKeywords(name);
            System.out.println("关键词:--------->");
            for(String w:words){
                System.out.println(w);
            }
            System.out.println("1213223423423412414134324234234143234123413");
            System.out.println("filessize:--------->"+files.toString());

            for (FilesEntity f : files) {
                int count = 0;
                String key = f.getKeywords();
                for (String word : words) {
                    if (key.contains(word)) {
                        count++;
                    }
                }
                System.out.println("count:---------->"+count);
                //从数据库中取出管理员设定的阈值:rule_relation
                int rule_relation = Integer.parseInt(configDao.getByKey("rule_relation"));
                if (count >= rule_relation) {
                    System.out.println("具有关联关系！！！！！！！");
                    if(f.getId()!=resourcesDao.getMaxId()){
                        relations.add(f.getId());
                        System.out.println("添加成功！！！！！！");
                    }

                }
                System.out.println("filename:     "+f.getTitle());
            }
            //认为此时已经得到了所有有关联的文件的id，于是开始设置新文件的relations字段
            if (!relations.isEmpty()) {
                System.out.println("relations.length:---->"+relations.size());
                for(int i:relations){
                    System.out.println("relations:"+i);
                }
                System.out.println("开始设置新文件的relations字段!!!!");
                setNewFileRelation(originalName, relations);
            }
            //此时没有与新文件有关联的文件，但也应该设置新文件的relations字段为词频统计结果
            else{
                List<FilesEntity> newfiles = resourcesDao.getByTitle(originalName);
                for(FilesEntity f:newfiles){
                    String thisfilekeywords = f.getKeywords();
                    for(String w:words){
                        thisfilekeywords=thisfilekeywords+w;
                    }
                    f.setKeywords(thisfilekeywords);
                    resourcesDao.update(f);
                }
            }
       // }
    }


}
