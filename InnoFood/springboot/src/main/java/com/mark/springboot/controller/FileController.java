package com.mark.springboot.controller;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.mark.springboot.entity.Files;
import com.mark.springboot.entity.Shop;
import com.mark.springboot.mapper.FileMapper;
import com.mark.springboot.service.FileService;
import com.mark.springboot.service.ShopService;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@RestController
@RequestMapping("/file")
public class FileController {

    @Value("${files.upload.path}")
    private String fileUploadPath;

    @Resource
    private FileMapper fileMapper;

    @Autowired
    private FileService fileService;

    /**
     * 文件上传接口
     * @param file 前端传递过来的文件
     * @return
     * @throws IOException
     */

    @PostMapping("/upload")
    public String upload(@RequestParam MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        String type = FileUtil.extName(originalFilename);
         long size =  file.getSize();
         // 先存储到磁盘
        File uploadParentFile= new File(fileUploadPath);
        if(!uploadParentFile.exists()){
            uploadParentFile.mkdirs();
        }
        //定义一个文件唯一的标识码
        String uuid= IdUtil.fastSimpleUUID();
        String fileUUid = uuid + StrUtil.DOT + type;
        File uploadFile = new File(fileUploadPath + File.separator + fileUUid);
        //把获取到的文件存储到磁盘目录
        file.transferTo(uploadFile);
        String psrc = "http://localhost:9091/file/" + fileUUid;
        // 存储数据库
        Files saveFile = new Files();
        saveFile.setName(originalFilename);
        saveFile.setType(type);
        saveFile.setSize(size/1024);
        saveFile.setPsrc(psrc);
        fileMapper.insert(saveFile);
        return psrc;
    }

    /**
     * 文件下载接口    http://localhost:9091/file/{fileUUid}
     * @param fileUUid
     * @param response
     * @throws IOException
     */
    @GetMapping("/{fileUUid}")
    public void download(@PathVariable String fileUUid, HttpServletResponse response) throws IOException {
        // 根据文件的唯一标识码获取文件
        File uploadFile = new File(fileUploadPath + File.separator + fileUUid);
        // 设置输出流的格式
        ServletOutputStream os = response.getOutputStream();
        response.addHeader("Content-Dispositon","attachment;filename="+ URLEncoder.encode(fileUUid,"UTF-8"));
        response.setContentType("application/octet-stream");
        //读取文件的字节流
        os.write(FileUtil.readBytes(uploadFile));
        os.flush();
        os.close();
    }

    @PostMapping("/save")
    public Integer save(@RequestPart("file") MultipartFile file, @RequestPart("info") Files info) throws IOException {
        // 获取文件的原始文件名、类型和大小
        String originalFilename = file.getOriginalFilename();
        String type = FileUtil.extName(originalFilename);
        long size = file.getSize();

        // 定义文件的唯一标识码
        String fileUUid = info.getId() + StrUtil.DOT + type;

        // 将文件存储到磁盘
        File uploadFile = new File(fileUploadPath + File.separator + fileUUid);
        file.transferTo(uploadFile);

        // 更新数据库中的文件信息
        info.setName(originalFilename);
        info.setType(type);
        info.setSize(size/1024);
        info.setPsrc("http://localhost:9091/file/" + fileUUid);
        return fileService.save(info);
    }



    @GetMapping("/banner")
    public List<Files> findbanner(){
        return fileMapper.findbanner();
    }


}
