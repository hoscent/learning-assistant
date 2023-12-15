package com.cqyit.learning.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.cqyit.learning.common.utils.ResultUtil;
import com.cqyit.learning.pojo.Category;
import com.cqyit.learning.pojo.Collection;
import com.cqyit.learning.pojo.Resources;
import com.cqyit.learning.pojo.Signboard;
import com.cqyit.learning.service.IResourcesService;
import com.cqyit.learning.service.ISignboardService;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author MrHee
 * @version 1.0
 * @className: HomeController
 * @date 2023/10/15 21:32
 * @description:
 */
@RestController
@RequestMapping("/home")
public class HomeController {
    @Resource
    private ISignboardService signboardService;
    @Resource
    private IResourcesService resourcesService;

    @GetMapping("/signboard")
    public ResultUtil<List<Signboard>> getSignBoard(@RequestParam Integer type, @RequestParam Integer limit) {
        List<Signboard> signboardPage = signboardService.getSignboardPage(type, limit);
        return new ResultUtil<>(signboardPage);
    }

    @GetMapping("/resources/category")
    public ResultUtil<List<Category>> getCategory(){
        return new ResultUtil<>(resourcesService.getCategoryList());
    }

    @GetMapping("/resources")
    public ResultUtil<IPage<Resources>> getResources(@RequestParam int page, @RequestParam int pageSize, @RequestParam(required = false) String type, @RequestParam(required = false) Integer categoryId) {
        IPage<Resources> resourcesList;
        if (categoryId != null) {
            resourcesList = resourcesService.getResourcesList(page, pageSize, type, categoryId.longValue());
            if (page > resourcesList.getPages()) {
                resourcesList = resourcesService.getResourcesList((int) resourcesList.getPages(), pageSize, type, categoryId.longValue());
            }
        } else {
            resourcesList = resourcesService.getResourcesList(page, pageSize, type);
            if (page > resourcesList.getPages()) {
                resourcesList = resourcesService.getResourcesList((int) resourcesList.getPages(), pageSize, type);
            }
        }
        return new ResultUtil<>(resourcesList);
    }

    @GetMapping("/resources/detail")
    public ResultUtil<Resources> getResourcesById(@RequestParam Integer id) {
        Resources resources = resourcesService.getById(id);
        return new ResultUtil<>(resources);
    }

    @GetMapping("/resources/collection")
    public ResultUtil<Map<String, Object>> getCollection(@RequestParam Integer id) {
        List<Resources> collectionResources = resourcesService.getCollectionResources(id.longValue());
        Collection collectionInfo = resourcesService.getCollectionInfo(id.longValue());
        Map<String, Object> map = new HashMap<>();
        map.put("collection", collectionInfo);
        map.put("resources", collectionResources);
        return new ResultUtil<>(map);
    }
}
