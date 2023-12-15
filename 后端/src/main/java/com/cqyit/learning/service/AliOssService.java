package com.cqyit.learning.service;

/**
 * @author MrHee
 * @version 1.0
 * @interfaceName: AliOSSService
 * @date 2023/10/13 14:08
 * @description:
 */
public interface AliOssService {
    String UploadOSS(String dir, byte[] fileBytes, String imageType);
}
