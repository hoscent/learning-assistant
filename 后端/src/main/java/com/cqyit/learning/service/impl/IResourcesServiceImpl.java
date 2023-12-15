package com.cqyit.learning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.cqyit.learning.dao.CategoryDao;
import com.cqyit.learning.dao.CollectionDao;
import com.cqyit.learning.dao.ResourcesDao;
import com.cqyit.learning.pojo.Category;
import com.cqyit.learning.pojo.Collection;
import com.cqyit.learning.pojo.Resources;
import com.cqyit.learning.service.IResourcesService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;

/**
 * @author MrHee
 * @version 1.0
 * @className: IResourcesServiceImpl
 * @date 2023/10/18 16:17
 * @description:
 */
@Service
public class IResourcesServiceImpl extends ServiceImpl<ResourcesDao, Resources> implements IResourcesService {
    @Resource
    private ResourcesDao resourcesDao;
    @Resource
    private CategoryDao categoryDao;
    @Resource
    private CollectionDao collectionDao;

    @Override
    public List<Category> getCategoryList() {
        LambdaQueryWrapper<Category> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Category::getType, 1);
        lqw.eq(Category::getStatus, 1);
        return categoryDao.selectList(lqw);
    }

    @Override
    public IPage<Resources> getResourcesList(int page, int size, String type) {
        return getResourcesList(page, size, type, null);
    }

    @Override
    public IPage<Resources> getResourcesList(int page, int size, String type, Long categoryId) {
        LambdaQueryWrapper<Resources> lqw = new LambdaQueryWrapper<>();
        if (!Strings.isEmpty(type)) {
            lqw.eq(Resources::getType, type);
        }
        if (categoryId != null) {
            lqw.eq(Resources::getCategoryId, categoryId);
        }
        lqw.orderByDesc(Resources::getGmtModified);
        IPage<Resources> iPage = new Page<>(page, size);
        resourcesDao.selectPage(iPage, lqw);
        return iPage;
    }

    @Override
    public List<Resources> getCollectionResources(Long id) {
        LambdaQueryWrapper<Resources> lqw = new LambdaQueryWrapper<>();
        lqw.eq(Resources::getCollectionId, id);
        lqw.orderByAsc(Resources::getEpisodes);
        return resourcesDao.selectList(lqw);
    }

    @Override
    public Collection getCollectionInfo(Long id) {
        return collectionDao.selectById(id);
    }
}
