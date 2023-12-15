package com.cqyit.learning.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.cqyit.learning.pojo.Category;
import com.cqyit.learning.pojo.Collection;
import com.cqyit.learning.pojo.Resources;

import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @className: IResourcesService
 * @date 2023/10/18 16:16
 * @description:
 */
public interface IResourcesService extends IService<Resources> {
    List<Category> getCategoryList();

    IPage<Resources> getResourcesList(int page, int size, String type);

    IPage<Resources> getResourcesList(int page, int size, String type, Long categoryId);

    List<Resources> getCollectionResources(Long id);

    Collection getCollectionInfo(Long id);
}
