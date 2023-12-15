package com.cqyit.learning.service.impl;

import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.internal.OSSHeaders;
import com.aliyun.oss.model.CannedAccessControlList;
import com.aliyun.oss.model.ObjectMetadata;
import com.aliyun.oss.model.PutObjectRequest;
import com.aliyun.oss.model.StorageClass;
import com.cqyit.learning.service.AliOssService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import java.io.ByteArrayInputStream;
import java.util.UUID;

/**
 * @className: AliOSSServiceImpl
 * @author MrHee
 * @date 2023/10/13 14:12
 * @version 1.0
 * @description: 阿里云OSS服务
 */
@Service
public class AliOssServiceImpl implements AliOssService {
    @Value("${alicloud.oss.accessKeyId}")
    private String accessKeyId;
    @Value("${alicloud.oss.accessKeySecret}")
    private String accessKeySecret;
    @Value("${alicloud.oss.endpoint}")
    private String endpoint;
    @Value("${alicloud.oss.bucketName}")
    private String bucketName;

    /**
     * OSS文件上传
     * @param dir 存储目录文件
     * @param fileBytes 图片字节数组
     * @param imageType 图片后缀类型
     * @return 文件URL
     */
    @Override
    public String UploadOSS(String dir, byte[] fileBytes, String imageType) {
        String endpoint = "https://" + this.endpoint;
        // 填写Object完整路径,Object完整路径中不能包含Bucket名称。
        String objectName = dir + "/" + UUID.randomUUID() + "." + imageType;

        // 创建OSSClient实例。
        OSS ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);

        try {
            PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, objectName, new ByteArrayInputStream(fileBytes));
            // 设置存储权限
             ObjectMetadata metadata = new ObjectMetadata();
             metadata.setHeader(OSSHeaders.OSS_STORAGE_CLASS, StorageClass.Standard.toString());
             metadata.setObjectAcl(CannedAccessControlList.PublicRead);
             putObjectRequest.setMetadata(metadata);

             // 上传文件
            ossClient.putObject(putObjectRequest);
        } catch (OSSException oe) {
            System.out.println("Caught an OSSException, which means your request made it to OSS, "
                    + "but was rejected with an error response for some reason.");
            System.out.println("Error Message:" + oe.getErrorMessage());
            System.out.println("Error Code:" + oe.getErrorCode());
            System.out.println("Request ID:" + oe.getRequestId());
            System.out.println("Host ID:" + oe.getHostId());
        } finally {
            if (ossClient != null) {
                ossClient.shutdown();
            }
        }
        return "https://" + bucketName + "." + this.endpoint + "/" + objectName;
    }
}
